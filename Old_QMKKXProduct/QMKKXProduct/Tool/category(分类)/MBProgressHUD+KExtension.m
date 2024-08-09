//
//  MBProgressHUD+KExtension.m
//  CatPlatform
//
//  Created by iOS on 2018/1/9.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "MBProgressHUD+KExtension.h"

@implementation MBProgressHUD (KExtension)
+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow{
    UIView  *view = isWindow? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentUIVC].view;
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (message) {
        hud.label.text=message?message:@"Loding...";
        hud.label.font=[UIFont systemFontOfSize:15];
    }
    hud.removeFromSuperViewOnHide = YES;
//    hud.dimBackground = NO;
    return hud;
}
#pragma mark-------------------- show Tip----------------------------

+ (void)showTipMessageInWindow:(NSString*)message{
    [self showTipMessage:message isWindow:true timer:KUIProgressHUDAfterDelayTimer];
}
+ (void)showTipMessageInView:(NSString*)message{
    [self showTipMessage:message isWindow:false timer:KUIProgressHUDAfterDelayTimer];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer{
    [self showTipMessage:message isWindow:true timer:aTimer];
}
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer{
    [self showTipMessage:message isWindow:false timer:aTimer];
}
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:aTimer];
}
#pragma mark-------------------- show Activity----------------------------
+ (void)showActivityMessageInWindow:(NSString*)message{
    [self showActivityMessage:message isWindow:true timer:0];
}
+ (void)showActivityMessageInView:(NSString*)message{
    [self showActivityMessage:message isWindow:false timer:0];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer{
    [self showActivityMessage:message isWindow:true timer:aTimer];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer{
    [self showActivityMessage:message isWindow:false timer:aTimer];
}
+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------
+ (void)showSuccessMessage:(NSString *)Message{
    [self hideHUD];
    NSString *name =@"kk_icon_success";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showErrorMessage:(NSString *)Message{
    NSString *name =@"kk_icon_fail";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showInfoMessage:(NSString *)Message{
    NSString *name =@"MBHUD_Info";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showWarnMessage:(NSString *)Message{
    NSString *name =@"MBHUD_Warn";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message{
    [self showCustomIcon:iconName message:message isWindow:true timer:KUIProgressHUDAfterDelayTimer];
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message{
    [self showCustomIcon:iconName message:message isWindow:false timer:KUIProgressHUDAfterDelayTimer];
}
+ (MBProgressHUD *)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow timer:(NSTimeInterval )aTimer{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.margin = AdaptedWidth(8.f);
    hud.label.numberOfLines = 0;
    hud.label.textColor = KKColor_FFFFFF;
    hud.label.font = AdaptedFontSize(15.f);
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.65];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    [hud hideAnimated:YES afterDelay:aTimer];
    hud.bezelView.layer.cornerRadius = AdaptedWidth(13.f);
    [hud setNeedsUpdateConstraints];
    return hud;
}
+ (void)ShowProgeressBarHUDInWindow:(NSString*)message{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    [hud hideAnimated:YES afterDelay:KUIProgressHUDAfterDelayTimer];
}
+ (void)ShowProgeressBarHUDInView:(NSString*)message{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:NO];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    [hud hideAnimated:YES afterDelay:KUIProgressHUDAfterDelayTimer];
}
+ (void)hideHUD{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[self getCurrentUIVC].view animated:YES];
    //废弃的旧方法
//    [self hideAllHUDsForView:winView animated:YES];
//    [self hideAllHUDsForView:[self getCurrentUIVC].view animated:YES];
#pragma clang diagnostic pop
}
//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows){
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return  result;
}
+(UIViewController *)getCurrentUIVC{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC ];
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else{
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    }
    return superVC;
}
@end
