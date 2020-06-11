//
//  KKPayPasswordViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 6/11/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKPayPasswordViewController.h"

@interface KKPayPasswordViewController ()
@property (strong, nonatomic) KKPayTextField *textField;

@end

@implementation KKPayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付密码框";
    [self setupSubview];
    //主动弹起键盘
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textField.textField becomeFirstResponder];
    });
}
- (void)setupSubview{
    //
    //右边导航刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(whenRightClickAction:)];
    //
    self.textField = [[KKPayTextField alloc] init];
    self.textField.secureTextEntry = NO;//允许查看
    [self.view addSubview:self.textField];
    //颜色配置
    self.textField.backgroundColor = [UIColor colorWithRed:229/255.0 green:76/255.0 blue:66/255.0 alpha:0.02];
    self.textField.layer.borderWidth = 1;
    self.textField.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
    self.textField.layer.cornerRadius = AdaptedWidth(4.f);
}
- (void)whenRightClickAction:(id)sender{
    //to do
    self.textField.secureTextEntry = !self.textField.secureTextEntry;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.size.height = AdaptedWidth(42.f);
    f1.size.width = f1.size.height * 6;
    f1.origin.x = (bounds.size.width - f1.size.width)/2.0;
    f1.origin.y = AdaptedWidth(200.f);
    self.textField.frame = f1;
}
@end
