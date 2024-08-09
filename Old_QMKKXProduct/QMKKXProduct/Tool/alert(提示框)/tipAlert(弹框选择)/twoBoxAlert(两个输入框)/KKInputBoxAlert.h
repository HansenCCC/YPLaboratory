//
//  KKInputBoxAlert.h
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/6.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKAlertViewController.h"
#import "KKTextField.h"

@interface KKInputBoxAlert : KKAlertViewController
@property (assign, nonatomic) BOOL isOnlyOneTextField;//是否是有一个 输入框 默认NO
@property (strong, nonatomic) KKTextField *topTextField;
@property (strong, nonatomic) KKTextField *bottomTextField;

@end


@interface KKInputBoxAlert (ALLALERT)

/// 自定义输入框
/// @param title 标题
/// @param bottomTitle 底部标题
/// @param topPlaceholder 占位符
/// @param bottomPlaceholder 占位符
/// @param isOnlyOneTextField 是否是有一个 输入框 默认NO
/// @param canTouchBeginMove 是否点击空白消失 default YES
/// @param whenCompleteBlock 成功回调
+ (KKAlertViewController *)showCustomWithTitle:(NSString *)title
                                       bottomTitle:(NSString *)bottomTitle
                                       topPlaceholder:(NSString *)topPlaceholder
                                       bottomPlaceholder:(NSString *)bottomPlaceholder
                                    isOnlyOneTextField:(BOOL )isOnlyOneTextField
                                    canTouchBeginMove:(BOOL )canTouchBeginMove
                                      complete:(KKAlertViewControllerBlock )whenCompleteBlock;

/**
 显示账号验证输入框
 */
+ (KKAlertViewController *)showAlertAccountVerificationWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

@end
