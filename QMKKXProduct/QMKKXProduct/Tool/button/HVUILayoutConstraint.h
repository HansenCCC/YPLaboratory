//
//  HVUILayoutConstraint.h
//  hvui
//	进行简单的视图布局约束的基类
//  Created by moon on 15/4/14.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>

//被布局的元素要支持的方法
@protocol HVUILayoutConstraintItemProtocol <NSObject>
- (void)setLayoutFrame:(CGRect)frame;//设置布局尺寸
- (CGRect)layoutFrame;
- (CGSize)sizeOfLayout;//返回尺寸信息
- (BOOL)hidden;//是否隐藏,默认为NO
@optional
- (CGSize)sizeThatFits:(CGSize)size;
- (CGSize)sizeThatFits:(CGSize)size resizeItems:(BOOL)resizeItems;//适合于容器
- (void)layoutItemsWithResizeItems:(BOOL)resizeItems;//适合于容器
@end

typedef NS_ENUM(NSInteger, HVUILayoutConstraintVerticalAlignment) {
	HVUILayoutConstraintVerticalAlignmentCenter  = 0,
	HVUILayoutConstraintVerticalAlignmentTop     = 1,
	HVUILayoutConstraintVerticalAlignmentBottom  = 2,
};
typedef NS_ENUM(NSInteger, HVUILayoutConstraintHorizontalAlignment) {
	HVUILayoutConstraintHorizontalAlignmentCenter = 0,
	HVUILayoutConstraintHorizontalAlignmentLeft   = 1,
	HVUILayoutConstraintHorizontalAlignmentRight  = 2,
};
typedef NS_ENUM(NSUInteger, HVUILayoutConstraintDirection) {
	HVUILayoutConstraintDirectionVertical,//垂直布局
	HVUILayoutConstraintDirectionHorizontal,//水平布局
};

@interface HVUILayoutConstraint : NSObject<HVUILayoutConstraintItemProtocol>{
	@protected
	NSMutableArray<id<HVUILayoutConstraintItemProtocol>> *_items;
}
@property(nonatomic,assign) BOOL hidden;//是否隐藏,默认为NO
@property(nonatomic,strong) NSArray<id<HVUILayoutConstraintItemProtocol>> *items;//@[id<HVUILayoutConstraintItemProtocol>]
@property(nonatomic,assign) CGRect bounds;//在bounds的区域内布局
- (instancetype)initWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items bounds:(CGRect)bounds;
- (void)addItem:(id<HVUILayoutConstraintItemProtocol>)item;
- (void)removeItem:(id<HVUILayoutConstraintItemProtocol>)item;
- (void)layoutItems;//进行布局,子类实现
@property(nonatomic,readonly) NSArray<id<HVUILayoutConstraintItemProtocol>> *visiableItems;//显示的元素,@[id<HVUILayoutConstraintItemProtocol>]
/**
 *  计算适应的bounds的尺寸
 *	@override	子类重量写
 *  @param size 限定的尺寸
 *
 *  @return 合适的尺寸
 */
- (CGSize)sizeThatFits:(CGSize)size;
@end

@interface UIView(HVUILayoutConstraintItemProtocol)<HVUILayoutConstraintItemProtocol>
@end
