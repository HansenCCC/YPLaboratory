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

@end

@implementation KKRunLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跑马灯效果";
    //
    [self setupRunLabel:AdaptedBoldFontSize(40.f)];
    [self setupRunLabel:AdaptedFontSize(40.f)];
    [self setupRunLabel:AdaptedBoldFontSize(30.f)];
    [self setupRunLabel:AdaptedFontSize(30.f)];
    [self setupRunLabel:AdaptedBoldFontSize(20.f)];
    [self setupRunLabel:AdaptedFontSize(20.f)];
    [self setupRunLabel:AdaptedBoldFontSize(15.f)];
    [self setupRunLabel:AdaptedFontSize(15.f)];
    [self setupRunLabel:AdaptedBoldFontSize(10.f)];
    [self setupRunLabel:AdaptedFontSize(10.f)];
}
- (KKRunLabel *)setupRunLabel:(UIFont *)font{
    KKRunLabel *label = [[KKRunLabel alloc] init];
    label.titleLabel.font = font;
    label.titleLabel.text = @"你 真 的 是 个 大 帅 比 ！";
    [self.view addSubview:label];
    return label;
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
    f1.origin.y = SafeAreaTopHeight;
    f1.size.height = AdaptedWidth(0.f);
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[KKRunLabel class]]) {
            f1.origin.y = CGRectGetMaxY(f1) + AdaptedWidth(20.f);
            f1.size = [view sizeThatFits:CGSizeMake(bounds.size.width - 2 * AdaptedWidth(50.f), 0)];
            f1.origin.x = (bounds.size.width - f1.size.width)/2.0;
            view.frame = f1;
        }
    }
}
@end
