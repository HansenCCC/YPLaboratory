//
//  YPRunLabelViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/6.
//

#import "YPRunLabelViewController.h"

@interface YPRunLabelViewController ()

@end

@implementation YPRunLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupRunLabel:[UIFont systemFontOfSize:40.f]];
    [self setupRunLabel:[UIFont boldSystemFontOfSize:40.f]];
    [self setupRunLabel:[UIFont systemFontOfSize:30.f]];
    [self setupRunLabel:[UIFont boldSystemFontOfSize:30.f]];
    [self setupRunLabel:[UIFont systemFontOfSize:25.f]];
    [self setupRunLabel:[UIFont boldSystemFontOfSize:25.f]];
    [self setupRunLabel:[UIFont systemFontOfSize:20.f]];
    [self setupRunLabel:[UIFont boldSystemFontOfSize:20.f]];
    [self setupRunLabel:[UIFont systemFontOfSize:15.f]];
    [self setupRunLabel:[UIFont boldSystemFontOfSize:15.f]];
    [self setupRunLabel:[UIFont systemFontOfSize:10.f]];
    [self setupRunLabel:[UIFont boldSystemFontOfSize:10.f]];
}

- (UIView *)setupRunLabel:(UIFont *)font {
    YPRunLabel *label = [[YPRunLabel alloc] init];
    label.titleLabel.font = font;
    label.titleLabel.text = @"爱国、民主、为民、进步".yp_localizedString;
    [self.view addSubview:label];
    return label;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.origin.y = 20.f;
    f1.size.height = 0.f;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[YPRunLabel class]]) {
            f1.origin.y = CGRectGetMaxY(f1) + 20.f;
            f1.size = [view sizeThatFits:CGSizeMake(bounds.size.width - 2 * 50.f, 0)];
            f1.origin.x = (bounds.size.width - f1.size.width)/2.0;
            view.frame = f1;
        }
    }
}

@end
