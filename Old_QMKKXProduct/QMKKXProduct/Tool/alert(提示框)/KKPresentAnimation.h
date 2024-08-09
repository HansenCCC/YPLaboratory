//
//  KKPresentAnimation.h
//  lwui
//  模态转场动画
//  Created by 程恒盛 on 2019/4/1.
//  Copyright © 2019 力王. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,KKPresentAnimationType) {
    KKPresentAnimationTypeBottom = 0,
    KKPresentAnimationTypeMiddle,
};

@interface KKPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) KKPresentAnimationType type;
@property (nonatomic, assign) BOOL isPresent;

- (void)setBottomViewHeight:(CGFloat)height;
@end

