//
//  KKUIWebViewController.h
//  lwui
//  封装webview
//  Created by Herson on 2018/1/5.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKBaseViewController.h"

@interface KKUIWebViewController : KKBaseViewController
@property(nonatomic, strong) NSURL *requestURL;

//加载网页
- (void)loadRequest:(NSURLRequest *)request;
//加载HTML
- (void)loadHTMLString:(NSString *)string;
@end
