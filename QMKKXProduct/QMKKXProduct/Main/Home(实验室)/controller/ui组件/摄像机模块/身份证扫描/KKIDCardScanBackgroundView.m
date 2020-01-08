//
//  KKIDCardScanBackgroundView.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/7/1.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKIDCardScanBackgroundView.h"

@interface KKIDCardScanBackgroundView ()
@property(nonatomic, strong) UIView *maskView;//contentView
@end

@implementation KKIDCardScanBackgroundView
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //
    CGRect f1 = self.transparentFrame;
    UIBezierPath *aPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [aPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:f1 cornerRadius:1] bezierPathByReversingPath]];
    //
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = aPath.CGPath;
    self.maskView.layer.mask = maskLayer;
}
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        //
        self.maskView  = [[UIView alloc] init];
        self.maskView.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.3];
        [self addSubview:self.maskView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //
    CGRect bounds = self.bounds;
    self.maskView.frame = bounds;
}
@end
