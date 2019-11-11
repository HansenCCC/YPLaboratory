//
//  KKRootViewController.m
//  Bee
//
//  Created by 程恒盛 on 2019/10/14.
//  Copyright © 2019 南京猫玩. All rights reserved.
//

#import "KKRootViewController.h"

@interface KKRootViewController ()<UINavigationControllerDelegate,UITabBarControllerDelegate>
@property (strong, nonatomic) UIViewController *homeViewController;//首页
@property (strong, nonatomic) UIViewController *worldViewController;//世界
@property (strong, nonatomic) UIViewController *userViewController;//用户
@property (strong, nonatomic) UIImageView *startImageView;//启动图片

@end

@implementation KKRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showStartImageView];
    [self setupSubview];
    [self addObserverNotification];
}
- (void)setupSubview{
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = KKColor_F0F0F0;
    //
    KKNavigationController *navHomeVC = [self createNavigation:self.homeViewController title:@"实验室" image:UIImageWithName(@"kk_icon_tabbarHome") selectImage:UIImageWithName(@"kk_icon_tabbarHome")];
    KKNavigationController *navWorldVC = [self createNavigation:self.worldViewController title:@"世界" image:UIImageWithName(@"kk_icon_tabbarWorld") selectImage:UIImageWithName(@"kk_icon_tabbarWorld")];
    KKNavigationController *navUserVC = [self createNavigation:self.userViewController title:@"我的" image:UIImageWithName(@"kk_icon_tabbarUser") selectImage:UIImageWithName(@"kk_icon_tabbarUser")];
    //
    NSArray *vcs = @[navHomeVC,navWorldVC,navUserVC];
    self.viewControllers = vcs;
}
//显示启动图片
- (void)showStartImageView{
    //普通图片
    NSString *imgPath = [KKUser shareInstance].startImg;
    if (imgPath.length > 0) {
        self.startImageView = [[UIImageView alloc] init];
        self.startImageView.backgroundColor = KKColor_FFFFFF;
        self.startImageView.frame = [UIScreen mainScreen].bounds;
        self.startImageView.userInteractionEnabled = YES;
        [self.startImageView kk_setImageWithUrl:imgPath];
        [self.startImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.view addSubview:self.startImageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                self.startImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                self.startImageView.alpha = 0;
            } completion:^(BOOL finished) {
                [self.startImageView removeFromSuperview];
                self.startImageView = nil;
                //检查版本
                [self checkVersion];
            }];
        });
    }else{
        //检查版本
        [self checkVersion];
    }
}
//快速创建navigation
- (KKNavigationController *)createNavigation:(UIViewController *)viewController title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage{
    KKNavigationController *nav = [[KKNavigationController alloc] initWithRootViewController:viewController];
    nav.delegate = self;
    viewController.title = title;
    image = [image imageWithTintColor:KKColor_2C2C2C];
    selectImage = [selectImage imageWithTintColor:KKColor_1296DB];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:KKColor_2C2C2C, NSFontAttributeName:AdaptedFontSize(8.f)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:KKColor_1296DB, NSFontAttributeName:AdaptedFontSize(8.f)} forState:UIControlStateSelected];
    nav.tabBarItem = item;
    return nav;
}
#pragma mark - notification
- (void)addObserverNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenNeedLogin:) name:kNSNotificationCenterLogging object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenNeedBeePlayAuthLogin:) name:kNSNotificationCenterBeePlayAuthLogin object:nil];
}
//唤起登录注册界面
- (void)whenNeedLogin:(NSNotification *)info{
    //to do
}
//bee唤起授权界面
- (void)whenNeedBeePlayAuthLogin:(NSNotification *)info{
    //to do
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - UITabBarControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //to do
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //to do
}
#pragma mark - 网络请求
//检查版本
- (void)checkVersion{
    //to do
}
#pragma mark - lazy load
//home
- (UIViewController *)homeViewController{
    if (!_homeViewController) {
        _homeViewController = [[UIViewController alloc] init];
    }
    return _homeViewController;
}
//世界
- (UIViewController *)worldViewController{
    if (!_worldViewController) {
        _worldViewController = [[UIViewController alloc] init];
    }
    return _worldViewController;
}
//用户
- (UIViewController *)userViewController{
    if (!_userViewController) {
        _userViewController = [[UIViewController alloc] init];
    }
    return _userViewController;
}
@end
