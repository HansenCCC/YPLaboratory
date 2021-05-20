//
//  KKGreedySnakeCell.m
//  QMKKXProduct
//
//  Created by Hansen on 6/29/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKGreedySnakeCell.h"

@interface KKGreedySnakeCell ()

@end

@implementation KKGreedySnakeCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        self.backgroundColor = KKColor_FFFFFF;
    }
    return self;
}
- (void)setupSubviews{
    //to do
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.borderWidth = 0.2;
    self.layer.borderColor = KKColor_999999.CGColor;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIColor *color = KKColor_999999;
    [color set]; //设置线条颜色
    CGRect bounds = rect;
    CGRect f1 = bounds;
    CGFloat rowWidth = f1.size.width/4.f;
    CGFloat rowHeight = f1.size.height/4.f;
    //辅助线
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 0.2f;
    //开始画线
    for (int i = 0; i < 4; i ++) {
        //竖
        [path moveToPoint:CGPointMake(rowWidth * (i + 1), 0)];
        [path addLineToPoint:CGPointMake(rowWidth * (i + 1), f1.size.height)];
        //横
        [path moveToPoint:CGPointMake( 0, (i + 1) * rowHeight)];
        [path addLineToPoint:CGPointMake(f1.size.width, (i + 1) * rowHeight)];
    }
    //结束
    [path stroke];
}
@end
