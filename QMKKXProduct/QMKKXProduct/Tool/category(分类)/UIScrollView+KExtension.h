//
//  UIScrollView+KExtension.h
//  KExtensionUI
//
//  Created by 程恒盛 on 16/12/3.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (KExtension)

/**
 *  滚动到底部
 *
 *  @param animated 是否动画
 */
- (void)scrollToBottomWithAnimated:(BOOL)animated;
/**
 *  滚动到顶部
 *
 *  @param animated 是否动画
 */
- (void)scrollToTopWithAnimated:(BOOL)animated;
//设UIScrollView的contentSize左上角的坐标为(x,y),则contentOffset=(-x,-y)
@property(nonatomic,readonly) UIEdgeInsets contentOffsetOfRange;//计算contentOffset的x,y取值范围
@property(nonatomic,readonly) CGFloat contentOffsetOfMinY;//contentOffset.y的最小值
@property(nonatomic,readonly) CGFloat contentOffsetOfMaxY;//contentOffset.y的最大值
@property(nonatomic,readonly) CGFloat contentOffsetOfMinX;//contentOffset.x的最小值
@property(nonatomic,readonly) CGFloat contentOffsetOfMaxX;//contentOffset.x的最大值


/**
 scrollview滚动到指定子视图位置

 @param trackView 指定子视图
 */
-(void)scrollToTrackOfPoint:(UIView *) trackView;
@end
