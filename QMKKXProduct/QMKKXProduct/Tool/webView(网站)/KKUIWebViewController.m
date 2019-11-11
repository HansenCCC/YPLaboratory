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
    UIImage *itemImg = UIImageWithName(@"kk_bee_back");
    self.backBtnImage = itemImg;
    //web配置
    [self webViewConfig];
    [self addObserverNotification];
}
//web配置
- (void)webViewConfig{
    //监听进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //清空web缓存
    [self deleteWebCache];
    [self addScriptMessageHandler];
}
//刷新webview
- (void)loadWebData{
    [self deleteWebCache];
    NSString *oldStrig = self.requestURL.absoluteString;
    NSString *urlString = [self formatTokenWithURLString:oldStrig];
    [self removeScriptMessageHandlerForName];
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    self.webView = nil;
    [self webViewConfig];
    self.requestURL = urlString.toURL;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebData) name:kNSNotificationCenterLogout object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebData) name:kNSNotificationCenterDidLogin object:nil];
}
//添加js交互
- (void)addScriptMessageHandler{
    WKWebViewConfiguration *configuration = self.webView.configuration;
    [configuration.userContentController addScriptMessageHandler:self name:@"bbsReback"];
    [configuration.userContentController addScriptMessageHandler:self name:@"Share"];
    [configuration.userContentController addScriptMessageHandler:self name:@"bbsSendReply"];
    [configuration.userContentController addScriptMessageHandler:self name:@"bbsBarHidden"];
    [configuration.userContentController addScriptMessageHandler:self name:@"MetooLogin"];
    [configuration.userContentController addScriptMessageHandler:self name:@"closePage"];
    [configuration.userContentController addScriptMessageHandler:self name:@"toLogin"];
}
//移除js交互
- (void)removeScriptMessageHandlerForName{
    WKWebViewConfiguration *configuration = self.webView.configuration;
    [configuration.userContentController removeScriptMessageHandlerForName:@"bbsReback"];
    [configuration.userContentController removeScriptMessageHandlerForName:@"Share"];
    [configuration.userContentController removeScriptMessageHandlerForName:@"bbsSendReply"];
    [configuration.userContentController removeScriptMessageHandlerForName:@"bbsBarHidden"];
    [configuration.userContentController removeScriptMessageHandlerForName:@"MetooLogin"];
    [configuration.userContentController removeScriptMessageHandlerForName:@"closePage"];
    [configuration.userContentController removeScriptMessageHandlerForName:@"toLogin"];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.webView.frame = f1;
    
    CGRect f2 = bounds;
    f2.size = [self.progressView sizeThatFits:CGSizeZero];
    f2.size.width = bounds.size.width;
    self.progressView.frame = f2;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
    }
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
    [[[UIAlertView alloc] initWithTitle:@"请求失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURLRequest *request = navigationAction.request;
    NSMutableURLRequest *mutRequest = [request mutableCopy];
    NSString *urlString = request.URL.absoluteString;
    NSString *oldStrig = self.requestURL.absoluteString;
    //WKNavigationActionPolicyCancel 不是我们拦截的 || WKNavigationActionPolicyAllow 使我们拦截的
    //允许跳转
    if ([urlString rangeOfString:@"//itunes.apple.com"].location !=NSNotFound) {
        //跳转其他界面进行下载
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        decisionHandler(WKNavigationActionPolicyAllow);
    }else if ([urlString isKindOfClass:[NSString class]]) {
        if([urlString hasPrefix:@"metoologin"]) {
            //跳转登录界面
            [[KKUser shareInstance] postNotificationToLogging];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else if (![urlString hasPrefix:oldStrig]) {
            //如果当前的页面 需要终止
            decisionHandler(WKNavigationActionPolicyAllow);
            return;
        }
    }
    if ([urlString hasPrefix:API_HOST]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }else {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
}
#pragma mark - WKScriptMessageHandler
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    //to do
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%@ - %@",message.name,message.body);
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([message.name isEqualToString:@"bbsReback"]||[message.name isEqualToString:@"closePage"]) {
            if (self.whenComplete) {
                if ([message.body isEqualToString:@"refresh"]) {
                    self.whenComplete(YES);
                }else{
                    self.whenComplete(NO);
                }
            }
            [self backItemClick];
        }else if ([message.name isEqualToString:@"Share"]) {
            NSDictionary *shareDic = message.body;
            if ([shareDic isKindOfClass:[NSDictionary class]]) {
                //弹起分享框
                [self showError:[@"敬请期待 " addString:message.name]];
            }
        }else if ([message.name isEqualToString:@"MetooLogin"]||[message.name isEqualToString:@"toLogin"]) {
            //弹起登录框
            [[KKUser shareInstance] postNotificationToLogging];
        }
    });
}
#pragma mark - 拼接token
- (NSString *)formatTokenWithURLString:(NSString *)urlString{
    BOOL isLogin = [KKUser shareInstance].isLogin;
    if (isLogin) {
        NSString *oldTokenString = [NSString stringWithFormat:@"%@",urlString];
        NSString *markString = @"token=";
        NSRange range1 = [oldTokenString rangeOfString:markString];
        if (range1.location == NSNotFound) {
            return urlString;
        }
        oldTokenString = [oldTokenString substringWithRange:NSMakeRange(range1.location, oldTokenString.length - range1.location)];
        NSRange range2 = [oldTokenString rangeOfString:@"&"];
        if (range2.location == NSNotFound) {
            return urlString;
        }
        oldTokenString = [oldTokenString substringWithRange:NSMakeRange( 0, range2.location)];
        NSString *oldTokenFormat = [NSString stringWithFormat:@"%@",oldTokenString];
        NSString *tokenFormat = [NSString stringWithFormat:@"token=%@",[KKUser shareInstance].token];
        NSString *userId = [NSString stringWithFormat:@"%@",[KKUser shareInstance].userModel.userId];
        if ([oldTokenFormat isEqualToString:tokenFormat]) {
            //包含正确token
            //to do
            return urlString;
        }else{
            //未包含正确token
            urlString = [urlString stringByReplacingOccurrencesOfString:oldTokenFormat withString:tokenFormat];
            urlString = [urlString stringByReplacingOccurrencesOfString:@"user_id=&" withString:[NSString stringWithFormat:@"user_id=%@&",userId]];
            return urlString;
        }
    }else{
        return urlString;
    }
}
#pragma mark - 清空缓存
- (void)deleteWebCache{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                        WKWebsiteDataTypeDiskCache,
                                                        WKWebsiteDataTypeMemoryCache,
                                                        WKWebsiteDataTypeLocalStorage,
                                                        WKWebsiteDataTypeCookies,
                                                        WKWebsiteDataTypeSessionStorage,
                                                        WKWebsiteDataTypeIndexedDBDatabases,
                                                        WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            //to do
        }];
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] completionHandler:^(NSArray * __nonnull records) {
            for (WKWebsiteDataRecord *record in records){
                [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes forDataRecords:@[record] completionHandler:^{
                    NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                }];
            }
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}
@end
