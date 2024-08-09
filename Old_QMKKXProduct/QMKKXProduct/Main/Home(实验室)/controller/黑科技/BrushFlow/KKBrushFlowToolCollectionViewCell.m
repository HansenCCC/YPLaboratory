//
//  KKBrushFlowToolCollectionViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 2021/9/10.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKBrushFlowToolCollectionViewCell.h"

@interface KKBrushFlowToolCollectionViewCell ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@end

@implementation KKBrushFlowToolCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    [self.contentView addSubview:self.webView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    self.webView.frame = bounds;
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

#pragma mark - WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (self.whenCompleteBlock) {
        self.whenCompleteBlock(YES);
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if (self.whenCompleteBlock) {
        self.whenCompleteBlock(NO);
    }
}

@end
