//
//  KKUIWebViewController.m
//  lwui
//
//  Created by Herson on 2018/1/5.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "KKUIWebViewController.h"
#import <WebKit/WebKit.h>

@interface KKUIWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) UIProgressView *progressView;

@end
@implementation KKUIWebViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //监听进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
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
    NSString *u = navigationAction.request.URL.absoluteString;
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    if ([u rangeOfString:@"//itunes.apple.com"].location !=NSNotFound) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:u]];
    }
}
@end
