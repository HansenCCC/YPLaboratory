//
//  KKUIWebViewController.m
//  lwui
//
//  Created by Herson on 2018/1/5.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "KKUIWebViewController.h"

@interface KKUIWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property(nonatomic, strong) UIProgressView *progressView;

@end
@implementation KKUIWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *itemImg = UIImageWithName(@"kk_icon_back");
    self.backBtnImage = itemImg;
    //web配置
    [self webViewConfig];
}
//web配置
- (void)webViewConfig{
    [self addObserverForKeyPath];//kvo
    [self deleteWebCache];//清空web缓存
    [self addScriptMessageHandler];
    [self addObserverNotification];//通知
}
- (void)backItemClick{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else {
        [self removeScriptMessageHandlerForName];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)setRequestURL:(NSURL *)requestURL{
    _requestURL = requestURL;
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    [self.webView loadRequest:request];
}
- (void)loadRequest:(NSURLRequest *)request{
    [self.webView loadRequest:request];
}
- (void)loadHTMLString:(NSString *)string{
    [self.webView loadHTMLString:string baseURL:nil];
}
//添加通知
- (void)addObserverNotification{
    
}
- (void)addObserverForKeyPath{
    //监听进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
//添加js交互
- (void)addScriptMessageHandler{
    WKWebViewConfiguration *configuration = self.webView.configuration;
    [configuration.userContentController addScriptMessageHandler:self name:@"Share"];
}
//移除js交互
- (void)removeScriptMessageHandlerForName{
//    WKWebViewConfiguration *configuration = self.webView.configuration;
//    [configuration.userContentController removeScriptMessageHandlerForName:@"Share"];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.webView.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = [self.progressView sizeThatFits:CGSizeZero];
    f2.size.width = bounds.size.width;
    f2.origin.y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.progressView.frame = f2;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }else if (object == self.webView && [keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title?:@"";
    }
}
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}
#pragma mark - lazy load
-(UIProgressView *)progressView{
    if(!_progressView){
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
        [self.view addSubview:_progressView];
    }
    return _progressView;
}
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures=YES;
        _webView.UIDelegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //'UIAlertView' is deprecated: first deprecated in iOS 9.0 - UIAlertView is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleAlert instead
    [[[UIAlertView alloc] initWithTitle:@"请求失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
    #pragma clang diagnostic pop
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark - WKScriptMessageHandler
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    //to do
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%@ - %@",message.name,message.body);
    dispatch_async(dispatch_get_main_queue(), ^{
        //to do
    });
}
#pragma mark - 清空缓存
- (void)deleteWebCache{
    //不做清理缓存操作
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
//        NSSet *websiteDataTypes = [NSSet setWithArray:@[
//                                                        WKWebsiteDataTypeDiskCache,
//                                                        WKWebsiteDataTypeMemoryCache,
//                                                        WKWebsiteDataTypeLocalStorage,
//                                                        WKWebsiteDataTypeCookies,
//                                                        WKWebsiteDataTypeSessionStorage,
//                                                        WKWebsiteDataTypeIndexedDBDatabases,
//                                                        WKWebsiteDataTypeWebSQLDatabases
//                                                        ]];
//        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
//        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
//            //to do
//        }];
//        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
//        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] completionHandler:^(NSArray * __nonnull records) {
//            for (WKWebsiteDataRecord *record in records){
//                [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes forDataRecords:@[record] completionHandler:^{
//                    NSLog(@"Cookies for %@ deleted successfully",record.displayName);
//                }];
//            }
//        }];
//    } else {
//        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
//        NSError *errors;
//        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
//    }
}
@end
