//
//  KKArrowContainerView.m
//  QMKKXProduct
//
//  Created by Hansen on 2021/11/8.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKArrowContainerView.h"

@interface KKArrowContainerView ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation KKArrowContainerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.arrowHeight = 10.f;
    self.fromX = 50.f;
    //
    self.arrowContainerCorner = KKArrowContainerCornerTop;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self drawArrowContainerCorner];
}

- (void)drawArrowContainerCorner {
    if (self.arrowContainerCorner == KKArrowContainerCornerTop) {
        CGFloat height = self.frame.size.height - self.arrowHeight;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, self.arrowHeight, self.frame.size.width, height) cornerRadius:5.f];
        [bezierPath moveToPoint:CGPointMake(self.fromX, 0)];
        [bezierPath addLineToPoint:CGPointMake(self.fromX + self.arrowHeight, self.arrowHeight + 1)];//先话右边 不然会出现空
        [bezierPath addLineToPoint:CGPointMake(self.fromX - self.arrowHeight, self.arrowHeight + 1)];
        self.maskLayer.path = bezierPath.CGPath;
        //
        self.layer.shadowPath = bezierPath.CGPath;
        [self.layer addSublayer:self.maskLayer];
    } else if (self.arrowContainerCorner == KKArrowContainerCornerBottom) {
        CGFloat height = self.frame.size.height - self.arrowHeight;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, height) cornerRadius:5.f];
        [bezierPath moveToPoint:CGPointMake(self.fromX, self.frame.size.height)];//箭头定点
        [bezierPath addLineToPoint:CGPointMake(self.fromX - self.arrowHeight, height - 1)];//左边线
        [bezierPath addLineToPoint:CGPointMake(self.fromX + self.arrowHeight, height - 1)];//右边线
        self.maskLayer.path = bezierPath.CGPath;
        //
        self.layer.shadowPath = bezierPath.CGPath;
        [self.layer addSublayer:self.maskLayer];
    }
}

- (void)setArrowContainerCorner:(KKArrowContainerCorner)arrowContainerCorner {
    _arrowContainerCorner = arrowContainerCorner;
    [self drawArrowContainerCorner];
}

#pragma mark - setter
- (void)setBackgroundColor:(UIColor *)backgroundColor {
//    [super setBackgroundColor:backgroundColor];
    self.maskLayer.fillColor = backgroundColor.CGColor;
}

#pragma mark - getter

- (CAShapeLayer *)maskLayer {
    if (_maskLayer) {
        return _maskLayer;
    }
    _maskLayer = [[CAShapeLayer alloc] init];
    return _maskLayer;
}

@end
