//
//  UIView+LW.m
//  KExtension
//
//  Created by 程恒盛 on 16/11/15.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "UIView+KExtension.h"
#import "UIImage+KExtension.h"

@implementation UIView (KExtension)
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}
#pragma mark - 渐变渲染
//使用CAGradientLayer 实现渐变色
- (void)disappearForFrame:(CGRect )frame colors:(NSArray <UIColor *>*) colors isHorizontal:(BOOL )isHorizontal{
    NSArray *views = [NSArray arrayWithArray:self.layer.sublayers];
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAGradientLayer class]]) {
            [obj removeFromSuperlayer];
        }
    }];
    NSMutableArray *cGColor = [[NSMutableArray alloc] init];
    for (UIColor *color in colors) {
        [cGColor addObject:(id)color.CGColor];
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame; // 设置显示的frame
    gradientLayer.colors = cGColor;  // 设置渐变颜色
    gradientLayer.startPoint = CGPointMake(0, 0);
    if (isHorizontal) {
        gradientLayer.endPoint = CGPointMake(1, 0);//0-1 垂直  1-0 水平
    }else{
        gradientLayer.endPoint = CGPointMake(0, 1);//0-1 垂直  1-0 水平
    }
    gradientLayer.cornerRadius = self.layer.cornerRadius;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}
- (void)disappearForFrame:(CGRect )frame colors:(NSArray <UIColor *>*) colors{
    [self disappearForFrame:frame colors:colors isHorizontal:NO];
}
- (void)disappearForColors:(NSArray<UIColor *> *)colors{
    [self disappearForFrame:self.bounds colors:colors isHorizontal:NO];
}
- (void)disappearForColors:(NSArray<UIColor *> *)colors isHorizontal:(BOOL )isHorizontal{
    [self disappearForFrame:self.bounds colors:colors isHorizontal:isHorizontal];
}
//获取view垂直位置最底部的subview
- (UIView *)horizontalDistanceView{
    UIView *view = nil;
    for (UIView *subview in self.subviews) {
        if (CGRectGetMaxY(subview.frame) > CGRectGetMaxY(view.frame)) {
            view = subview;
        };
    }
    return view;
}
//获取view水平位置最右部的subview
- (UIView *)verticalDistanceView{
    UIView *view = nil;
    for (UIView *subview in self.subviews) {
        if (CGRectGetMaxX(subview.frame) > CGRectGetMaxX(view.frame)) {
            view = subview;
        };
    }
    return view;
}

- (CGSize)sizeThatFitsToMaxSize:(CGSize)size{
    return [self sizeThatFits:size];
}
- (UIImage *)screenshotsImageWithScale:(CGFloat)scale{
    CGRect bounds = self.bounds;
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, scale);
    //    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)screenshotsImage{
    UIImage *image = [self screenshotsImageWithScale:0.0];
    return image;
}
+ (CGAffineTransform)transformWithDeviceOrientation:(UIDeviceOrientation)orientation{
    CGAffineTransform m = CGAffineTransformIdentity;
    switch (orientation) {
            case UIDeviceOrientationLandscapeLeft:
            m = CGAffineTransformMakeRotation(M_PI_2);
            break;
            case UIDeviceOrientationLandscapeRight:
            m = CGAffineTransformMakeRotation(-M_PI_2);
            break;
            case UIDeviceOrientationPortrait:
            break;
            case UIDeviceOrientationPortraitUpsideDown:
            m = CGAffineTransformMakeRotation(M_PI);
            break;
        default:
            break;
    }
    return m;
}
-(NSArray <UIView *>*)traversalAllForClass:(Class) class{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:class]) {
            [views addObject:v];
        }
        [views addObjectsFromArray:[v traversalAllForClass:class]];
    }
    return views.count>0?views:nil;
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

//高斯模糊
- (void)setImageToBlur:(UIImage *)image alpha:(CGFloat )alpha{
    //遍历移除重复UIBlurEffect
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIVisualEffectView class]]){
            [view removeFromSuperview];
        }
    }
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    CGRect bounds = self.bounds;
    effectView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    effectView.alpha = alpha;
    [self addSubview:effectView];
}
@end

