//
//  UIViewController+KExtension.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "UIViewController+KExtension.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+KExtension.h"

@implementation UIViewController (KExtension)

/**
 清除导航模板
 */
- (void)clearNavigationMask{
    [self.navigationController.navigationBar setNavigationBarTransparency:YES];
}
/**
 回复导航模板
 */
- (void)restoreNavigationMask{
    [self.navigationController.navigationBar setNavigationBarTransparency:NO];
}

//显示loading
- (void)showLoading {
    [KKBaseLoadingView showWithView:self.view translucent:YES userInteractionEnabled:NO];
}
//在window上显示loading
- (void)showLoadingOnWindow {
    // 避免重复显示
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if ([window.subviews.lastObject isKindOfClass:[KKBaseLoadingView class]] == NO) {
        [KKBaseLoadingView showWithView:[UIApplication sharedApplication].keyWindow translucent:YES userInteractionEnabled:NO];
    }
}
//隐藏loading
- (void)hideLoading {
    [KKBaseLoadingView hideWithView:self.view];
}
//隐藏window上的loading
- (void)hideLondingOnWindow {
    [KKBaseLoadingView hideWithView:[UIApplication sharedApplication].keyWindow];
}
//显示成功信息 2s消失
- (void)showSuccessWithMsg:(NSString *)msg{
    NSString *name = @"kk_icon_success";
    [self showCustomIcon:name message:msg isWindow:YES];
}
//显示错误信息 2s消失
- (void)showError:(NSString *)error{
    NSString *name = @"kk_icon_fail";
    [self showCustomIcon:name message:error isWindow:YES];
}
- (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow{
    [self showCustomIcon:iconName message:message isWindow:isWindow timer:KUIProgressHUDAfterDelayTimer];
}
- (UIView *)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow timer:(NSTimeInterval )aTimer{
   return [MBProgressHUD showCustomIcon:iconName message:message isWindow:isWindow timer:aTimer];
//    UIView *view = isWindow?(UIView*)[UIApplication sharedApplication].delegate.window:(UIView*)[UIApplication sharedApplication].delegate.window.topViewController.view;
//    if (view == nil) {
//        view = [UIApplication sharedApplication].keyWindow;
//    }
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    if (message) {
//        hud.label.text=message?message:@"Loding...";
//        hud.label.font=[UIFont systemFontOfSize:15];
//    }
//    hud.removeFromSuperViewOnHide = YES;
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
//    hud.mode = MBProgressHUDModeCustomView;
//    [hud hideAnimated:YES afterDelay:KUIProgressHUDAfterDelayTimer];
}
//获取当前试图正在编辑的textfield
- (UITextField *)controlEditingTextField{
    UITextField *textField;
//    UIViewController *rootViewController = [[UIApplication sharedApplication].keyWindow rootViewController];
    UIViewController *rootViewController = self;
    NSArray *fieldViews = [rootViewController.view traversalAllForClass:[UITextField class]];
    for (UITextField *view in fieldViews) {
        if (view.editing) {
            textField = view;
        }
    }
    return textField;
}
//延迟隐藏键盘
- (void)controlResignFirstResponder{
    WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.view endEditing:YES];//延时收缩键盘
    });
}
@end
