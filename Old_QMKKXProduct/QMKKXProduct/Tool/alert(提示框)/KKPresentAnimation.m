//
//  KKPresentAnimation.m
//  lwui
//
//  Created by 程恒盛 on 2019/4/1.
//  Copyright © 2019 力王. All rights reserved.
//

#import "KKPresentAnimation.h"

@interface KKPresentAnimation ()
@property (assign, nonatomic) CGFloat presentedHeight;

@end


@implementation KKPresentAnimation
- (instancetype)init{
    if(self = [super init]){
        self.presentedHeight = AdaptedWidth(240.f);
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (self.type == KKPresentAnimationTypeBottom) {
        return 0.5f;
    }else if(self.type == KKPresentAnimationTypeMiddle){
        return 0.5f;
    }
    return 1.f;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 设置阴影
    transitionContext.containerView.layer.shadowColor = [UIColor clearColor].CGColor;
    transitionContext.containerView.layer.shadowOffset = CGSizeMake(0, 5);
    transitionContext.containerView.layer.shadowOpacity = 0.5f;
    transitionContext.containerView.layer.shadowRadius = 10.0f;
    //
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = nil;
    UIView *fromView = nil;
    UIView *transView = nil;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    if (self.isPresent) {
        transView = toView;
        [[transitionContext containerView] addSubview:toView];
    }else {
        transView = fromView;
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    }
    
    if (self.type == KKPresentAnimationTypeMiddle) {
        toView.alpha = 0.0f;
        toView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        // 动画弹出
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toView.alpha = 1.0f;
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else{
        toView.alpha = 0.0f;
        toView.transform = CGAffineTransformMakeTranslation(0, self.presentedHeight);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.alpha = 1.0f;
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}
- (void)setBottomViewHeight:(CGFloat)height{
    self.presentedHeight = height;
}
@end
