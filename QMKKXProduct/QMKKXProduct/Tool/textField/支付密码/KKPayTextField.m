//
//  KKPayTextField.m
//  QMKKXProduct
//
//  Created by Hansen on 6/11/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKPayTextField.h"

@interface __KKPayTextField : KKTextField

@end
@implementation __KKPayTextField
//禁用复制、粘贴、剪切功能
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}
@end


@interface KKPayTextFieldLabel : UILabel
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *markView;
@property (strong, nonatomic) UIView *starView;

@end

@implementation KKPayTextFieldLabel
- (instancetype)init{
    if (self = [super init]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = KKColor_FFFFFF;
        self.textColor = KKColor_000000;
        self.font = AdaptedBoldFontSize(20.f);
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    //
    self.starView = [[UIView alloc] init];
    self.starView.backgroundColor = KKColor_000000;
    [self addSubview:self.starView];
    //
    self.backgroundView = [[UIView alloc] init];
    [self addSubview:self.backgroundView];
    //
    self.markView = [[UIView alloc] init];
    self.markView.backgroundColor = KKColor_DDDDDD;
    [self addSubview:self.markView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.size = CGSizeMake(AdaptedWidth(8.f), AdaptedWidth(8.f));
    f1.origin.x = (bounds.size.width - f1.size.width)/2.0;
    f1.origin.y = (bounds.size.height - f1.size.height)/2.0;
    self.starView.frame = f1;
    self.starView.layer.cornerRadius = f1.size.height/2.0f;
    //
    self.backgroundView.frame = bounds;
    //
    CGRect f2 = bounds;
    f2.size.width = AdaptedWidth(1.f);
    f2.origin.x = bounds.size.width - f2.size.width;
    self.markView.frame = f2;
}
@end

@interface KKPayTextField ()
@property (strong, nonatomic) NSArray *labelViews;

@end


@implementation KKPayTextField
- (instancetype)init{
    if (self = [super init]) {
        self.clipsToBounds = YES;
        self.secureTextEntry = YES;
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    //
    self.textField = [[__KKPayTextField alloc] init];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.secureTextEntry = YES;
    WeakSelf
    //密码不允许超过6位
    self.textField.whenShouldChangeCharactersInRange = ^BOOL(UITextField *textField, NSRange range, NSString *string) {
        if (textField.text.length >= 6&&string.length > 0) {
            return NO;
        }else{
            return YES;
        }
    };
    self.textField.whenDidEditing = ^(UITextField *textField) {
        //更新每个label
        [weakSelf updateLabels];
    };
    [self addSubview:self.textField];
    //
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    for (int i =0; i < 6; i ++) {
        KKPayTextFieldLabel *label = [[KKPayTextFieldLabel alloc] init];
        label.tag = i;
        [self addSubview:label];
        if (i == 6) {
            //最后一个不显示线条
            label.markView.hidden = YES;
        }
        [labels addObject:label];
    }
    self.labelViews = [labels copy];
    [self updateLabels];
    
    //颜色配置
    self.backgroundColor = [UIColor colorWithRed:229/255.0 green:76/255.0 blue:66/255.0 alpha:0.02];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = AdaptedWidth(4.f);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.textField.frame = f1;
    CGRect f2 = bounds;
    f2.size.width = f2.size.height;
    for (KKPayTextFieldLabel *label in self.labelViews) {
        label.frame = f2;
        f2.origin.x = CGRectGetMaxX(f2);
    }
}
- (void)updateLabels{
    for (int i =0; i < self.labelViews.count; i ++) {
        KKPayTextFieldLabel *label = self.labelViews[i];
        NSString *value = self.textField.text;
        NSString *labelValue;
        if (value.length > i) {
            labelValue = [value substringWithRange:NSMakeRange(i, 1)];
        }
        if (labelValue.length > 0) {
            if (self.secureTextEntry) {
                label.text = nil;
                label.starView.hidden = NO;
            }else{
                label.text = labelValue;
                label.starView.hidden = YES;
            }
        }else{
            label.text = nil;
            label.starView.hidden = YES;
        }
    }
}
//同步修改颜色
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    for (KKPayTextFieldLabel *label in self.labelViews) {
        label.backgroundView.backgroundColor = backgroundColor;
    }
}
- (void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    [self updateLabels];
}
@end
