//
//  KKInputBoxAlert.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/6.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKInputBoxAlert.h"

@interface KKInputBoxAlert ()
@property (strong, nonatomic) UIButton *eyesButton;

@end

@implementation KKInputBoxAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)setupSubViews{
    [super setupSubViews];
    //
    self.topTextField = [[KKTextField alloc] init];
    self.topTextField.placeholder = @"";
    self.topTextField.font = AdaptedFontSize(14.f);
    self.topTextField.layer.cornerRadius = AdaptedWidth(5.f);
    self.topTextField.layer.borderWidth = AdaptedWidth(1.f);
    self.topTextField.layer.borderColor = KKColor_EEEEEE.CGColor;
    self.topTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AdaptedWidth(10.f), 0)];
    self.topTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.topTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.contentView addSubview:self.topTextField];
    //
    self.bottomTextField = [[KKTextField alloc] init];
    self.bottomTextField.layer.cornerRadius = AdaptedWidth(5.f);
    self.bottomTextField.layer.borderWidth = AdaptedWidth(1.f);
    self.bottomTextField.layer.borderColor = KKColor_EEEEEE.CGColor;
    self.bottomTextField.placeholder = @"";
    self.bottomTextField.font = AdaptedFontSize(14.f);
    self.bottomTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AdaptedWidth(10.f), 0)];
    self.topTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.bottomTextField.leftViewMode = UITextFieldViewModeAlways;
    self.bottomTextField.secureTextEntry = YES;
    [self.contentView addSubview:self.bottomTextField];
    //
    UIButton *eyesButton = [[UIButton alloc]init];
    eyesButton.frame = CGRectMake(0, 0, AdaptedWidth(44.f), AdaptedWidth(44.f));
    [self.contentView addSubview:eyesButton];
    [eyesButton setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
    [eyesButton setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateSelected];
    eyesButton.selected = NO;
    [eyesButton addTarget:self action:@selector(__showPassword:) forControlEvents:UIControlEventTouchUpInside];
    self.eyesButton = eyesButton;
    self.bottomTextField.rightView = eyesButton;
    self.bottomTextField.rightViewMode = UITextFieldViewModeAlways;
}
- (void)__showPassword:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.bottomTextField.secureTextEntry = !sender.selected;
}
- (void)setIsOnlyOneTextField:(BOOL)isOnlyOneTextField{
    _isOnlyOneTextField = isOnlyOneTextField;
    self.bottomTextField.hidden = isOnlyOneTextField;
    [self viewWillLayoutSubviews];
}
- (void)setTipText:(NSString *)tipText{
    //置空
    [super setTipText:@""];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    if (self.isOnlyOneTextField) {
        f1.origin.y = AdaptedWidth(44.f + 44.f);
    }else{
        f1.origin.y = AdaptedWidth(15.f + 44.f);
    }
    f1.origin.x = AdaptedWidth(20.f);
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    f1.size.height = AdaptedWidth(44.f);
    self.topTextField.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = f1.size;
    f2.origin.x = f1.origin.x;
    f2.origin.y = CGRectGetMaxY(f1) + AdaptedWidth(12.f);
    self.bottomTextField.frame = f2;
}

@end


@implementation KKInputBoxAlert (ALLALERT)
/// 自定义输入框
/// @param title 标题
/// @param bottomTitle 底部标题
/// @param topPlaceholder 占位符
/// @param bottomPlaceholder 占位符
/// @param isOnlyOneTextField 是否是有一个 输入框 默认NO
/// @param canTouchBeginMove 是否点击空白消失 default YES
/// @param whenCompleteBlock 成功回调
+ (KKAlertViewController *)showCustomWithTitle:(NSString *)title
                                       bottomTitle:(NSString *)bottomTitle
                                       topPlaceholder:(NSString *)topPlaceholder
                                       bottomPlaceholder:(NSString *)bottomPlaceholder
                                    isOnlyOneTextField:(BOOL )isOnlyOneTextField
                                    canTouchBeginMove:(BOOL )canTouchBeginMove
                                      complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKInputBoxAlert *alert = [[KKInputBoxAlert alloc] initWithPresentType:KKUIBaseMiddlePresentType];
    alert.whenCompleteBlock = whenCompleteBlock;
    alert.isOnlyOneTextField = isOnlyOneTextField;
    alert.isOnlyOneButton = YES;
    alert.canTouchBeginMove = canTouchBeginMove;
    alert.rightTitle = bottomTitle;
    alert.text = title;
    alert.topTextField.placeholder = topPlaceholder;
    alert.bottomTextField.placeholder = bottomPlaceholder;
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}

/**
 显示账号验证输入框
 */
+ (KKAlertViewController *)showAlertAccountVerificationWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKInputBoxAlert *alert = [[KKInputBoxAlert alloc] initWithPresentType:KKUIBaseMiddlePresentType];
    alert.whenCompleteBlock = whenCompleteBlock;
    alert.isOnlyOneButton = YES;
    alert.rightTitle = @"验证";
    alert.text = @"账号验证";
    alert.topTextField.placeholder = @"请输入您的游戏账号";
    alert.bottomTextField.placeholder = @"请输入您的密码";
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}
@end
