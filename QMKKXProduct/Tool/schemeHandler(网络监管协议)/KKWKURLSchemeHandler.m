//
//  KKWKURLSchemeHandler.m
//  MotoVPN3
//
//  Created by Hansen on 5/13/21.
//  Copyright © 2021 力王. All rights reserved.
//

#import "KKWKURLSchemeHandler.h"
#import <WebKit/WebKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
NSString *KKWKURLSchemeHandlerJoyFishScheme = @"iosjoyfish";//监管ios请求
@interface KKWKURLSchemeHandler ()<WKURLSchemeHandler>
@property (strong, nonatomic) NSMutableDictionary *holdUrlSchemeTasks;

@end

@implementation KKWKURLSchemeHandler
- (instancetype)init{
    if (self = [super init]) {
        self.holdUrlSchemeTasks = [[NSMutableDictionary alloc] init];
    }
    return self;
}
+ (void)setupHTMLCache{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *markStrig = @"mk_html";
    NSString *fromPath = [NSString stringWithFormat:@"%@/%@",resourcePath,markStrig];
    NSString *toPath = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject,markStrig];
    //清空缓存
    NSError *flagError;
    [fileManager removeItemAtPath:toPath error:&flagError];
    NSError *error;
    //copy缓存
    [fileManager copyItemAtPath:fromPath toPath:toPath error:&error];
    if (!error) {
    }else{
        [NSException raise:@"copy文件错误" format:@"%@",error];
    }
}
//当 WKWebView 开始加载自定义scheme的资源时，会调用
- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask{
    self.holdUrlSchemeTasks[urlSchemeTask.description] = @(YES);
    //逻辑：每次启动，下载网络html，优先加载本地资源，本地没有加载网络资源化
    NSString *urlString = urlSchemeTask.request.URL.absoluteString;
    NSString *fileName = [urlString lastPathComponent];
    NSString *markStrig = @"mk_html/";
    NSRange range = [urlString rangeOfString:markStrig];
    if (range.location != NSNotFound) {
        fileName = [urlString substringFromIndex:range.location];
    }
    //资源路径
    NSString *mainBundlePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *htmlPath = [mainBundlePath stringByAppendingFormat:@"/"];
    NSString *filePath = [htmlPath stringByAppendingFormat:@"%@",fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSString *type = [self getMimeTypeWithFilePath:filePath];
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:urlSchemeTask.request.URL MIMEType:type expectedContentLength:data.length textEncodingName:nil];
        [urlSchemeTask didReceiveResponse:response];
        [urlSchemeTask didReceiveData:data];
        [urlSchemeTask didFinish];
    }else{
        NSString *schemeUrl = urlSchemeTask.request.URL.absoluteString;
        if ([schemeUrl hasPrefix:KKWKURLSchemeHandlerJoyFishScheme]) {
            schemeUrl = [schemeUrl stringByReplacingOccurrencesOfString:KKWKURLSchemeHandlerJoyFishScheme withString:@"http"];
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:schemeUrl]];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSNumber *number = self.holdUrlSchemeTasks[urlSchemeTask.description];
            BOOL flag = number.boolValue;
            if (flag == NO) {
                return;
            }
            if (response) {
                [urlSchemeTask didReceiveResponse:response];
            }else{
                NSURLResponse *response = [[NSURLResponse alloc] initWithURL:urlSchemeTask.request.URL MIMEType:@"空类型" expectedContentLength:data.length textEncodingName:nil];
                [urlSchemeTask didReceiveResponse:response];
            }
            [urlSchemeTask didReceiveData:data];
            if (error) {
                [urlSchemeTask didFailWithError:error];
            } else {
                [urlSchemeTask didFinish];
            }
        }];
        [dataTask resume];
    }
}
- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.holdUrlSchemeTasks[urlSchemeTask.description] = @(NO);
    });
}
//根据路径获取MIMEType
- (NSString *)getMimeTypeWithFilePath:(NSString *)filePath{
    CFStringRef pathExtension = (__bridge_retained CFStringRef)[filePath pathExtension];
    CFStringRef type = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, NULL);
    CFRelease(pathExtension);
    //The UTI can be converted to a mime type:
    NSString *mimeType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass(type, kUTTagClassMIMEType);
    if (type != NULL)
        CFRelease(type);
    return mimeType;
}

