//
//  YPBaseViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPBaseViewController.h"

@interface YPBaseViewController ()

@end

@implementation YPBaseViewController {
    YPButton *__leftButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yp_backgroundColor];
    
    [self __setNavBarButtonItem];
    
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[UIImage new]];
//    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:18.f]};
    
//    UIColor *barTintColor = [UIColor yp_backgroundColor];
//    // 设置导航栏的背景颜色
//    [self.navigationController.navigationBar setBarTintColor:barTintColor];
//    // 取消导航栏的半透明效果
//    [self.navigationController.navigationBar setTranslucent:NO];
//    //去除底部黑线
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    if (@available(iOS 13.0, *)) {
//        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
//        [appearance configureWithOpaqueBackground];
//        appearance.backgroundColor = barTintColor;
//        [appearance setShadowImage:[[UIImage alloc] init]];
//        self.navigationController.navigationBar.standardAppearance = appearance;
//        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
//    } else {
//        // Fallback on earlier versions
//    }
    // 如果是根试图隐藏侧边按钮
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)__setNavBarButtonItem {
    YPButton *leftButton = [YPButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(0, 0, 44.f, 44.f);
    leftButton.layer.cornerRadius = leftButton.frame.size.height / 2.f;
    [leftButton setImage:[UIImage imageNamed:@"yp_icon_back"] forState:UIControlStateNormal];
    leftButton.imageSize = CGSizeMake(24.f, 24.f);
    [leftButton setTitle:@" " forState:UIControlStateNormal];
    leftButton.interitemSpacing = 10.f;
    leftButton.tintColor = [UIColor yp_blackColor];
    leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [leftButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    __leftButton = leftButton;
}

- (void)backItemClick {
    [[YPShakeManager shareInstance] tapShare];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)allowSideslip {
    return YES;
}

- (void)hiddenLeftBarButtonItem {
    __leftButton.hidden = YES;
}

@end
