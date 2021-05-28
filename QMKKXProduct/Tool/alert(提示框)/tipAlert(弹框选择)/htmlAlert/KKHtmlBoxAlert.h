//
//  KKHtmlBoxAlert.h
//  QMKKXProduct
//
//  Created by Hansen on 5/28/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKAlertViewController.h"
#import <WebKit/WebKit.h>

@interface KKHtmlBoxAlert : KKAlertViewController
@property (strong, nonatomic) WKWebView *webView;

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
                               complete:(KKAlertViewControllerBlock )whenCompleteBlock;
@end

