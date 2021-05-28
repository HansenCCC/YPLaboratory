//
//  KKHtmlBoxAlert.m
//  QMKKXProduct
//
//  Created by Hansen on 5/28/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKHtmlBoxAlert.h"

@interface KKHtmlBoxAlert ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property(nonatomic, strong) UIProgressView *progressView;

@end

@implementation KKHtmlBoxAlert
- (void)setupSubViews{
    [super setupSubViews];
    //web配置
    [self webViewConfig];
}
- (CGFloat)contentWidth{
    CGRect bounds = self.view.bounds;
    return bounds.size.width - AdaptedWidth(40.f);
}
- (void)displayContentWillLayoutSubviews{
    [super displayContentWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    //自动布局
    CGRect f1 = self.contentView.bounds;
    //
    CGRect f3 = bounds;
    f3.origin.y = CGRectGetMaxY(self.titleLabel.frame) + AdaptedWidth(10.f);
    f3.origin.x = AdaptedWidth(10.f);
    f3.size.width = f1.size.width - 2 * f3.origin.x;
    f3.size.height = AdaptedWidth(300.f);
    self.webView.frame = f3;
    self.displayContentView = self.webView;
    //
    CGRect f2 = f3;
    f2.size = [self.progressView sizeThatFits:CGSizeZero];
    f2.size.width = f3.size.width;
    self.progressView.frame = f2;
}
//web配置
- (void)webViewConfig{
    [self addObserverForKeyPath];//kvo
    [self deleteWebCache];//清空web缓存
    [self addScriptMessageHandler];
    [self addObserverNotification];//通知
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
    
}
//移除js交互
- (void)removeScriptMessageHandlerForName{
    
}
- (void)deleteWebCache{
    
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
#pragma mark - lazy load
-(UIProgressView *)progressView{
    if(!_progressView){
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
        [self.contentView addSubview:_progressView];
    }
    return _progressView;
}
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures=YES;
        _webView.UIDelegate = self;
        _webView.backgroundColor = KKColor_F2F2F7;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_webView];
    }
    return _webView;
}
/// html提示框
/// @param headTitle 标题
/// @param textDetail  内容
/// @param leftTitle 左边标题
/// @param rightTitle 右边标题
/// @param request 请求
/// @param isOnlyOneButton 是否是有一个按钮 default NO
/// @param isShowCloseButton 是否显示关闭按钮 default YES
/// @param canTouchBeginMove 是否点击空白消失 default YES
/// @param whenCompleteBlock 成功回调
+ (KKHtmlBoxAlert *)showCustomWithTitle:(NSString *)headTitle
                                       textDetail:(NSString *)textDetail
                                       leftTitle:(NSString *)leftTitle
                                       rightTitle:(NSString *)rightTitle
                                request:(NSURLRequest *)request
                                    isOnlyOneButton:(BOOL )isOnlyOneButton
                                    isShowCloseButton:(BOOL )isShowCloseButton
                                    canTouchBeginMove:(BOOL )canTouchBeginMove
                                      complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    UIWindow *windows = [UIApplication sharedApplication].delegate.window;
    UIViewController *topVC = windows.topViewController;
    //预防重复弹框
    if ([topVC isKindOfClass:[KKUIBasePresentController class]]) {
        return nil;
    }
    KKHtmlBoxAlert *vc = [[KKHtmlBoxAlert alloc] initWithPresentType:KKUIBaseMiddlePresentType];
    vc.headTitle = headTitle;
    vc.textDetail = textDetail;
    vc.leftTitle = leftTitle;
    vc.rightTitle = rightTitle;
    vc.whenCompleteBlock = whenCompleteBlock;
    vc.isOnlyOneButton = isOnlyOneButton;
    vc.isShowCloseButton = isShowCloseButton;
    vc.canTouchBeginMove = canTouchBeginMove;
    [vc.webView loadRequest:request];
    [topVC presentViewController:vc animated:YES completion:nil];
    return vc;
}
@end
