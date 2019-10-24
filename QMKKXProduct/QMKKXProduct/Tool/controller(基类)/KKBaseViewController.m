//
//  KKBaseViewController.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/5/28.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKBaseViewController.h"

@interface KKBaseViewController ()
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation KKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBackItem];
}
- (void)setupNavBackItem{
    if (self.navigationController.viewControllers.count <= 1) {
        return;
    }
    [self setupNavBackItemConfig];
}
- (void)setupNavBackItemConfig{
    UIImage *itemImg = UIImageWithName(@"kk_bee_back");
    self.backBtnImage = itemImg;
}
- (void)backItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setBackBtnImage:(UIImage *)backBtnImage {
    _backBtnImage = backBtnImage;
    UIImage *itemImg = backBtnImage;
    CGFloat backButtonHeight = 35.f;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, itemImg.size.width + backButtonHeight, backButtonHeight)];
    self.backButton = backButton;
    backButton.clipsToBounds = YES;
    [backButton setImage:itemImg forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -backButtonHeight, 0, 0);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)dealloc{
    NSLog(@"释放了==========[%@ --- deallloc]=========",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
