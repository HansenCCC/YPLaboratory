//
//  YPAppH5PopupController.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/29.
//

#import "YPAppH5PopupController.h"
#import <WebKit/WebKit.h>

@interface YPAppH5PopupController () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation YPAppH5PopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isEnableTouchMove = YES;
    self.contentView.layer.cornerRadius = 10.f;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.webView];
    [self.contentView addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)popupLayoutSubviews {
    [super popupLayoutSubviews];
    CGRect bounds = self.contentView.bounds;
    
    CGRect f1 = bounds;
    f1.origin.x = 10.f;
    f1.origin.y = 0.f;
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    f1.size.height = 44.f;
    self.titleLabel.frame = f1;
    
    CGRect f2 = bounds;
    f2.origin.x = f1.origin.x;
    f2.origin.y = CGRectGetMaxY(f1) + 5.f;
    f2.size.width = bounds.size.width - f2.origin.x * 2;
    f2.size.height = bounds.size.width - f2.origin.x * 2 + 50.f;
    self.webView.frame = f2;
    //
    CGRect f3 = bounds;
    f3.size = [self.progressView sizeThatFits:CGSizeZero];
    f3.size.width = bounds.size.width;
    f3.origin.y = f2.origin.y;
    self.progressView.frame = f3;
    
    CGRect f4 = self.contentView.frame;
    f4.origin.x = (self.view.bounds.size.width - f4.size.width) / 2.f;
    f4.size.height = CGRectGetMaxY(f2) + 10.f;
    f4.origin.y = (self.view.bounds.size.height - f4.size.height) / 2.f;
    self.contentView.frame = f4;
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
    }
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - setters | getters

- (void)setH5Title:(NSString *)h5Title {
    _h5Title = h5Title;
    self.titleLabel.text = h5Title;
}

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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor yp_darkColor];
        _titleLabel.font = [UIFont systemFontOfSize:17.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
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

@end
