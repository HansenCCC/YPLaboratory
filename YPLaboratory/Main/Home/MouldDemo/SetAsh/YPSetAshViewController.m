//
//  YPSetAshViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/6.
//

#import "YPSetAshViewController.h"

@interface YPSetAshViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YPSetAshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.imageView];
    
    // 方案一、使用蒙层盖住
    UIView *greyView = [[UIView alloc] initWithFrame:self.view.bounds];
    greyView.userInteractionEnabled = NO;
    greyView.backgroundColor = [UIColor lightGrayColor];
    greyView.layer.compositingFilter = @"saturationBlendMode";
    greyView.layer.zPosition = FLT_MAX;
    [self.view addSubview:greyView];
    
    // 方案二、HOOK 所有Image set 方法，先讲图片置灰再展示。
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 50.f;
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    f1.size.height = f1.size.width;
    f1.origin.y = (bounds.size.height - f1.size.height) / 2.f;
    self.imageView.frame = f1;
}

#pragma mark - setter | getters

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"yp-icon-1024"];
    }
    return _imageView;
}

@end
