//
//  KKQGDZLAnimalView.m
//  QMKKXProduct
//
//  Created by Hansen on 2/26/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKQGDZLAnimalView.h"

@interface KKQGDZLAnimalView ()
@property (strong, nonatomic) UIImageView *backgroundView;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;
@property (assign, nonatomic) CGFloat xLastProgress;//上次进度
@property (assign, nonatomic) CGFloat yLastProgress;//上次进度

@end

@implementation KKQGDZLAnimalView
- (instancetype)init{
    if (self = [super init]) {
        self.image = UIImageWithName(@"img-cubeframe.png");
        self.xProgress = 0;
        self.yProgress = 0;
        [self setupSubviews];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}
- (CGSize)sizeThatFits:(CGSize)size{
    CGSize t_size = self.image.size;
    size.height = t_size.height/t_size.width * size.width;
    return size;
}
- (void)setupSubviews{
    //
    self.leftView = [[UIView alloc] init];
    self.leftView.alpha = 0.98f;
    [self addSubview:self.leftView];
    //
    self.rightView = [[UIView alloc] init];
    self.rightView.alpha = 0.98f;
    [self addSubview:self.rightView];
    //
    self.backgroundView = [[UIImageView alloc] init];
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundView.image = self.image;
    [self addSubview:self.backgroundView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    self.backgroundView.frame = bounds;
    //
    CGFloat xProgress = self.xProgress;
    CGFloat yProgress = self.yProgress;
    //
    CGRect f2 = bounds;
    f2.origin.y = (1 - xProgress) * bounds.size.height/2.0;
    f2.size.width = f2.size.width/2.0;
    self.leftView.frame = f2;
    //
    CGRect f3 = bounds;
    f3.origin.x = CGRectGetMaxX(f2);
    f3.origin.y = (1 - yProgress) * bounds.size.height/2.0;
    f3.size.width = f3.size.width/2.0;
    self.rightView.frame = f3;
}
- (void)setXProgress:(CGFloat)xProgress{
    //记录上一个点
    self.xLastProgress = _xProgress;
    _xProgress = xProgress;
    //动画移动
    [self updateXProgress];
}
- (void)setYProgress:(CGFloat)yProgress{
    self.yLastProgress = _yProgress;
    _yProgress = yProgress;
    [self updateYProgress];
}
- (void)updateXProgress{
    [self layoutSubviews];
    //增加渐变色
    [self.leftView disappearForColors:@[[UIColor colorWithHexString:@"8bf9fa"],[UIColor colorWithHexString:@"408fda"]] isHorizontal:NO];
    CGFloat xLastProgress = self.xLastProgress;
    CGFloat xProgress = self.xProgress;
    CGFloat threshold = (xProgress - xLastProgress)/4.0f;
    CAShapeLayer *layer = [CAShapeLayer layer];
    self.leftView.layer.mask = layer;
    NSArray *items = @[@(xLastProgress),@(xProgress),@(xProgress - threshold),@(xProgress),@(xProgress - threshold/2),@(xProgress)];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (NSNumber *number in items) {
        UIBezierPath *path = [self xBuildBezierPathWithProgress:number.floatValue];
        [values addObject:(id)path.CGPath];
    }
    //动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation.values = values;
    keyAnimation.duration = 1.f;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:keyAnimation forKey:@"animation"];
}
- (UIBezierPath *)xBuildBezierPathWithProgress:(CGFloat)progress{
    CGRect bounds = self.bounds;
    //
    CGFloat spaceWidth = bounds.size.height * 0.01;//线条宽度
    CGFloat topSapce = bounds.size.height * 0.075;//顶部高度
    CGFloat top2Sapce = bounds.size.height * 0.155;//顶部2高度
    CGFloat bottomSpace = bounds.size.height * 0.119;//低部高度
    CGFloat boxHeight = bounds.size.height - top2Sapce;//长方形高度
    CGFloat differenceHeight = -bounds.size.height * 0.05;//阈值差值高度
    CGFloat threshold = self.leftView.frame.origin.y;//设置阈值;
    //
    CGRect f1 = bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(spaceWidth,  f1.size.height - bottomSpace - spaceWidth - threshold)]; //起点
    [path addLineToPoint:CGPointMake(f1.size.width/2.0, f1.size.height - spaceWidth - threshold)];
    [path addLineToPoint:CGPointMake(f1.size.width/2.0, top2Sapce + boxHeight * (1 - progress) + spaceWidth - threshold - spaceWidth)];
    [path addLineToPoint:CGPointMake(spaceWidth, topSapce + (boxHeight + differenceHeight) * (1 - progress) - threshold)]; //终点
    [path closePath];
    return path;
}
- (void)updateYProgress{
    [self layoutSubviews];
    //增加渐变色
    [self.rightView disappearForColors:@[[UIColor colorWithHexString:@"98f7fb"],[UIColor colorWithHexString:@"67c644"]] isHorizontal:NO];
    CGFloat yLastProgress = self.yLastProgress;
    CGFloat yProgress = self.yProgress;
    CGFloat threshold = (yProgress - yLastProgress)/4.0f;
    CAShapeLayer *layer = [CAShapeLayer layer];
    self.rightView.layer.mask = layer;
    NSArray *items = @[@(yLastProgress),@(yProgress),@(yProgress - threshold),@(yProgress),@(yProgress - threshold/2),@(yProgress)];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (NSNumber *number in items) {
        UIBezierPath *path = [self yBuildBezierPathWithProgress:number.floatValue];
        [values addObject:(id)path.CGPath];
    }
    //动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    keyAnimation.values = values;
    keyAnimation.duration = 1.f;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:keyAnimation forKey:@"animation"];
}
- (UIBezierPath *)yBuildBezierPathWithProgress:(CGFloat)progress{
    CGRect bounds = self.bounds;
    //
    CGFloat spaceWidth = bounds.size.height * 0.01;//线条宽度
    CGFloat topSapce = bounds.size.height * 0.075;//顶部高度
    CGFloat top2Sapce = bounds.size.height * 0.155;//顶部2高度
    CGFloat bottomSpace = bounds.size.height * 0.119;//低部高度
    CGFloat boxHeight = bounds.size.height - top2Sapce;//长方形高度
    CGFloat differenceHeight = -bounds.size.height * 0.05;//阈值差值高度
    CGFloat threshold = self.rightView.frame.origin.y;//设置阈值;
    //
    CGRect f1 = bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(spaceWidth - spaceWidth, f1.size.height - spaceWidth - threshold)]; //起点
    [path addLineToPoint:CGPointMake(f1.size.width/2.0 - spaceWidth,f1.size.height - bottomSpace - spaceWidth - threshold)];
    [path addLineToPoint:CGPointMake(f1.size.width/2.0 - spaceWidth,topSapce + (boxHeight + differenceHeight) * (1 - progress) - threshold)];
    [path addLineToPoint:CGPointMake(spaceWidth - spaceWidth, top2Sapce + boxHeight * (1 - progress) + spaceWidth - threshold - spaceWidth)]; //终点
    [path closePath];
    return path;
}
- (CGPoint)xPointForProgress:(CGFloat)progress{
    CGRect bounds = self.bounds;
    //
    CGFloat spaceWidth = bounds.size.height * 0.01;//线条宽度
    CGFloat top2Sapce = bounds.size.height * 0.155;//顶部2高度
    CGFloat boxHeight = bounds.size.height - top2Sapce;//长方形高度
    //
    CGPoint point = self.backgroundView.center;
    point.y = top2Sapce + boxHeight * (1 - progress) + spaceWidth - spaceWidth;
    return point;
}
- (CGPoint)yPointForProgress:(CGFloat)progress{
    CGRect bounds = self.bounds;
    //
    CGFloat spaceWidth = bounds.size.height * 0.01;//线条宽度
    CGFloat top2Sapce = bounds.size.height * 0.155;//顶部2高度
    CGFloat boxHeight = bounds.size.height - top2Sapce;//长方形高度
    //
    CGPoint point = self.backgroundView.center;
    point.y = top2Sapce + boxHeight * (1 - progress) + spaceWidth - spaceWidth;
    return point;
}
@end

