//
//  KKTextField.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/5/30.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKTextField.h"

@implementation KKTextField
- (instancetype)init{
    if (self = [super init]) {
        self.delegate = self;
        [self addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
        [self addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

#pragma mark - delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.whenShouldBeginEditing) {
        return self.whenShouldBeginEditing(textField);
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.whenDidBeginEditing) {
        self.whenDidBeginEditing(textField);
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.whenShouldChangeCharactersInRange) {
        return self.whenShouldChangeCharactersInRange(textField,range,string);
    }
    return YES;
}
- (void)textFieldDidEditing:(UITextField *)textField{
    if (self.whenDidEditing) {
        self.whenDidEditing(textField);
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.whenShouldEndEditing) {
        return self.whenShouldEndEditing(textField);
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(self.whenDidEndEditing){
        self.whenDidEndEditing(textField);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.whenShouldReturn) {
        return self.whenShouldReturn(textField);
    }
    [textField resignFirstResponder];
    return YES;
}

@end