@implementation UIView (CornerRadius)
-(void)viewLayoutCornerRadiusType:(UILayoutCornerRadiusType)radiusType withCornerRadius:(CGFloat)cornerRadius{
    [self layoutIfNeeded];
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *maskPath = [self setShapeLayerUIBezierPath:radiusType size:cornerSize];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    borderLayer.path = maskPath.CGPath;
    self.layer.mask = borderLayer;
}
-(void)viewLayoutCornerRadiusType:(UILayoutCornerRadiusType)radiusType withCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)lineWidth andBorderColor:(UIColor *)color{
    [self layoutIfNeeded];
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *maskPath = [self setShapeLayerUIBezierPath:radiusType size:cornerSize];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.lineWidth = lineWidth;
    borderLayer.lineCap = kCALineCapSquare;
    borderLayer.frame = self.bounds;
    borderLayer.path = maskPath.CGPath;
    self.layer.mask = borderLayer;
    // 带边框则两个颜色不要设置成一样即可
    borderLayer.strokeColor = color.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer insertSublayer:borderLayer atIndex:0];
    //
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    maskLayer.path = maskPath.CGPath;
    [self.layer setMask:maskLayer];
}
- (UIBezierPath *)setShapeLayerUIBezierPath:(UILayoutCornerRadiusType)radiusType size:(CGSize)cornerSize{
    UIBezierPath *maskPath;
    switch (radiusType) {
            case UILayoutCornerRadiusTop:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:cornerSize];
        }
            break;
            case UILayoutCornerRadiusLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft) cornerRadii:cornerSize];
        }
            break;
            case UILayoutCornerRadiusBottom:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:cornerSize];
        }
            break;
            case UILayoutCornerRadiusRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight) cornerRadii:cornerSize];
        }
            break;
            case UILayoutCornerRadiusAll:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerSize];
            
        }
            break;
    }
    return maskPath;
}
/**
 *  设置可变边框
 *  @param BD          需要显示边框的方向
 *  @param corners     需要设置圆角的方向
 *  @param radius      圆角角度
 *  @param borderWidth 边框的宽度
 *  @param borderColor 边框的颜色
 */
- (void)setVariableRoundedBorder:(CGRect)rect BD:(BorderDirection)BD corners:(UIRectCorner)corners radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    if (corners != 0) {
        [self setRounded:rect view:self corners:corners];
    }
    if (BD != 0) {
        [self drawInContext:UIGraphicsGetCurrentContext() view:self BD:BD corners:corners radius:radius borderWidth:borderWidth borderColor:borderColor];
    }
}
/**
 *  设置圆角
 *
 *  @param rect 范围
 *  @param view 视图
 *  @param corners 需要设置圆角的方向
 */
