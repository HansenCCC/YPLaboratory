//
//  YPNavigationViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPNavigationViewController.h"
#import "UINavigationBar+YPExtension.h"

@interface YPNavigationViewController () <UIGestureRecognizerDelegate>

@end

@implementation YPNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar yp_resetConfiguration];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

#pragma mark - UIGestureRecognizerDelegate
//当手势开始滑动作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    [[YPShakeManager shareInstance] tapShake];
    //子控制器个数只剩下一个(这一个就是根控制器),手势不可用
    NSArray *vcs = self.childViewControllers;
    if (vcs.count > 1) {
        YPBaseViewController *vc = vcs.lastObject;
        if ([vc isKindOfClass:[YPBaseViewController class]]) {
            return [vc allowSideslip];
        } else {
            return YES;
        }
    }
    BOOL open = vcs.count != 1;
    return open;
}

@end
