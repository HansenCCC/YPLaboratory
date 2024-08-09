//
//  HVUIButton.h
//  hvui
//	水平或垂直流布局的按钮
//  Created by moon on 15/4/13.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVUIFlowLayoutConstraint.h"
typedef NS_ENUM(NSUInteger, KKUIFlowLayoutButtonContentStyle) {
    KKUIFlowLayoutButtonContentStyleHorizontal,//左图标,右文本.默认样式
    KKUIFlowLayoutButtonContentStyleVertical,//上图标,下文本
};
@interface KKUIFlowLayoutButton : UIButton{
@protected
	HVUIFlowLayoutConstraint *_flowLayout;
}
@property(nonatomic,assign) KKUIFlowLayoutButtonContentStyle contentStyle;
@property(nonatomic,assign) NSInteger interitemSpacing;//图标与文字之间的间距,默认是3px
@property(nonatomic,assign) BOOL reverseContent;//是否逆转图标与文字的顺序,默认是NO:图标在左/上,文本在右/下
@property(nonatomic,assign) CGSize imageSize;//图片尺寸值,image.size,默认为(0,0),代表自动根据图片大小计算

@property(nonatomic,assign) HVUILayoutConstraintVerticalAlignment layoutVerticalAlignment;//所有元素作为一个整体,在垂直方向上的位置,以及每一个元素在整体内的垂直方向上的对齐方式.默认为HVUILayoutConstraintVerticalAlignmentCenter.详细查看HVUIFlowLayoutConstraint.h

@property(nonatomic,assign) HVUILayoutConstraintHorizontalAlignment layoutHorizontalAlignment;//所有元素作为一个整体,在水平方向上的位置,以及每一个元素在整体内的水平方向上的对方方式.默认为HVUILayoutConstraintHorizontalAlignmentCenter.详细查看HVUIFlowLayoutConstraint.h
@property(nonatomic,assign) UIEdgeInsets contentInsets;//内边距,默认为(0,0,0,0)
@property(nonatomic,readonly) BOOL hiddenImage;
@property(nonatomic,readonly) BOOL hiddenTitle;
- (id)initWithContentStyle:(KKUIFlowLayoutButtonContentStyle)contentStyle;
@end
