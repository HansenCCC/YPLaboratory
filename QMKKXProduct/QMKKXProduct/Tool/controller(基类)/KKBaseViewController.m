//
//  KKBaseViewController.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/5/28.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKBaseViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation KKBaseViewController
- (instancetype)init{
    if (self = [super init]) {
        //在iOS13中，modalPresentationStyle的默认值是UIModalPresentationAutomatic，而在iOS12以下的版本，默认值是UIModalPresentationFullScreen，这就导致了在iOS13中present出来的页面没法全屏。
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KKColor_FFFFFF;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [self setupNavBackItem];
}
- (void)setupNavBackItem{
    if (self.navigationController.viewControllers.count <= 1) {
        return;
    }
    [self setupNavBackItemConfig];
}
- (void)setupNavBackItemConfig{
    UIImage *itemImg = UIImageWithName(@"kk_icon_back");
    itemImg = [itemImg kk_imageWithTintColor:KKColor_000000];
    self.backBtnImage = itemImg;
}
- (void)backItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setBackBtnImage:(UIImage *)backBtnImage {
    _backBtnImage = backBtnImage;
    UIImage *itemImg = backBtnImage;
    CGFloat backButtonHeight = 44.f;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backButtonHeight , backButtonHeight)];
    self.backButton = backButton;
    backButton.clipsToBounds = YES;
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton setImage:itemImg forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)dealloc{
    NSLog(@"释放了==========[%@ --- deallloc]=========",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - UIGestureRecognizerDelegate
//当手势开始滑动作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //子控制器个数只剩下一个(这一个就是根控制器),手势不可用
    BOOL open = self.childViewControllers.count != 1;
    return open;
}
#pragma mark - 朝向
-(BOOL)prefersStatusBarHidden{
    return NO;
}
-(BOOL)shouldAutorotate{
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
@end
