//
//  KKBeeSlider.m
//  QMKKXProduct
//
//  Created by Hansen on 2/19/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKBeeSlider.h"

@implementation KKBeeSlider
//设置UISlider的高度
- (CGRect)trackRectForBounds:(CGRect)bounds{
    //必须通过调用父类的trackRectForBounds 获取一个 bounds 值，否则 Autolayout 会失效，UISlider 的位置会跑偏。
    bounds = [super trackRectForBounds:bounds];
    CGFloat height = AdaptedWidth(4.f);
    return CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height - height, bounds.size.width, height); // 这里面的h即为你想要设置的高度。
}
////设置滑块可触摸范围的大小
//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
//    // 这次如果不调用的父类的方法 Autolayout 倒是不会有问题，但是滑块根本就不动~
//    // w 和 h 是滑块可触摸范围的大小，跟通过图片改变的滑块大小应当一致。
//    bounds = [super thumbRectForBounds:bounds trackRect:rect value:value];
//    CGFloat height = AdaptedWidth(13.f);
//    CGFloat width = AdaptedWidth(13.f);
//    return CGRectMake(bounds.origin.x, bounds.origin.y, height, width);
//}
@end
