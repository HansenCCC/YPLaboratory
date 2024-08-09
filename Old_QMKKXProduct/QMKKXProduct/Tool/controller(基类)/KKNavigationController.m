//
//  KKNavigationController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKNavigationController.h"

@interface KKNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KKNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        //在iOS13中，modalPresentationStyle的默认值是UIModalPresentationAutomatic，而在iOS12以下的版本，默认值是UIModalPresentationFullScreen，这就导致了在iOS13中present出来的页面没法全屏。
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KKColor_FFFFFF;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}
#pragma mark - UIGestureRecognizerDelegate
//当手势开始滑动作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //子控制器个数只剩下一个(这一个就是根控制器),手势不可用
    NSArray *vcs = self.childViewControllers;
    BOOL open = vcs.count != 1;
    return open;
}
@end
