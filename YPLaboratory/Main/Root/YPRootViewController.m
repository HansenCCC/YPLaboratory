//
//  YPRootViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPRootViewController.h"
#import "YPModuleTableViewController.h"
#import "YPWorldViewController.h"
#import "YPUserViewController.h"

@interface YPRootViewController ()

@property (nonatomic, strong) YPModuleTableViewController *homeViewController;
@property (nonatomic, strong) YPWorldViewController *worldViewController;
@property (nonatomic, strong) YPUserViewController *userViewController;

@end

@implementation YPRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
}

- (void)setupSubviews {
    self.viewControllers = @[
        [self createNavigation:self.homeViewController title:@"实验室".yp_localizedString image:[UIImage imageNamed:@"yp_icon_home"]],
        [self createNavigation:self.worldViewController title:@"世界".yp_localizedString image:[UIImage imageNamed:@"yp_icon_world"]],
        [self createNavigation:self.userViewController title:@"我的".yp_localizedString image:[UIImage imageNamed:@"yp_icon_user"]],
    ];
    self.tabBar.tintColor = [UIColor yp_themeColor];
}

- (YPNavigationViewController *)createNavigation:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image {
    YPNavigationViewController *nav = [[YPNavigationViewController alloc] initWithRootViewController:vc];
    vc.title = title;
    UIColor *select = [UIColor yp_themeColor];
    UIColor *unselect = [UIColor yp_grayColor];
    UIImage *aImage = [[image yp_imageWithTintColor:unselect] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *bSelectImage = [[image yp_imageWithTintColor:select] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:aImage selectedImage:bSelectImage];
    [item setTitleTextAttributes:@{
        NSForegroundColorAttributeName: unselect,
        NSFontAttributeName: [UIFont systemFontOfSize:10.f]
    } forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{
        NSForegroundColorAttributeName: select,
        NSFontAttributeName: [UIFont systemFontOfSize:10.f]
    } forState:UIControlStateSelected];
    nav.tabBarItem = item;
    return nav;
}

#pragma mark - getters | setters

- (YPModuleTableViewController *)homeViewController {
    if (!_homeViewController) {
        _homeViewController = [[YPModuleTableViewController alloc] init];
        _homeViewController.model = [YPRouterManager shareInstance].homeRouter;
    }
    return _homeViewController;
}

- (YPWorldViewController *)worldViewController {
    if (!_worldViewController) {
        _worldViewController = [[YPWorldViewController alloc] init];
    }
    return _worldViewController;
}

- (YPUserViewController *)userViewController {
    if (!_userViewController) {
        _userViewController = [[YPUserViewController alloc] init];
    }
    return _userViewController;
}

@end
