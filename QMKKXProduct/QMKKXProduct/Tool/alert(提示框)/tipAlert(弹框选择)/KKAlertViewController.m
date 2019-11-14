//
//  KKAlertViewController.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/4.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKAlertViewController.h"

@interface KKAlertViewController ()
@property (strong ,nonatomic) UIButton *leftBtn;
@property (strong ,nonatomic) UIButton *rightBtn;
@property (strong ,nonatomic) UILabel *titleLabel;
@property (strong ,nonatomic) UILabel *textLabel;
@property (strong ,nonatomic) UIButton *closeButton;
@property (strong ,nonatomic) UIView *markView;

@end

@implementation KKAlertViewController
- (instancetype)init{
    if (self = [super init]) {
        self.canTouchBeginMove = NO;
        self.isShowCloseButton = YES;
        self.isOnlyOneButton = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentView.backgroundColor = KKColor_FFFFFF;
    self.view.backgroundColor = KKColor_FFFFFF;
    [self setupSubViews];
}
- (void)setupSubViews{
    //
    self.textLabel = [UILabel labelWithFont:AdaptedBoldFontSize(18.f) textColor:KKColor_000000];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLabel];
    //
    self.leftBtn = [[UIButton alloc] init];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:KKColor_999999 forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(whenLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.backgroundColor = KKColor_EEEEEE;
    self.leftBtn.titleLabel.font = AdaptedBoldFontSize(18.f);
    [self.contentView addSubview:self.leftBtn];
    //
    self.rightBtn = [[UIButton alloc] init];
    [self.rightBtn setTitleColor:KKColor_FFFFFF forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(whenRightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.backgroundColor = KKColor_0000FF;
    self.rightBtn.titleLabel.font = AdaptedBoldFontSize(18.f);
    [self.contentView addSubview:self.rightBtn];
    //
    self.closeButton = [[UIButton alloc] init];
    self.closeButton.hidden = !self.isShowCloseButton;
    [self.closeButton setImage:UIImageWithName(@"kk_icon_delete") forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(whenCloseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.closeButton];
    //
    self.titleLabel = [UILabel labelWithFont:AdaptedFontSize(18.f) textColor:KKColor_000000];
    self.titleLabel.numberOfLines = 10;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    //
    self.markView = [[UIView alloc] init];
    self.markView.backgroundColor = KKColor_EEEEEE;
    self.markView.hidden = YES;
    [self.contentView addSubview:self.markView];
}
- (void)whenLeftClick:(id)sender{
    //
    if (self.whenCompleteBlock) {
        self.whenCompleteBlock(self,0);
    }
    //隐藏
//    [self dismissViewControllerCompletion:nil];
}
- (void)whenRightClick:(id)sender{
    //
    if (self.whenCompleteBlock) {
        self.whenCompleteBlock(self,1);
    }
    //隐藏
//    [self dismissViewControllerCompletion:nil];
}
- (void)whenCloseClick:(id)sender{
    //隐藏
    [self dismissViewControllerCompletion:nil];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGFloat height = AdaptedWidth(50.f);
    //
    CGRect f1 = bounds;
    f1.size.width = bounds.size.width - 2 * AdaptedWidth(38.f);
    f1.origin.x = (bounds.size.width - f1.size.width)/2;
    //
    CGRect f6 = bounds;
    f6.size.width  = f1.size.width - AdaptedWidth(20) * 2;
    BOOL flag = self.textLabel.text.length > 0;
    f6.size.height  = flag?AdaptedWidth(44.f):AdaptedWidth(0.f);
    f6.origin.x = AdaptedWidth(20);
    self.textLabel.frame = f6;
    //
    CGRect f5 = bounds;
    f5.size = [self.titleLabel sizeThatFits:CGSizeMake(f1.size.width - AdaptedWidth(20) * 2, 0)];
    f5.size.height = MAX(AdaptedWidth(120.f) + (flag?AdaptedWidth(0.f):AdaptedWidth(44.f)), f5.size.height);
    f5.size.width = f1.size.width - AdaptedWidth(20) * 2;
    f5.origin.x = AdaptedWidth(20);
    f5.origin.y = CGRectGetMaxY(f6);
    self.titleLabel.frame = f5;
    //
    f1.size.height = f5.size.height + (flag?AdaptedWidth(44.f):AdaptedWidth(0.f)) + AdaptedWidth(44.f) + AdaptedWidth(14.f);
    f1.origin.y = (bounds.size.height - f1.size.height)/2 - AdaptedWidth(20.f);
    self.contentView.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = CGSizeMake(AdaptedWidth(44.f), AdaptedWidth(44.f));
    f2.origin.y = 0;
    f2.origin.x = f1.size.width - f2.origin.y - f2.size.width;
    self.closeButton.frame = f2;
    //
    CGRect f3 = bounds;
    f3.size.width = f1.size.width/2.0f;
    f3.size.height = height;
    f3.origin.y = f1.size.height - f3.size.height;
    self.leftBtn.frame = f3;
    //
    CGRect f4 = f3;
    if (self.isOnlyOneButton) {
        f4.size.width = f1.size.width;
        self.leftBtn.hidden = YES;
    }else{
        f4.origin.x = f4.size.width;
        self.leftBtn.hidden = NO;
    }
    self.rightBtn.frame = f4;
    //
    CGRect f7 = bounds;
    f7.size.width  = f1.size.width;
    f7.size.height  = AdaptedWidth(1.f);
    f7.origin.y = AdaptedWidth(44.f);
    f7.origin.x = AdaptedWidth(0.f);
    self.markView.frame = f7;
    
    self.contentView.layer.cornerRadius = AdaptedWidth(13.f);
    self.contentView.clipsToBounds = YES;
}
#pragma mark - set|get方法
- (void)setTipText:(NSString *)tipText{
    _tipText = tipText;
    self.titleLabel.text = tipText;
    //重新布局
    [self viewWillLayoutSubviews];
}
- (void)setText:(NSString *)text{
    _text = text;
    self.textLabel.text = text;
    if (text.length > 0) {
        self.markView.hidden = NO;
    }else{
        self.markView.hidden = YES;
    }
    //重新布局
    [self viewWillLayoutSubviews];
}
- (void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
}
-(void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
}
- (void)setIsShowCloseButton:(BOOL)isShowCloseButton{
    _isShowCloseButton = isShowCloseButton;
    self.closeButton.hidden = !isShowCloseButton;
}
- (void)setIsOnlyOneButton:(BOOL)isOnlyOneButton{
    _isOnlyOneButton = isOnlyOneButton;
    //重新布局
    [self viewWillLayoutSubviews];
}

+ (instancetype)onlyOneButtonWithTipText:(NSString *)title oneText:(NSString *)oneText complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *vc = [[KKAlertViewController alloc] initWithPresentType:KKUIBaseMiddlePresentType];
    vc.tipText = title;
    vc.rightTitle = oneText;
    vc.isOnlyOneButton = YES;
    vc.whenCompleteBlock = whenCompleteBlock;
    return vc;
}
+ (instancetype)allocWithTipText:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *vc = [[KKAlertViewController alloc] initWithPresentType:KKUIBaseMiddlePresentType];
    vc.tipText = title;
    vc.rightTitle = leftTitle;
    vc.rightTitle = rightTitle;
    vc.whenCompleteBlock = whenCompleteBlock;
    vc.isOnlyOneButton = NO;
    return vc;
}
@end



@implementation KKAlertViewController (ALLALERT)
/**
 显示文本
 */
+ (KKAlertViewController *)showLabelWithTitle:(NSString *)title complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *alert = [self allocWithTipText:title leftTitle:@"取消" rightTitle:@"打开" complete:whenCompleteBlock];
    alert.isShowCloseButton = NO;
    alert.canTouchBeginMove = YES;
    alert.isOnlyOneButton = YES;
    alert.rightBtn.hidden = YES;
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}

/**
 显示充值成功效果
 */
+ (KKAlertViewController *)showAlertRechargeSuccessWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *alert = [self onlyOneButtonWithTipText:@"充值成功，请登录游戏查看。" oneText:@"知道了" complete:whenCompleteBlock];
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}
/**
 切换猫玩游戏账号
 */
