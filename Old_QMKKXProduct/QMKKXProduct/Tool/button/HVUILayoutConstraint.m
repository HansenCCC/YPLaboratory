//
//  HVUILayoutConstraint.m
//  hvui
//
//  Created by moon on 15/4/14.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUILayoutConstraint.h"

@implementation HVUILayoutConstraint
- (id)init{
	if (self=[super init]) {
		_items = [[NSMutableArray alloc] init];
	}
	return self;
}
- (id)initWithItems:(NSArray *)items bounds:(CGRect)bounds{
	if(self=[self init]){
		self.items = items;
		self.bounds = bounds;
	}
	return self;
}
- (void)setItems:(NSArray *)items{
	[_items removeAllObjects];
	[_items addObjectsFromArray:items];
}
- (CGSize)sizeThatFits:(CGSize)size{
	if(self.hidden){
		return CGSizeZero;
	}
	return size;
}
- (NSArray *)items{
	return [_items copy];
}
- (NSArray *)visiableItems{
	NSMutableArray *items = [[NSMutableArray alloc] init];
	for (id<HVUILayoutConstraintItemProtocol> item in _items) {
		if(![item hidden]){
			[items addObject:item];
		}
	}
	return items;
}
- (void)addItem:(id<HVUILayoutConstraintItemProtocol>)item{
	if(item&&![_items containsObject:item]){
		[_items addObject:item];
	}
}
- (void)removeItem:(id<HVUILayoutConstraintItemProtocol>)item{
	if(item){
		[_items removeObject:item];
	}
}
- (void)layoutItems{
}
#pragma mark - delegate:HVUILayoutConstraintItemProtocol
- (void)setLayoutFrame:(CGRect)frame{
	self.bounds = frame;
	[self layoutItems];
}
- (CGRect)layoutFrame{
	return self.bounds;
}
- (CGSize)sizeOfLayout{
	CGSize size = self.bounds.size;
	return size;
}
@end

@implementation UIView(HVUILayoutConstraintItemProtocol)
- (void)setLayoutFrame:(CGRect)frame{
	CGRect bounds = self.bounds;
	bounds.size = frame.size;
	self.bounds = bounds;
	CGPoint center = frame.origin;
	center.x += frame.size.width/2;
	center.y += frame.size.height/2;
	self.center = center;
}
- (CGRect)layoutFrame{
	CGRect frame = self.bounds;
	CGPoint center = self.center;
	frame.origin.x = center.x-frame.size.width/2;
	frame.origin.y = center.y-frame.size.height/2;
	return frame;
}
- (CGSize)sizeOfLayout{
	CGSize size = self.bounds.size;
	return size;
}
- (BOOL)hidden{
	return self.isHidden;
}
@end