- (void)setRounded:(CGRect)rect view:(UIView *)view corners:(UIRectCorner)corners{
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(6, 6)];
    maskPath.lineWidth     = 0.f;
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
- (void)drawInContext:(CGContextRef)context view:(UIView *)view BD:(BorderDirection)BD corners:(UIRectCorner)corners radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    CGContextSetLineWidth(context, borderWidth);
    CGRect rrect = view.bounds;
    CGFloat height = rrect.size.height;
    CGFloat width = rrect.size.width;
    [borderColor set];
    NSInteger BorderDirectionNumber = 0;
    if (BD & BorderDirectionLeft) {
        BorderDirectionNumber++;
    }
    if (BD & BorderDirectionRight) {
        BorderDirectionNumber++;
    }
    if (BD & BorderDirectionBottom) {
        BorderDirectionNumber++;
    }
    if (BD & BorderDirectionTop) {
        BorderDirectionNumber++;
    }
    if (BorderDirectionNumber == 4) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddArcToPoint(context, 0, height, width, height, radius);
        CGContextAddArcToPoint(context, width, height, width, 0, radius);
        CGContextAddArcToPoint(context,  width, 0, 0, 0, radius);
        CGContextAddArcToPoint(context,  0, 0, 0, height, radius);
        CGContextStrokePath(context);
    }else if (BorderDirectionNumber == 3){
        if (BD & BorderDirectionLeft && BD & BorderDirectionBottom && BD & BorderDirectionRight) {
            [self drawThreeSide:context radius:radius oneX:0 oneY:0 twoX:0 twoY:height threeX:width threeY:height foruX:width foruY:0];
            
        }else if (BD & BorderDirectionLeft && BD & BorderDirectionBottom && BD & BorderDirectionTop){
            [self drawThreeSide:context radius:radius oneX:width oneY:0 twoX:0 twoY:0 threeX:0 threeY:height foruX:width foruY:height];
            
        }else if (BD & BorderDirectionBottom && BD & BorderDirectionRight && BD & BorderDirectionTop){
            [self drawThreeSide:context radius:radius oneX:0 oneY:height twoX:width twoY:height threeX:width threeY:0 foruX:0 foruY:0];
            
        }else if (BD & BorderDirectionLeft && BD & BorderDirectionRight && BD & BorderDirectionTop){
            [self drawThreeSide:context radius:radius oneX:0 oneY:height twoX:0 twoY:0 threeX:width threeY:0 foruX:width foruY:height];
        }
    }else if (BorderDirectionNumber == 2){
        if (BD & BorderDirectionLeft && BD & BorderDirectionBottom) {
            [self drawTwoSide:context radius:radius oneX:0 oneY:0 twoX:0 twoY:height threeX:width threeY:height foruX:width foruY:0];
        }else if (BD & BorderDirectionLeft && BD & BorderDirectionRight){
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, 0, height);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, width, 0);
            CGContextAddLineToPoint(context, width, height);
            CGContextStrokePath(context);
        }else if (BD & BorderDirectionLeft && BD & BorderDirectionTop){
            [self drawTwoSide:context radius:radius oneX:0 oneY:height twoX:0 twoY:0 threeX:width threeY:0 foruX:width foruY:height];
        }else if (BD & BorderDirectionBottom && BD & BorderDirectionRight){
            [self drawTwoSide:context radius:radius oneX:0 oneY:height twoX:width twoY:height threeX:width threeY:0 foruX:0 foruY:0];
        }else if (BD & BorderDirectionBottom && BD & BorderDirectionTop){
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, width, 0);
            CGContextStrokePath(context);
            CGContextMoveToPoint(context, 0, height);
            CGContextAddLineToPoint(context, width, height);
            CGContextStrokePath(context);
        }else if (BD & BorderDirectionRight && BD & BorderDirectionTop){
            [self drawTwoSide:context radius:radius oneX:0 oneY:0 twoX:width twoY:height threeX:width threeY:height foruX:0 foruY:height];
        }
    }else if (BorderDirectionNumber == 1){
        if (BD & BorderDirectionLeft) {
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, 0, height);
            CGContextStrokePath(context);
        }else if (BD & BorderDirectionRight){
            CGContextMoveToPoint(context, width, 0);
            CGContextAddLineToPoint(context, width, height);
            CGContextStrokePath(context);
        }else if (BD & BorderDirectionTop){
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, width, 0);
            CGContextStrokePath(context);
        }else if (BD & BorderDirectionBottom){
            CGContextMoveToPoint(context, 0, height);
            CGContextAddLineToPoint(context, width, height);
            CGContextStrokePath(context);
        }
    }
}
- (void)drawThreeSide:(CGContextRef)context radius:(CGFloat)radius oneX:(CGFloat)oneX  oneY:(CGFloat)oneY twoX:(CGFloat)twoX  twoY:(CGFloat)twoY threeX:(CGFloat)threeX threeY:(CGFloat)threeY foruX:(CGFloat)foruX foruY:(CGFloat)foruY{
    CGContextMoveToPoint(context, oneX, oneY);
    CGContextAddArcToPoint(context, twoX, twoY, threeX, threeY, radius);
    CGContextAddArcToPoint(context, threeX, threeY, foruX, foruY, radius);
    CGContextAddArcToPoint(context,  foruX, foruY, oneX, oneY, 0);
    CGContextStrokePath(context);
}
- (void)drawTwoSide:(CGContextRef)context radius:(CGFloat)radius oneX:(CGFloat)oneX  oneY:(CGFloat)oneY twoX:(CGFloat)twoX  twoY:(CGFloat)twoY threeX:(CGFloat)threeX threeY:(CGFloat)threeY foruX:(CGFloat)foruX foruY:(CGFloat)foruY{
    CGContextMoveToPoint(context, oneX, oneY);
    CGContextAddArcToPoint(context, twoX, twoY, threeX, threeY, radius);
    CGContextAddArcToPoint(context, threeX, threeY, foruX, foruY, 0);
    CGContextStrokePath(context);
}
@end
