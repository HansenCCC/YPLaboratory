//
//  YPViewController.m
//  YPUIKit-ObjC
//
//  Created by Hansen on 2022/9/1.
//

#import "YPH5WebviewController.h"
#import <WebKit/WebKit.h>
#import "UIColor+YPExtension.h"
#import "YPButton.h"
#import "YPKitDefines.h"

@interface YPH5WebviewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation YPH5WebviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self setNavBarButtonItem];
    [self addObserverForKeyPath];
    [self addObserverNotification];
    [self addScriptMessageHandler];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeScriptMessageHandlerForName];
}

- (void)setupSubviews {
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
}

- (void)setNavBarButtonItem {
    YPButton *leftButton = [YPButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(0, 0, 44.f, 44.f);
    leftButton.layer.cornerRadius = leftButton.frame.size.height / 2.f;
    [leftButton setImage:[UIImage imageNamed:@"yp_icon_back"] forState:UIControlStateNormal];
    leftButton.imageSize = CGSizeMake(24.f, 24.f);
    [leftButton setTitle:@" " forState:UIControlStateNormal];
    leftButton.interitemSpacing = 10.f;
    leftButton.tintColor = [UIColor yp_blackColor];
    leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [leftButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)backItemClick {
    [self removeScriptMessageHandlerForName];
    if (self.navigationController && [self.navigationController.viewControllers indexOfObject:self] != 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)addObserverNotification {
    
}

- (void)addObserverForKeyPath {
    /// 监听进度条
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    /// 简体标题
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)addScriptMessageHandler {
    // 添加js方法，当h5调用此方法，将会被监听到
    WKWebViewConfiguration *configuration = self.webView.configuration;
    [configuration.userContentController addScriptMessageHandler:self name:@"shareContent"];
}

- (void)removeScriptMessageHandlerForName {
    // 异常js方法，不移除则会造成循环引用
    WKWebViewConfiguration *configuration = self.webView.configuration;
    [configuration.userContentController removeScriptMessageHandlerForName:@"shareContent"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.webView.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = [self.progressView sizeThatFits:CGSizeZero];
    f2.size.width = bounds.size.width;
    self.progressView.frame = f2;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    } else if (object == self.webView && [keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title?:@"";
    }
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - setters | getters

- (void)setRequest:(NSURLRequest *)request {
    _request = request;
    [self.webView loadRequest:request];
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures=YES;
        _webView.UIDelegate = self;
        _webView.backgroundColor = [UIColor yp_colorWithHexString:@"#FFFFFF"];
        _webView.scrollView.backgroundColor = [UIColor yp_colorWithHexString:@"#FFFFFF"];
    }
    return _webView;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //'UIAlertView' is deprecated: first deprecated in iOS 9.0 - UIAlertView is deprecated. Use UIAlertController with a preferredStyle of UIAlertControllerStyleAlert instead
    [[[UIAlertView alloc] initWithTitle:@"请求失败" message:@"请检查您的网络" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
    #pragma clang diagnostic pop
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKScriptMessageHandler

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // 在Objective-C中执行JavaScript并发送消息
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([message.name isEqualToString:@"shareContent"]) {
            
        }
    });
}

@end
