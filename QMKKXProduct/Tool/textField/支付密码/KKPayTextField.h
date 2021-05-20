//
//  KKPayTextField.h
//  QMKKXProduct
//
//  Created by Hansen on 6/11/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPayTextField : UIView
@property (strong, nonatomic) KKTextField *textField;
@property (assign, nonatomic) BOOL secureTextEntry;//是否设置密文 default YES

@end

