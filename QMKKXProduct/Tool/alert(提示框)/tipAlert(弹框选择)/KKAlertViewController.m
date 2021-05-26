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
@property (strong ,nonatomic) UIView *markView;

@end

@implementation KKAlertViewController
- (instancetype)init{
    if (self = [super init]) {
        self.canTouchBeginMove = NO;
        self.isShowCloseButton = YES;
        self.isOnlyOneButton = NO;
        self.contentWidth = AdaptedWidth(260.f);
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
- (void)dismissViewControllerCompletion:(void (^)(void))completion{
    [super dismissViewControllerCompletion:completion];
//    //傻屌动画
//    self.view.alpha = 1;
//    self.contentView.transform = CGAffineTransformIdentity;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.alpha = 0.0f;
//        self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 1.2, 1.2);
//    } completion:^(BOOL finished) {
//        //todo
//        [super dismissViewControllerCompletion:completion];
//    }];
}
- (void)setupSubViews{
    //
    self.titleLabel = [UILabel labelWithFont:AdaptedFontSize(19.f) textColor:KKColor_333333];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.titleLabel];
    //
    self.leftBtn = [[UIButton alloc] init];
    [self.leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:KKColor_333333 forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(whenLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.backgroundColor = KKColor_F0F0F0;
    self.leftBtn.titleLabel.font = AdaptedBoldFontSize(15.f);
    [self.contentView addSubview:self.leftBtn];
    //
    self.rightBtn = [[UIButton alloc] init];
    [self.rightBtn setTitleColor:KKColor_FFFFFF forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(whenRightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.backgroundColor = KKColor_0000FF;
    self.rightBtn.titleLabel.font = AdaptedBoldFontSize(15.f);
    [self.contentView addSubview:self.rightBtn];
    //
    self.textLabel = [UILabel labelWithFont:AdaptedFontSize(15.f) textColor:KKColor_666666];
    self.textLabel.numberOfLines = 10;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLabel];
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
}
- (void)whenRightClick:(id)sender{
    //
    if (self.whenCompleteBlock) {
        self.whenCompleteBlock(self,1);
    }
}
- (void)whenCloseClick:(id)sender{
    //隐藏
    [self dismissViewControllerCompletion:nil];
}
//内容板块布局
- (void)displayContentWillLayoutSubviews{
    //
    CGRect f1 = self.view.bounds;
    CGFloat space = AdaptedWidth(20.f);
    f1.size = [self.textLabel sizeThatFits:CGSizeMake(self.contentView.frame.size.width - space * 2, 0)];
    f1.size.width = self.contentView.frame.size.width - space * 2;
    f1.origin.x = space;
    BOOL flag = self.titleLabel.text.length > 0;
    f1.origin.y = CGRectGetMaxY(self.titleLabel.frame) + (flag?AdaptedWidth(8.f):0);
    self.textLabel.frame = f1;
    self.displayContentView = self.textLabel;
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    //自动布局
    CGSize size = [self.textLabel sizeThatFits:CGSizeZero];
    self.contentWidth = AdaptedWidth(260.f);
    CGFloat height = AdaptedWidth(40.f);
    CGFloat space = AdaptedWidth(20.f);
    if (size.width/2.0 >= self.contentWidth) {
        self.contentWidth = bounds.size.width - 2 * AdaptedWidth(40.f);
        height = AdaptedWidth(40.f);
        self.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    //
    CGRect f1 = bounds;
//    f1.size.width = bounds.size.width - 2 * AdaptedWidth(50.f);
    f1.size.width = self.contentWidth;
    f1.origin.x = (bounds.size.width - f1.size.width)/2;
    //
    CGRect f6 = bounds;
    BOOL flag = self.titleLabel.text.length > 0;
    f6.size = [self.titleLabel sizeThatFits:CGSizeZero];
    f6.size.width = self.contentWidth - AdaptedWidth(20.f);
    f6.origin.x = (f1.size.width - f6.size.width)/2.0f;
    f6.size.height  = flag?f6.size.height:AdaptedWidth(0.f);
    f6.origin.y = space;
    self.titleLabel.frame = f6;
    //内容板块布局
    [self displayContentWillLayoutSubviews];
    //
    f1.size.height = CGRectGetMaxY(self.displayContentView.frame) + height + space;
    f1.origin.y = (bounds.size.height - f1.size.height)/2 - AdaptedWidth(20.f);
    self.contentView.frame = f1;
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
    
    self.contentView.layer.cornerRadius = AdaptedWidth(7.f);
    self.contentView.clipsToBounds = YES;
}
#pragma mark - set|get方法
- (void)setHeadTitle:(NSString *)headTitle{
    _headTitle = headTitle;
    self.titleLabel.text = headTitle;
    //重新布局
    [self viewWillLayoutSubviews];
}
- (void)setTextDetail:(NSString *)textDetail{
    _textDetail = textDetail;
    self.textLabel.text = textDetail;
    self.textLabel.kk_lineSpacing = AdaptedWidth(5.f);
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
}
- (void)setIsOnlyOneButton:(BOOL)isOnlyOneButton{
    _isOnlyOneButton = isOnlyOneButton;
    //重新布局
    [self viewWillLayoutSubviews];
}
@end



@implementation KKAlertViewController (ALLALERT)

/// 自定义提示框
/// @param headTitle 标题
/// @param textDetail  内容
/// @param leftTitle 左边标题
/// @param rightTitle 右边标题
/// @param isOnlyOneButton 是否是有一个按钮 default NO
/// @param isShowCloseButton 是否显示关闭按钮 default YES
/// @param canTouchBeginMove 是否点击空白消失 default YES
/// @param whenCompleteBlock 成功回调
+ (KKAlertViewController *)showCustomWithTitle:(NSString *)headTitle
                                       textDetail:(NSString *)textDetail
                                       leftTitle:(NSString *)leftTitle
                                       rightTitle:(NSString *)rightTitle
                                    isOnlyOneButton:(BOOL )isOnlyOneButton
                                    isShowCloseButton:(BOOL )isShowCloseButton
                                    canTouchBeginMove:(BOOL )canTouchBeginMove
                                      complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    UIWindow *windows = [UIApplication sharedApplication].delegate.window;
    UIViewController *topVC = windows.topViewController;
    //预防重复弹框
    if ([topVC isKindOfClass:[KKUIBasePresentController class]]) {
        return nil;
    }
    KKAlertViewController *vc = [[self alloc] initWithPresentType:KKUIBaseMiddlePresentType];
    vc.headTitle = headTitle;
    vc.textDetail = textDetail;
    vc.leftTitle = leftTitle;
    vc.rightTitle = rightTitle;
    vc.whenCompleteBlock = whenCompleteBlock;
    vc.isOnlyOneButton = isOnlyOneButton;
    vc.isShowCloseButton = isShowCloseButton;
    vc.canTouchBeginMove = canTouchBeginMove;
    [topVC presentViewController:vc animated:YES completion:nil];
    return vc;
}

/// 快速初始化一个按钮的提示框
/// @param title 标题
/// @param textDetail TipText内容
/// @param oneText 按钮内容
/// @param whenCompleteBlock 点击回调
+ (instancetype)allocWithTitle:(NSString *)title textDetail:(NSString *)textDetail oneText:(NSString *)oneText complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    return [self showCustomWithTitle:title textDetail:textDetail leftTitle:nil rightTitle:oneText isOnlyOneButton:YES isShowCloseButton:YES canTouchBeginMove:NO complete:whenCompleteBlock];
}

/**
 快速初始化两个按钮的提示框
 
 @param textDetail TipText内容
 @param leftTitle 左边按钮内容
 @param rightTitle 右边按钮内容
 @param whenCompleteBlock 点击回调
 @return self
 */
+ (instancetype)allocWithTitle:(NSString *)title textDetail:(NSString *)textDetail leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    return [self showCustomWithTitle:title textDetail:textDetail leftTitle:leftTitle rightTitle:rightTitle isOnlyOneButton:NO isShowCloseButton:YES canTouchBeginMove:NO complete:whenCompleteBlock];
}

#pragma mark - 应用内

/// 是否清空原生图片缓存
/// @param whenCompleteBlock 点击回调
+ (instancetype)showAlertDeleteImagesWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *vc = [self allocWithTitle:@"提示" textDetail:@"是否清空原生图片缓存？" leftTitle:@"确定" rightTitle:@"取消" complete:whenCompleteBlock];
    return vc;
}

/// 是否清空图片换成
/// @param whenCompleteBlock 点击回调
+ (instancetype)showAlertDeleteSDWebImagesWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *vc = [self allocWithTitle:@"提示" textDetail:@"是否清空SDWebImage图片缓存？" leftTitle:@"确定" rightTitle:@"取消" complete:whenCompleteBlock];
    return vc;
}

/// 收到应用之间传值
/// @param whenCompleteBlock 点击回调
+ (instancetype)showLabelWithContent:(NSString *)content complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKAlertViewController *vc = [self allocWithTitle:@"提示" textDetail:content oneText:@"确定" complete:whenCompleteBlock];
    return vc;
}

/// 展示支付失败提示
/// @param content 内容
/// @param whenCompleteBlock 回调
+ (instancetype)showPayFailWithContent:(NSString *)content complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    return [KKAlertViewController allocWithTitle:@"购买失败！" textDetail:content oneText:@"确定" complete:whenCompleteBlock];
}

/// 展示支付成功提示
/// @param whenCompleteBlock 回调
+ (instancetype)showPaySuccessWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    return [KKAlertViewController allocWithTitle:@"购买成功！" textDetail:@"您这是干嘛呀，使不得使不得，破费了破费了！" oneText:@"确认" complete:whenCompleteBlock];
}
@end
