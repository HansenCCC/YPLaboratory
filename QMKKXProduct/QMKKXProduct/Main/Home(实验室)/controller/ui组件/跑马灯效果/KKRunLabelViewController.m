//
//  KKRunLabelViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 7/8/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKRunLabelViewController.h"
#import "KKRunLabel.h"

@interface KKRunLabelViewController ()
@property (strong, nonatomic) KKRunLabel *runLabel;

@end

@implementation KKRunLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跑马灯效果";
    self.runLabel = [[KKRunLabel alloc] init];
    self.runLabel.titleLabel.font = AdaptedBoldFontSize(23);
    self.runLabel.titleLabel.text = @"你 真 的 是 个 大 帅 比 ！";
    [self.view addSubview:self.runLabel];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = self.view.safeAreaInsets;
    }
    bounds = UIEdgeInsetsInsetRect(bounds,insets);
    CGRect f1 = bounds;
    f1.origin.y = AdaptedWidth(200.f);
    f1.size = [self.runLabel sizeThatFits:CGSizeMake(bounds.size.width - 2 * AdaptedWidth(50.f), 0)];
    f1.origin.x = (bounds.size.width - f1.size.width)/2.0;
    self.runLabel.frame = f1;
}
@end
