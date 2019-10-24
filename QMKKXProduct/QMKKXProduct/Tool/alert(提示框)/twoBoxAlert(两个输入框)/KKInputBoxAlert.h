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


/**
 显示账号验证输入框
 */
+ (KKAlertViewController *)showAlertAccountVerificationWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

@end