/*
     //动画
 //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
 //    animation.fromValue = (id)fromPath.CGPath;
 //    animation.toValue = (id)toPath.CGPath;
 //    animation.duration = 0.5f;
 //    animation.removedOnCompletion = NO;
 //    animation.fillMode = kCAFillModeForwards;
 //    // 动画先加速后减速
 //    //kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉,这个是默认的动画行为。
 //    //kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
 //    //kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
 //    //kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。
 //    animation.timingFunction =
 //        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
 //    [layer addAnimation:animation forKey:@"animation"];
 
 
    //
//    CGFloat spaceWidth = bounds.size.height * 0.01;//线条宽度
//    CGFloat topSapce = bounds.size.height * 0.075;//顶部高度
//    CGFloat top2Sapce = bounds.size.height * 0.16;//顶部2高度
//    CGFloat bottomSpace = bounds.size.height * 0.119;//低部高度
//    CGFloat boxHeight = bounds.size.height - top2Sapce;//长方形高度
//    CGFloat threshold = f2.origin.y;//设置阈值;
//    //
//    CGRect f1 = bounds;
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(spaceWidth, f1.size.height - bottomSpace - spaceWidth - threshold)]; //起点
//    [path addLineToPoint:CGPointMake(f1.size.width/2.0, f1.size.height - spaceWidth - threshold)];
//    [path addLineToPoint:CGPointMake(f1.size.width/2.0, topSapce * 2 + boxHeight * (1 - xProgress) + spaceWidth - threshold)];
//    [path addLineToPoint:CGPointMake(spaceWidth, topSapce + boxHeight * (1 - xProgress) - threshold)]; //终点
//    [path closePath];
    //
    
//    layer.masksToBounds = YES;
//    [self.layer insertSublayer:layer atIndex:0];
//    [self.layer addSublayer:layer];
    

//    [self.leftView disappearForColors:@[[UIColor redColor],[UIColor blueColor]] isHorizontal:NO];
//    CATransform3D perspective = CATransform3DIdentity;
//    perspective.m34 = - 1.0 / 500.0;
//    perspective = CATransform3DRotate(perspective, M_PI_4, 0, 1, 0);
//    self.leftView.layer.transform = perspective;
//    CATransform3D transform = CATransform3DMakeRotation(-M_PI/4, 0, 1, 0);
//    self.leftView.layer.transform = transform;

//    NSArray *colors = @[[UIColor redColor],[UIColor blueColor]];
//    NSMutableArray *cGColor = [[NSMutableArray alloc] init];
//    for (UIColor *color in colors) {
//        [cGColor addObject:(id)color.CGColor];
//    }
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = bounds; // 设置显示的frame
//    gradientLayer.colors = cGColor;  // 设置渐变颜色
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);//0-1 垂直  1-0 水平
//    gradientLayer.cornerRadius = self.layer.cornerRadius;
//    [self.layer insertSublayer:gradientLayer atIndex:0];
*/
