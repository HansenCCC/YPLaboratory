//
//  YPAppUpdatePopupController.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/27.
//

#import "YPAppUpdatePopupController.h"

@interface YPAppUpdatePopupController ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIView *appstoreView;
@property (nonatomic, strong) UIButton *appstoreButton;
@property (nonatomic, strong) UIView *laterView;
@property (nonatomic, strong) UIButton *laterButton;

@end

@implementation YPAppUpdatePopupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isEnableTouchMove = NO;
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.appstoreButton];
    [self.contentView addSubview:self.laterView];
    [self.contentView addSubview:self.laterButton];
    [self.contentView addSubview:self.appstoreView];
    self.contentView.backgroundColor = [UIColor yp_colorWithHexString:@"#e4e5e6"];
}

- (void)popupLayoutSubviews {
    [super popupLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 60.f;
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.contentView.layer.cornerRadius = 18.f;
    
    CGRect f2 = f1;
    f2.size = CGSizeMake(60.f, 60.f);
    f2.origin.x = (f1.size.width - f2.size.width) / 2.f;
    f2.origin.y = 20.f;
    self.logoImageView.frame = f2;
    self.logoImageView.layer.cornerRadius = 12.f;
    
    CGRect f3 = f1;
    f3.origin.y = CGRectGetMaxY(f2) + 20.f;
    f3.size.height = [self.titleLabel sizeThatFits:CGSizeZero].height;
    f3.origin.x = 0.f;
    self.titleLabel.frame = f3;
    
    CGRect f4 = f1;
    f4.origin.x = 30.f;
    f4.origin.y = CGRectGetMaxY(f3) + 5.f;
    f4.size.height = [self.detailLabel sizeThatFits:CGSizeMake(f1.size.width - f1.origin.x * 2, 0)].height;
    f4.size.width = f1.size.width - 2 * f4.origin.x;
    self.detailLabel.frame = f4;
    
    CGRect f5 = f1;
    f5.size.height = 44.f;
    f5.origin.y = CGRectGetMaxY(f4) + 20.f;
    f5.origin.x = 0;
    self.appstoreButton.frame = f5;
    
    BOOL forceUpdate = self.forceUpdate;
    CGRect f6 = f5;
    f6.origin.y = CGRectGetMaxY(f5);
    self.laterButton.frame = f6;
    if (forceUpdate) {
        // 强更
        f1.size.height = CGRectGetMaxY(f5);
    } else {
        // 非强更
        f1.size.height = CGRectGetMaxY(f6);
    }
    f1.origin.y = (bounds.size.height - f1.size.height) / 2.f;
    self.contentView.frame = f1;
    
    f5.size.height = 0.5f;
    self.appstoreView.frame = f5;
    f6.size.height = 0.5f;
    self.laterView.frame = f6;
    
    self.laterView.hidden = forceUpdate;
    self.laterButton.hidden = forceUpdate;
}

#pragma mark - action

- (void)laterActionClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)appstoceActionClick {
    [[YPSettingManager sharedInstance] showAppstore];
}

#pragma mark - getters | setters

- (UIImageView *)logoImageView {
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"yp_icon_80"];
        _logoImageView.clipsToBounds = YES;
    }
    return _logoImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel yp_labelWithFont:[UIFont boldSystemFontOfSize:16.f] textColor:[UIColor yp_darkColor]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel yp_labelWithFont:[UIFont systemFontOfSize:15.f] textColor:[UIColor yp_darkColor]];
        _detailLabel.numberOfLines = 5;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}

- (UIButton *)laterButton {
    if (!_laterButton) {
        _laterButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_laterButton setTitle:@"稍后更新".yp_localizedString forState:UIControlStateNormal];
        _laterButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
        [_laterButton addTarget:self action:@selector(laterActionClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _laterButton;
}

- (UIView *)laterView {
    if (!_laterView) {
        _laterView = [[UIView alloc] init];
        _laterView.backgroundColor = [UIColor yp_colorWithHexString:@"#C6C6C8"];
    }
    return _laterView;
}

- (UIButton *)appstoreButton {
    if (!_appstoreButton) {
        _appstoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_appstoreButton setTitle:@"去 AppStore 更新".yp_localizedString forState:UIControlStateNormal];
        _appstoreButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_appstoreButton addTarget:self action:@selector(appstoceActionClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appstoreButton;
}

- (UIView *)appstoreView {
    if (!_appstoreView) {
        _appstoreView = [[UIView alloc] init];
        _appstoreView.backgroundColor = [UIColor yp_colorWithHexString:@"#C6C6C8"];
    }
    return _appstoreView;
}

- (void)setUpdateTitle:(NSString *)updateTitle {
    _updateTitle = updateTitle;
    self.titleLabel.text = updateTitle;
}

- (void)setForceUpdate:(BOOL)forceUpdate {
    _forceUpdate = forceUpdate;
}

- (void)setUpdateContent:(NSString *)updateContent {
    _updateTitle = updateContent;
    self.detailLabel.text = updateContent;
}

@end