/// 下载HTML文件，实现缓存目的
/// @param items 需要下载的html文件集合
+ (void)downloadHTMLCache:(NSArray *)items{
    NSString *markStrig = @"mk_html/";
    //设置html存储路径
    NSString *mainBundlePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *htmlPath = [mainBundlePath stringByAppendingFormat:@"/%@",markStrig];
    //资源路径
    for (NSString *htmlURL in items) {
        //此方法相当于发送一个GET请求，直接将服务器的数据一次性下载下来
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSURL *url = [NSURL URLWithString:htmlURL];
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSString *fileName = [url lastPathComponent];
            NSString *filePath = [htmlPath stringByAppendingFormat:@"%@",fileName];
            if (![fileManager fileExistsAtPath:htmlPath]) {
                [fileManager createDirectoryAtPath:htmlPath withIntermediateDirectories:YES attributes:nil error:nil];
            };
            //数据存在
            if (data) {
                //判断文件是否存在
                if ([fileManager fileExistsAtPath:filePath]) {
                    //文件存在，存在对比差异，存在差异直接覆盖
                    NSData *oldData = [fileManager contentsAtPath:filePath];
                    if ([oldData isEqualToData:data]) {
                        //文件没有差异，不替换
                    }else{
                        //文件存在差异，先删除旧的文件再保存
                        NSError *error;
                        BOOL flag = [fileManager removeItemAtPath:filePath error:&error];
                        if (flag) {
                            //写入文件
                            [data writeToFile:filePath atomically:YES];
                        }else{
                            //失败
                            [NSException raise:@"删除文件错误，请注意" format:@"%@",error];
                        }
                    }
                }else{
                    //文件不存在，直接写入文件
                    [data writeToFile:filePath atomically:YES];
                }
            }else{
                //数据加载失败，不做处理
            }
        });
    }
}

/// 盘点HTML缓存是否存在
/// @param requestURL html地址
+ (NSURL *)htmlFileExistsAtPath:(NSURL *)requestURL{
    NSString *urlString = requestURL.absoluteString;
    NSString *fileName = [urlString lastPathComponent];
    NSString *markStrig = @"mk_html/";
    NSRange range = [urlString rangeOfString:markStrig];
    if (range.location != NSNotFound) {
        fileName = [urlString substringFromIndex:range.location];
    }
    //资源路径
    NSString *mainBundlePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *htmlPath = [mainBundlePath stringByAppendingFormat:@"/"];
    NSString *filePath = [htmlPath stringByAppendingFormat:@"%@",fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL flag = [fileManager fileExistsAtPath:filePath];
    if (flag) {
        requestURL = [requestURL.absoluteString stringByReplacingOccurrencesOfString:@"http" withString:KKWKURLSchemeHandlerJoyFishScheme].toURL;
    }
    return requestURL;
}
//-(NSData *)contentsAtPath:path    从path所代表的文件中读取数据
//-(BOOL)createFileAtPath:path contents:(BOOL)data attributes:attr    将数据写入文件
//-(BOOL)removeFileAtPath:path handler:handler    将path所代表的文件删除
//-(BOOL)movePath:from toPath:to handler:handler    移动或者重命名文件，to所代表的文件不能是已经存在的文件
//-(BOOL)copyPath:from toPath:to handler:handler    复制文件，to所代表的文件不能是已经存在的文件
//-(BOOL)contentsEqualAtPath:path1 andPath:path2    比较path1和path2所代表的文件
//-(BOOL)fileExistsAtPath:path    检查path所代表的文件是否存在
//-(BOOL)isReadableFileAtPath:path    检查path所代表的文件是否存在、是否可读
//-(BOOL)isWritableFileAtPath:path    检查path所代表的文件是否存在、是否可写
//-(NSDictionary *)fileAttributesAtPath:path traverseLink:(BOOL)flag    获取path所代表的文件属性
//-(BOOL)changeFileAttributes:attr atPath:path    改变文件属性

@end
