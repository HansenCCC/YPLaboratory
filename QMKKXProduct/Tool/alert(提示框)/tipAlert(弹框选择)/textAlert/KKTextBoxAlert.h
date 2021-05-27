//
//  KKTextBoxAlert.h
//  QMKKXProduct
//
//  Created by Hansen on 5/28/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKAlertViewController.h"
#import "KKTextView.h"

@interface KKTextBoxAlert : KKAlertViewController
@property (strong, nonatomic) KKTextView *textView;

/// 输入框自定义
/// @param headTitle 标题
/// @param textDetail  内容
/// @param leftTitle 左边标题
/// @param rightTitle 右边标题
/// @param placeholder 占位符
/// @param isOnlyOneButton 是否是有一个按钮 default NO
/// @param isShowCloseButton 是否显示关闭按钮 default YES
/// @param canTouchBeginMove 是否点击空白消失 default YES
/// @param whenCompleteBlock 成功回调
+ (KKTextBoxAlert *)showCustomWithTitle:(NSString *)headTitle
                                       textDetail:(NSString *)textDetail
                                       leftTitle:(NSString *)leftTitle
                                       rightTitle:(NSString *)rightTitle
                                   placeholder:(NSString *)placeholder
                                    isOnlyOneButton:(BOOL )isOnlyOneButton
                                    isShowCloseButton:(BOOL )isShowCloseButton
                                    canTouchBeginMove:(BOOL )canTouchBeginMove
                                      complete:(KKAlertViewControllerBlock )whenCompleteBlock;

@end

