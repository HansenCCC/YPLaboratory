//
//  KKBaseLoadingView.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKBaseLoadingView.h"

@interface KKBaseLoadingView ()
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation KKBaseLoadingView
- (instancetype)init{
    if (self = [super init]) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.backgroundColor = [UIColor clearColor];
        _indicator.color = [UIColor grayColor];
        [_indicator startAnimating];
        [self addSubview:_indicator];
        [_indicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return self;
}

+ (UIView *)showWithView:(UIView *)view translucent:(BOOL)translucent userInteractionEnabled:(BOOL)userInteractionEnabled {
    [KKBaseLoadingView hideWithView:view];
    KKBaseLoadingView *loadingView = [KKBaseLoadingView new];
    loadingView.frame = [UIScreen mainScreen].bounds;
    
#if ISPAD
    //to do
#else
    UIViewController *vc = [KKBaseLoadingView topViewController]; //顶层控件器
    if ([vc.navigationController visibleViewController] && vc.navigationController.navigationBarHidden) {
        CGRect frame = loadingView.frame;
        frame.origin.y = SafeAreaTopHeight;
        loadingView.frame = frame;
    }
#endif
    loadingView.backgroundColor = translucent ? [UIColor clearColor]:[UIColor whiteColor];
    loadingView.userInteractionEnabled = !userInteractionEnabled;
    [view addSubview:loadingView];
    [view bringSubviewToFront:loadingView];
    return loadingView;
}
+ (void)hideWithView:(UIView *)view {
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[KKBaseLoadingView class]]) {
            for (UIView *indicator in v.subviews) {
                if ([indicator isKindOfClass:[UIActivityIndicatorView class]]) {
                    UIActivityIndicatorView *indic = (UIActivityIndicatorView *)indicator;
                    [indic stopAnimating];
                }
            }
            v.hidden = YES;
            [v removeFromSuperview];
        }
    }
}
//拿到顶层控件器
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [KKBaseLoadingView _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [KKBaseLoadingView _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [KKBaseLoadingView _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [KKBaseLoadingView _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}
@end
