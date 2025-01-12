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
    
    [self.navigationController.navigationBar yp_resetConfiguration];
    self.navigationController.navigationBar.yp_backgroundColor = [UIColor yp_whiteColor];
    self.navigationController.navigationBar.yp_tintColor = [UIColor yp_blackColor];
    self.navigationController.navigationBar.yp_translucent = NO;
    [self.navigationController.navigationBar yp_configuration];
    
    [self __setNavBarButtonItem];
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
    [[YPShakeManager shareInstance] mediumShake];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)allowSideslip {
    return YES;
}

- (void)hiddenLeftBarButtonItem {
    __leftButton.hidden = YES;
}

@end
