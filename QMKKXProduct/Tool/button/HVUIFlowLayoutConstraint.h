//
//  HVUIFlowLayoutConstraint.h
//  hvui
//	进行水平/垂直方向上的流布局,只会改变元素的位置,不会改变尺寸
//  Created by moon on 15/4/14.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUILayoutConstraint.h"

@interface HVUIFlowLayoutConstraint : HVUILayoutConstraint{
}
@property(nonatomic,assign) HVUILayoutConstraintDirection layoutDirection;//布局方向.默认为HVUILayoutConstraintDirectionVertical
@property(nonatomic,assign) HVUILayoutConstraintVerticalAlignment layoutVerticalAlignment;//所有元素作为一个整体,在垂直方向上的位置,以及每一个元素在整体内的垂直方向上的对齐方式.默认为HVUILayoutConstraintVerticalAlignmentCenter

@property(nonatomic,assign) HVUILayoutConstraintHorizontalAlignment layoutHorizontalAlignment;//所有元素作为一个整体,在水平方向上的位置,以及每一个元素在整体内的水平方向上的对方方式.默认为HVUILayoutConstraintHorizontalAlignmentCenter
@property(nonatomic,assign) UIEdgeInsets contentInsets;//内边距,默认为(0,0,0,0)
@property(nonatomic,assign) CGFloat interitemSpacing;//元素间的间隔,默认为0
@property(nonatomic,assign) BOOL unLimitItemSizeInBounds;//在[self layoutItemsWithResizeItems:YES]时,计算每个元素的尺寸时,是否不受self.bounds容器限制.默认为NO
/**
 *  计算最合适的尺寸
 *
 *  @param size        外层限制
 *  @param resizeItems 是否计算子元素的最合适尺寸。YES：调用子元素的sizeThatFits方法。NO：直接使用子元素的bounds.size
 *
 *  @return 最合适的尺寸
 */
- (CGSize)sizeThatFits:(CGSize)size resizeItems:(BOOL)resizeItems;

/**
 *  对子元素进行布局
 *
 *  @param resizeItems 在布局前,是否让每个子元素自动调整到合适的尺寸
 */
- (void)layoutItemsWithResizeItems:(BOOL)resizeItems;

/**
 *  计算子元素是否不占用空间
 *
 *  @param bounds 在外层容器中的尺寸
 *  @param resizeItems 计算时,是否要计算子元素的最合适尺寸.
 *
 *  @return 是否不占用空间
 */
- (BOOL)isEmptyBounds:(CGRect)bounds withResizeItems:(BOOL)resizeItems;
@end

typedef enum : NSUInteger {
	HVUIFlowLayoutConstraintParam_H_C_C,
	HVUIFlowLayoutConstraintParam_H_C_L,
	HVUIFlowLayoutConstraintParam_H_C_R,
	HVUIFlowLayoutConstraintParam_H_T_C,
	HVUIFlowLayoutConstraintParam_H_T_L,
	HVUIFlowLayoutConstraintParam_H_T_R,
	HVUIFlowLayoutConstraintParam_H_B_L,
	HVUIFlowLayoutConstraintParam_H_B_C,
	HVUIFlowLayoutConstraintParam_H_B_R,
	HVUIFlowLayoutConstraintParam_V_C_C,
	HVUIFlowLayoutConstraintParam_V_C_L,
	HVUIFlowLayoutConstraintParam_V_C_R,
	HVUIFlowLayoutConstraintParam_V_T_C,
	HVUIFlowLayoutConstraintParam_V_T_L,
	HVUIFlowLayoutConstraintParam_V_T_R,
	HVUIFlowLayoutConstraintParam_V_B_C,
	HVUIFlowLayoutConstraintParam_V_B_L,
	HVUIFlowLayoutConstraintParam_V_B_R,
} HVUIFlowLayoutConstraintParam;
@interface HVUIFlowLayoutConstraint(InitMethod)
- (id)initWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items constraintParam:(HVUIFlowLayoutConstraintParam)param contentInsets:(UIEdgeInsets)contentInsets interitemSpacing:(CGFloat)interitemSpacing;
- (void)configWithConstraintParam:(HVUIFlowLayoutConstraintParam)param;
@end
/**
 *
 以下为layoutDirection,layoutVerticalAlignment,layoutHorizontalAlignment的18种组合:
 
 HVUIFlowLayoutConstraintParam_H_C_C
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
 :
 _________________
|                 |
|        B        |
|      A B C      |
|        B        |
|_________________|
 
 HVUIFlowLayoutConstraintParam_H_C_L
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
:
 _________________
|                 |
|  B              |
|A B C            |
|  B              |
|_________________|
 
 HVUIFlowLayoutConstraintParam_H_C_R
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
 :
 _________________
|                 |
|              B  |
|            A B C|
|              B  |
|_________________|
 
 HVUIFlowLayoutConstraintParam_H_T_C
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
 :
 _________________
|      A B C      |
|        B C      |
|        B        |
|                 |
|_________________|
 
 HVUIFlowLayoutConstraintParam_H_T_L
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
 :
 _________________
|A B C            |
|  B C            |
|  B              |
|                 |
|_________________|
 
 HVUIFlowLayoutConstraintParam_H_T_R
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
 :
 _________________
|            A B C|
|              B C|
|              B  |
|                 |
|_________________|

 HVUIFlowLayoutConstraintParam_H_B_L
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
 :
  _________________
 |                 |
 |                 |
 |  B              |
 |  B C            |
 |A_B_C____________|
 
 HVUIFlowLayoutConstraintParam_H_B_C
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
 :
  _________________
 |                 |
 |                 |
 |        B        |
 |        B C      |
 |______A_B_C______|
 
 HVUIFlowLayoutConstraintParam_H_B_R
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
 :
  _________________
 |                 |
 |                 |
 |              B  |
 |              B C|
 |____________A_B_C|
 
 HVUIFlowLayoutConstraintParam_V_C_C
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
 :
 _____
|     |
|  A  |
| BBB |
|  C  |
|_____|
 
 HVUIFlowLayoutConstraintParam_V_C_L
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
 :
 _____
|     |
|A    |
|BBB  |
|CC   |
|_____|
 
 HVUIFlowLayoutConstraintParam_V_C_R
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
 :
 _____
|     |
|    A|
|  BBB|
|   CC|
|_____|
 
 HVUIFlowLayoutConstraintParam_V_T_C
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
 :
 _____
|  A  |
| BBB |
|  C  |
|     |
|_____|
 
 HVUIFlowLayoutConstraintParam_V_T_L
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
 :
 _____
|A    |
|BBB  |
|CC   |
|     |
|_____|
 
 HVUIFlowLayoutConstraintParam_V_T_R
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
 :
 _____
|    A|
|  BBB|
|   CC|
|     |
|_____|
 
 HVUIFlowLayoutConstraintParam_V_B_C
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
 :
 _____
|     |
|     |
|  A  |
| BBB |
|__C__|
 
 HVUIFlowLayoutConstraintParam_V_B_L
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
 :
 _____
|     |
|     |
|A    |
|BBB  |
|CC___|
 
 HVUIFlowLayoutConstraintParam_V_B_R
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
 :
 _____
|     |
|     |
|    A|
|  BBB|
|___CC|
 */
