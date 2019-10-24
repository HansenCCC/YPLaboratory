//
//  KKBaseLoadingView.h
//  FanRabbit
//
//  Created by 程恒盛 on 2019/5/27.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KKBaseLoadingView : UIView

/**
 *  显示加载view
 *  @param view － 当前使用的视图
 *  @param translucent － 是否透明
 *  @param userInteractionEnabled － 使用时是否可以点击别的功能
 */
+ (UIView *)showWithView:(UIView *)view translucent:(BOOL)translucent userInteractionEnabled:(BOOL)userInteractionEnabled;


/**
 *  隐藏加载view
 *  @param view － 当前使用的视图
 */
+ (void)hideWithView:(UIView *)view;

@end

