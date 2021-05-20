//
//  KKTextField.h
//  FanRabbit
//  编辑框
//  Created by 程恒盛 on 2019/5/30.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KKTextFieldBlock)(UITextField *textField);
typedef BOOL(^KKTextFieldBoolBlock)(UITextField *textField);
typedef BOOL(^KKTextFieldBoolCharactersInRangeBlock)(UITextField *textField,NSRange range,NSString *string);

@interface KKTextField : UITextField<UITextFieldDelegate>
@property (copy , nonatomic) KKTextFieldBoolBlock whenShouldBeginEditing;//是否允许编辑
@property (copy , nonatomic) KKTextFieldBlock whenDidBeginEditing;//开始编辑
@property (copy , nonatomic) KKTextFieldBoolCharactersInRangeBlock whenShouldChangeCharactersInRange;//填写字符回调
@property (copy , nonatomic) KKTextFieldBlock whenDidEditing;//编辑中

@property (copy , nonatomic) KKTextFieldBoolBlock whenShouldReturn;//return操作

@property (copy , nonatomic) KKTextFieldBoolBlock whenShouldEndEditing;//是否允许结束编辑
@property (copy , nonatomic) KKTextFieldBlock whenDidEndEditing;//结束编辑

@end

