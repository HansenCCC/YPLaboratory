//
//  KKControlURLProtocol.m
//  MotoVPN3
//
//  Created by Hansen on 5/12/21.
//  Copyright © 2021 力王. All rights reserved.
//

#import "KKControlURLProtocol.h"

static NSString *const MTControlURLRequestURLProtocolKey = @"MTControlURLRequestURLProtocolKey";

@interface KKControlURLProtocol ()<NSURLSessionDelegate>
@property (nonnull, strong) NSURLSessionDataTask *task;

@end

@implementation KKControlURLProtocol
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    return [super requestIsCacheEquivalent:a toRequest:b];
}
/// 可以通过请求来初始化 （谷歌直译 ---此方法确定此协议是否可以处理给定的请求。@讨论一个具体的子类应该检查给定的请求并确定实现是否可以通过以下方式执行加载该请求。 这是一种抽象方法。 子类必须提供执行。如果协议可以处理给定的请求，则为YES，否则为否）
/// @param request 请求参数
+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
//    //判断本地是否缓存资源
//    NSString *fileName = [request.URL lastPathComponent];
//    NSString *markStrig = @"mk_html/";
//    //资源路径
//    NSString *urlStrig = request.URL.absoluteString;
//    NSRange range = [urlStrig rangeOfString:markStrig];
//    if (range.location != NSNotFound) {
//        fileName = [urlStrig substringFromIndex:range.location];
//    }
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
////    if (filePath.length == 0&&[fileName containsString:@".html"]) {
//    if (filePath.length == 0) {
//        //不存在资源，不处理请求
//        return NO;
//    }
    NSString *scheme = [[request URL] scheme];
    NSLog(@"🚀🚀🚀🚀🚀🚀🚀🚀🚀%@🚀🚀🚀🚀🚀🚀🚀🚀🚀",request.URL.absoluteURL);
    if ([scheme caseInsensitiveCompare:@"customScheme"] == NSOrderedSame ){
        //看看是否已经处理过了，防止无限循环
        if ([NSURLProtocol propertyForKey:MTControlURLRequestURLProtocolKey inRequest:request]){
            return NO;
        }
        return YES;
    }
    return NO;
}
/// 重写规范请求 (谷歌直译----协议应该确保相同的输入请求始终产生相同的结果规范形式。 何时应给予特别考虑因为请求的规范形式是用于在URL缓存中查找对象，该过程执行NSURLRequest对象之间的相等性检查。)
/// @param request 请求参数
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    NSString *fileName = [request.URL lastPathComponent];
    NSString *markStrig = @"mk_html/";
    //资源路径
    NSString *urlStrig = request.URL.absoluteString;
    NSRange range = [urlStrig rangeOfString:markStrig];
    if (range.location != NSNotFound) {
        fileName = [urlStrig substringFromIndex:range.location];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if (filePath.length > 0&&![fileName containsString:@".html"]) {
//    if (filePath.length > 0) {
        NSURL *url = [NSURL fileURLWithPath:filePath];
        mutableReqeust.URL = url;
    }else{
        mutableReqeust.URL = @"http://test.tvimg.cn/mk_html/mk-new-pay.html".toURL;
    }
    return mutableReqeust;
}
//启动特定于协议的请求加载。调用此方法时，协议实现应该开始加载请求。
- (void)startLoading{
    NSMutableURLRequest *request = self.request.mutableCopy;
    [NSURLProtocol setProperty:@YES forKey:MTControlURLRequestURLProtocolKey inRequest:request];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    self.task = [session dataTaskWithRequest:self.request];
    [self.task resume];
}
- (void)stopLoading{
    if (self.task != nil) {
        [self.task cancel];
    }
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"\n⚠️⚠️⚠️⚠️%@⚠️⚠️⚠️\n",self.request.URL);
    if ([self.request.URL.absoluteString containsString:@"listAirLine"]) {
        
    }
    [[self client] URLProtocol:self didReceiveResponse:httpResponse cacheStoragePolicy:NSURLCacheStorageAllowed];
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [[self client] URLProtocol:self didLoadData:data];
//    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    [self.client URLProtocolDidFinishLoading:self];
}
@end