+ (KKAlertViewController *)showAlertSwitchAccountWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *alert = [self allocWithTipText:@"需要切换猫玩账号吗" leftTitle:@"取消" rightTitle:@"切换账号" complete:whenCompleteBlock];
    alert.isShowCloseButton = NO;
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}

/**
 是否退出商品发布
 */
+ (KKAlertViewController *)showAlertBackReleaseWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *alert = [self allocWithTipText:@"是否退出商品发布" leftTitle:@"取消" rightTitle:@"确定" complete:whenCompleteBlock];
    alert.isShowCloseButton = NO;
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}


/**
 是否要删除该商品信息
 */
+ (KKAlertViewController *)showAlertDeleteGoodsDetailWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *alert = [self allocWithTipText:@"是否要删除该商品信息" leftTitle:@"取消" rightTitle:@"确定" complete:whenCompleteBlock];
    alert.isShowCloseButton = NO;
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}
/**
 是否要下架该商品信息
 */
+ (KKAlertViewController *)showAlertShelvesGoodsDetailWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *alert = [self allocWithTipText:@"是否要下架该商品信息" leftTitle:@"取消" rightTitle:@"确定" complete:whenCompleteBlock];
    alert.isShowCloseButton = NO;
    UIViewController *vc = alert.view.topViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    return alert;
}
@end
