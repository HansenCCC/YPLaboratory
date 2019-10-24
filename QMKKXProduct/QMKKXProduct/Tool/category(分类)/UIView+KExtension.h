//
//  UIView+LW.h
//  KExtension
//
//  Created by 程恒盛 on 16/11/15.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KExtension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

#pragma mark - 渐变渲染
/**
 使用CAGradientLayer 实现渐变色
 
 @param frame 范围
 @param colors 颜色集合
 @param isHorizontal 是否是水平方向 default 垂直
 */
- (void)disappearForFrame:(CGRect )frame colors:(NSArray <UIColor *>*) colors isHorizontal:(BOOL )isHorizontal;
/**
 使用CAGradientLayer 实现渐变色
 
 @param colors 颜色集合
 @param isHorizontal 是否是水平方向 default 垂直
 */
- (void)disappearForColors:(NSArray<UIColor *> *)colors isHorizontal:(BOOL )isHorizontal;
//使用CAGradientLayer 实现渐变色
- (void)disappearForFrame:(CGRect )frame colors:(NSArray <UIColor *>*) colors DEPRECATED_ATTRIBUTE;
//使用CAGradientLayer 实现垂直渐变色
- (void)disappearForColors:(NSArray <UIColor *>*) colors DEPRECATED_ATTRIBUTE;

/**
 获取view垂直位置最底部的subview
 */
- (UIView *)horizontalDistanceView;
/**
 获取view水平位置最右部的subview
 */
- (UIView *)verticalDistanceView;


#pragma mark - layout

/**
 返回“最佳”尺寸以适合给定尺寸，切并不会超过给定size尺寸。实际上没有调整视图的大小。x/y 为0时，尺寸不受约束

 @param size 尺寸
 @return 最佳尺寸
 */
-(CGSize)sizeThatFitsToMaxSize:(CGSize)size;

#pragma mark -
/**
 获取屏幕最前面的viewcontoller

 @return viewcontoller
 */
- (UIViewController *)topViewController;
/**
 找出当前视图下class（UIView）类
 
 @param class 寻找的UIView
 @return 返回结果集合
 */
-(NSArray <UIView *>*)traversalAllForClass:(Class) class;

/**
 *  返回视图的截屏图片
 *
 *  @return 图片
 */
- (UIImage *)screenshotsImage;

/**
 *  返回视图的截屏图片
 *
 *  @param scale 图片的 scale 值,0代表屏幕 scale
 *
 *  @return 图片
 */
- (UIImage *)screenshotsImageWithScale:(CGFloat)scale;

/**
 *  计算适应设备朝向的仿射变换矩阵
 *
 *  @param orientation 设备朝向,取值如:[UIDevice currentDevice].orientation
 *
 *  @return 自动旋转后的正常显示,所需要的变换矩阵
 */
+ (CGAffineTransform)transformWithDeviceOrientation:(UIDeviceOrientation)orientation;

/**
 设置高斯模糊
 
 @param image 图片
 @param alpha 通明度
 */
- (void)setImageToBlur:(UIImage *)image alpha:(CGFloat )alpha;
@end



typedef NS_ENUM(NSInteger,UILayoutCornerRadiusType) {
    UILayoutCornerRadiusTop    = 1,
    UILayoutCornerRadiusLeft   = 2,
    UILayoutCornerRadiusBottom = 3,
    UILayoutCornerRadiusRight  = 4,
    UILayoutCornerRadiusAll    = 5
};
typedef NS_OPTIONS(NSUInteger, BorderDirection) {
    BorderDirectionLeft     = 1 << 0,
    BorderDirectionRight    = 1 << 1,
    BorderDirectionBottom  = 1 << 2,
    BorderDirectionTop = 1 << 3,
    BorderDirectionAllCorners  = ~0UL
};
@interface UIView (CornerRadius)
/**
 *  设置不同边的圆角
 *  @param radiusType 圆角类型
 *  @param cornerRadius 圆角半径
 */
-(void)viewLayoutCornerRadiusType:(UILayoutCornerRadiusType)radiusType withCornerRadius:(CGFloat)cornerRadius;
/**
 *  设置不同边的圆角
 *  @param radiusType 圆角类型
 *  @param cornerRadius 圆角半径
 *  @param lineWidth 边框宽度
 *  @param color 边框颜色
 */
-(void)viewLayoutCornerRadiusType:(UILayoutCornerRadiusType)radiusType withCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)lineWidth andBorderColor:(UIColor *)color;

/**
 *  设置可变边框
 *  @param BD          需要显示边框的方向
 *  @param corners     需要设置圆角的方向
 *  @param radius      圆角角度
 *  @param borderWidth 边框的宽度
 *  @param borderColor 边框的颜色
 */
- (void)setVariableRoundedBorder:(CGRect)rect BD:(BorderDirection)BD corners:(UIRectCorner)corners radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
