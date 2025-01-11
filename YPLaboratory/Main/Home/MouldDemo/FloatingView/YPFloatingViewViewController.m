//
//  YPFloatingViewViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/11.
//

#import "YPFloatingViewViewController.h"

@interface YPFloatingViewViewController ()

@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) YPFloatingView *floatingView;

@end

@implementation YPFloatingViewViewController

- (CGFloat)floatingWidth {
    return 44.f;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"悬浮按钮".yp_localizedString;
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.locationLabel];
    [self.contentView addSubview:self.floatingView];
    [self updateLocation];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.size.height = bounds.size.height - 200.f;
    f1.size.width = bounds.size.width - 100.f;
    f1.origin.x = (bounds.size.width - f1.size.width) / 2.f;
    f1.origin.y = (bounds.size.height - f1.size.height) / 2.f;
    self.contentView.frame = f1;
    self.contentView.layer.cornerRadius = self.floatingWidth / 2.f;
    
    CGRect f2 = bounds;
    f2.origin.x = 0;
    f2.size.height = 44.f;
    f2.origin.y = f1.origin.y - f2.size.height;
    self.locationLabel.frame = f2;
}

- (void)updateLocation {
    self.locationLabel.text = [NSString stringWithFormat:@"{%.2f, %.2f}", self.floatingView.currentLocation.x, self.floatingView.currentLocation.y];
}

#pragma mark - setter | getter

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor yp_gray4Color];
    }
    return _contentView;
}

- (YPFloatingView *)floatingView {
    if (!_floatingView) {
        _floatingView = [[YPFloatingView alloc] initWithFrame:CGRectMake(10, 10.f, self.floatingWidth, self.floatingWidth)];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"yp_icon_80"];
        imageView.userInteractionEnabled = NO;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = self.floatingWidth / 2.f;
        [_floatingView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(_floatingView);
        }];
        _floatingView.didClickCallback = ^{
            [[YPShakeManager shareInstance] mediumShake];
        };
        __weak typeof(self) weakSelf = self;
        _floatingView.didMoveCallback = ^(CGPoint location) {
            [[YPShakeManager shareInstance] lightShake];
            [weakSelf updateLocation];
        };
    }
    return _floatingView;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = [UIFont systemFontOfSize:17.f];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _locationLabel;
}

@end
