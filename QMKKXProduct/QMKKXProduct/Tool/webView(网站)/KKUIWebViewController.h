//
//  KKUIWebViewController.h
//  lwui
//  封装webview
//  Created by Herson on 2018/1/5.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "KKBaseViewController.h"
/*
 帖子传参
 //帖子链接 加参数 ：article_id、token、platform（1：android； 2：IOS）、user_id  再确认下
 
 js交互
 //关闭当前页面：closePage()
 ios：window.webkit.messageHandlers.toLogin.postMessage()
 android：verify.toLogin()
 
 
 web -> js 例如
    增加监听
    WKWebViewConfiguration *configuration = self.webView.configuration;
    [configuration.userContentController addScriptMessageHandler:self name:@"goBack"];
    接收监听
    - (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
 
 js -> web 例如
    [self.webView evaluateJavaScript:@"window.loadComment()" completionHandler:nil];
 
 */
@interface KKUIWebViewController : KKBaseViewController
@property (nonatomic,   copy) void(^whenComplete)(BOOL refresh);//是否刷新
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSURL *requestURL;

//加载网页
- (void)loadRequest:(NSURLRequest *)request;
//加载HTML
- (void)loadHTMLString:(NSString *)string;
@end
