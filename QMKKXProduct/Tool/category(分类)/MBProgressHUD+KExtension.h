//
//  MBProgressHUD+KExtension.h
//  CatPlatform
//
//  Created by iOS on 2018/1/9.
//  Copyright © 2018年 iOS. All rights reserved.
//


/*六亲不认以下代码不是我写的不是我写的不是我写的不是我写的不是我写的不是我写的不是我写的*/

#import <MBProgressHUD.h>
@interface MBProgressHUD (KExtension)

+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer;

+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer;

+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;

+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;
+ (MBProgressHUD *)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow timer:(NSTimeInterval )aTimer;

+ (void)ShowProgeressBarHUDInWindow:(NSString*)message;
+ (void)ShowProgeressBarHUDInView:(NSString*)message;
+ (void)hideHUD;
@end
