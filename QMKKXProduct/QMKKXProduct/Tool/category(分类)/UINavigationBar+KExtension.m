//
//  UINavigationBar+KExtension.m
//  KExtension
//
//  Created by Herson on 17/2/8.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "UINavigationBar+KExtension.h"

@implementation UINavigationBar (KExtension)
-(UIView *)barBackground{
    UIView *barBackground;
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        {
            barBackground = view;
        }
    }
    return barBackground;
}
- (void)setNavigationBarTransparency:(BOOL)transparency{
    if (transparency) {
        //把背景设为空
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //处理导航栏有条线的问题
        [self setShadowImage:[UIImage new]];
    }else{
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:nil];
    }
}
@end
