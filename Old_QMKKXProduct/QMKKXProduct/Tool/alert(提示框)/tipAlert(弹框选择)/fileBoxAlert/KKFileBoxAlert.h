//
//  KKFileBoxAlert.h
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKAlertViewController.h"

@interface KKFileBoxAlert : KKAlertViewController
@property (strong, nonatomic) NSString *filePath;

/**
 显示账号验证输入框
 */
+ (KKFileBoxAlert *)showAlertWithFilePath:(NSString *)title complete:(KKAlertViewControllerBlock )whenCompleteBlock;

@end

