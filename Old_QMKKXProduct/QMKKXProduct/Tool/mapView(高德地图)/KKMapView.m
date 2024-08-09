//
//  KKMapView.m
//  KKLAFProduct
//
//  Created by Hansen on 7/29/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKMapView.h"

@implementation KKMapView
- (instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    //启动自定义地图
    //styleData
//    NSString *style = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"data"];
//    NSData *styleData = [NSData dataWithContentsOfFile:style];
//    //styleExtraData
//    NSString *styleExtra = [[NSBundle mainBundle] pathForResource:@"style_extra" ofType:@"data"];
//    NSData *styleExtraData = [NSData dataWithContentsOfFile:styleExtra];
//    //
//    MAMapCustomStyleOptions *options = [[MAMapCustomStyleOptions alloc] init];
//    options.styleData = styleData;
//    options.styleExtraData = styleExtraData;
//    [self setCustomMapStyleOptions:options];
//    [self setCustomMapStyleEnabled:YES];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    CGFloat vertical = AdaptedWidth(8.f);//垂直
    CGFloat horizontal = AdaptedWidth(5.f);//水平
    //配置指南针位置
    self.compassOrigin = CGPointMake(f1.size.width - self.compassSize.width - horizontal, vertical);
    //配置比例尺原点位置
    self.scaleOrigin = CGPointMake(horizontal, vertical);
}
@end
