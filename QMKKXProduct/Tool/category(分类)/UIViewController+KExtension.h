//
//  UIViewController+KExtension.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (KExtension)

#pragma mark - navigation

/**
 清除导航模板
 */
- (void)clearNavigationMask;
/**
 回复导航模板
 */
- (void)restoreNavigationMask;



#pragma mark - loading

/**
 显示loading
 */
- (void)showLoading;

/**
 在window上显示loading
 */
- (void)showLoadingOnWindow;

/**
 隐藏loading
 */
- (void)hideLoading;

/**
 隐藏window上的loading
 */
- (void)hideLondingOnWindow;

/**
 显示成功信息 2s消失
 
 @param msg 成功信息
 */
- (void)showSuccessWithMsg:(NSString *)msg;

/**
 显示错误信息 2s消失
 
 @param error 失败信息
 */
- (void)showError:(NSString *)error;

/**
显示tip，并携带icon

@param iconName  icon
@param message   tip
@param isWindow 是否展示在window
*/
- (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow;
- (UIView *)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow timer:(NSTimeInterval )aTimer;
#pragma mark - keyboard
/**
 获取当前试图正在编辑的textfield
 
 @return textfield
 */
- (UITextField *)controlEditingTextField;

/**
 延迟隐藏键盘
 */
- (void)controlResignFirstResponder;

@end

