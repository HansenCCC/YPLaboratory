//
//  HVUIFlowLayoutConstraint.m
//  hvui
//
//  Created by moon on 15/4/14.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUIFlowLayoutConstraint.h"

@implementation HVUIFlowLayoutConstraint

- (CGSize)sizeThatFits:(CGSize)size resizeItems:(BOOL)resizeItems{
	CGSize sizeFits = CGSizeZero;
	NSArray *items = self.visiableItems;
	NSInteger count = items.count;
	if(count==0) return CGSizeZero;
	UIEdgeInsets contentInsets = self.contentInsets;
	CGFloat interitemSpacing = self.interitemSpacing;
	CGSize limitSize = CGSizeMake(size.width-contentInsets.left-contentInsets.right, size.height-contentInsets.top-contentInsets.bottom);//限制在 size -contentInsets 矩形内
	if(self.layoutDirection==HVUILayoutConstraintDirectionHorizontal){//水平方向布局,A B C
		CGFloat maxHeight = 0;//元素的最大高度
		NSMutableArray<NSNumber *> *widths = [[NSMutableArray alloc] initWithCapacity:items.count];
		for (id<HVUILayoutConstraintItemProtocol> item in items) {
			CGSize itemSize = CGSizeZero;
			if(resizeItems){
				if([item respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
					itemSize = [item sizeThatFits:limitSize resizeItems:resizeItems];
				}else if([item respondsToSelector:@selector(sizeThatFits:)]){
					itemSize = [item sizeThatFits:limitSize];
				}else{
					itemSize = [item sizeOfLayout];
				}
			}else{
				itemSize = [item sizeOfLayout];
			}
			if(itemSize.width>0){
				[widths addObject:@(itemSize.width)];
				maxHeight = MAX(maxHeight,itemSize.height);
				limitSize.width -= (itemSize.width+interitemSpacing);
				limitSize.width = MAX(0,limitSize.width);
			}
		}
		if(widths.count>0){
			CGFloat sumWidth = (widths.count-1)*interitemSpacing;//元素的总长度
			for (NSNumber *w in widths) {
				sumWidth += [w floatValue];
			}
			sizeFits.width = sumWidth+contentInsets.left+contentInsets.right;
			sizeFits.height = maxHeight+contentInsets.top+contentInsets.bottom;
			sizeFits.height = MIN(size.height,sizeFits.height);//不能超过 size
		}
	}else{//垂直方向布局
		/**
		 A
		 B
		 C
		 */
		CGFloat maxWidth = 0;//元素的最大宽度
		NSMutableArray<NSNumber *> *heights = [[NSMutableArray alloc] initWithCapacity:items.count];
		for (id<HVUILayoutConstraintItemProtocol> item in items) {
			CGSize itemSize = CGSizeZero;
			if(resizeItems){
				if([item respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
					itemSize = [item sizeThatFits:limitSize resizeItems:resizeItems];
				}else if([item respondsToSelector:@selector(sizeThatFits:)]){
					itemSize = [item sizeThatFits:limitSize];
				}else{
					itemSize = [item sizeOfLayout];
				}
			}else{
				itemSize = [item sizeOfLayout];
			}
			if(itemSize.height>0){
				[heights addObject:@(itemSize.height)];
				maxWidth = MAX(maxWidth,itemSize.width);
				limitSize.height -= (itemSize.height+interitemSpacing);
				limitSize.height = MAX(0,limitSize.height);
			}
		}
		if(heights.count>0){
			CGFloat sumHeight = (heights.count-1)*interitemSpacing;//元素的总高度
			for (NSNumber *h in heights) {
				sumHeight += [h floatValue];
			}
			sizeFits.height = sumHeight+contentInsets.top+contentInsets.bottom;
			sizeFits.width = maxWidth+contentInsets.left+contentInsets.right;
			sizeFits.width = MIN(size.width,sizeFits.width);//不能超过 size
		}
	}
	return sizeFits;
}
- (CGSize)sizeThatFits:(CGSize)size{
	CGSize sizeFits = [self sizeThatFits:size resizeItems:NO];
	return sizeFits;
}
- (BOOL)isEmptyBounds:(CGRect)bounds withResizeItems:(BOOL)resizeItems{
	BOOL is = NO;
	NSArray *items = self.visiableItems;
	if(items.count){
		CGRect b = UIEdgeInsetsInsetRect(bounds, self.contentInsets);
		
		CGFloat interitemSpacing = self.interitemSpacing;
		CGSize limitSize = b.size;
		
		is = YES;
		for (id<HVUILayoutConstraintItemProtocol> item in items){
			CGRect f1 = b;
//            CGSize f1_size = f1.size;
			if(resizeItems){
				if([item respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
					f1.size = [item sizeThatFits:limitSize resizeItems:resizeItems];
				}else if([item respondsToSelector:@selector(sizeThatFits:)]){
					f1.size = [item sizeThatFits:limitSize];
				}else{
					f1.size = [item sizeOfLayout];
				}
			}else{
				if([item respondsToSelector:@selector(sizeThatFits:)]){
					f1.size = [item sizeThatFits:limitSize];
				}else if([item respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
					f1.size = [item sizeThatFits:limitSize resizeItems:resizeItems];
				}else{
					f1.size = [item sizeOfLayout];
				}
			}
			if(!CGSizeEqualToSize(f1.size, CGSizeZero)){
				is = NO;
				break;
			}
			f1.size.width = MIN(f1.size.width,f1.size.width);
			f1.size.height = MIN(f1.size.height,f1.size.height);
			switch (self.layoutDirection) {
				case HVUILayoutConstraintDirectionHorizontal://水平布局
					f1.size.width = MIN(limitSize.width,f1.size.width);
					limitSize.width -= (f1.size.width+interitemSpacing);
					limitSize.width = MAX(0,limitSize.width);
					break;
				case HVUILayoutConstraintDirectionVertical://垂直布局
					f1.size.height = MIN(limitSize.height,f1.size.height);
					limitSize.height -= (f1.size.height+interitemSpacing);
					limitSize.height = MAX(0,limitSize.height);
					break;
				default:
					break;
			}
		}
	}else{
		is = YES;
	}	return is;
}
- (void)layoutItemsWithResizeItems:(BOOL)resizeItems{
	if(resizeItems){
		CGRect bounds = self.bounds;
		CGRect b = UIEdgeInsetsInsetRect(bounds, self.contentInsets);
		NSArray *items = self.visiableItems;
		CGFloat interitemSpacing = self.interitemSpacing;
		CGSize limitSize = b.size;
		for (id<HVUILayoutConstraintItemProtocol> item in items){
			CGRect f1 = b;
//            CGSize f1_size = f1.size;
			if([item respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
				f1.size = [item sizeThatFits:limitSize resizeItems:resizeItems];
			}else if([item respondsToSelector:@selector(sizeThatFits:)]){
				f1.size = [item sizeThatFits:limitSize];
			}else{
				f1.size = [item sizeOfLayout];
			}
			if(self.unLimitItemSizeInBounds){
				f1.size = f1.size;
			}else{
				f1.size.width = MIN(f1.size.width,f1.size.width);
				f1.size.height = MIN(f1.size.height,f1.size.height);
			}
			switch (self.layoutDirection) {
				case HVUILayoutConstraintDirectionHorizontal://水平布局
					f1.size.width = MIN(limitSize.width,f1.size.width);
					break;
				case HVUILayoutConstraintDirectionVertical://垂直布局
					f1.size.height = MIN(limitSize.height,f1.size.height);
					break;
				default:
					break;
			}
			if([item isKindOfClass:[HVUILayoutConstraint class]]){//减少一次 layoutItems
				[(HVUILayoutConstraint *)item setBounds:f1];
			}else{
				[item setLayoutFrame:f1];
			}
			if([item respondsToSelector:@selector(layoutItemsWithResizeItems:)]){
				[item layoutItemsWithResizeItems:resizeItems];
			}
			switch (self.layoutDirection) {
				case HVUILayoutConstraintDirectionHorizontal://水平布局
					if(f1.size.width>0){
						limitSize.width -= (f1.size.width+interitemSpacing);
						limitSize.width = MAX(0,limitSize.width);
					}
					break;
				case HVUILayoutConstraintDirectionVertical://垂直布局
					if(f1.size.height>0){
						limitSize.height -= (f1.size.height+interitemSpacing);
						limitSize.height = MAX(0,limitSize.height);
					}
					break;
				default:
					break;
			}
		}
		[self layoutItems];
	}else{
		[self layoutItems];
	}
}
- (void)layoutItems{
	NSArray *items = self.visiableItems;
	NSInteger count = items.count;
	if(count==0)return;
	UIEdgeInsets contentInsets = self.contentInsets;
	CGRect bounds = UIEdgeInsetsInsetRect(self.bounds, contentInsets);
	CGFloat interitemSpacing = self.interitemSpacing;
	CGRect f = bounds;
	NSMutableArray<NSNumber *> *itemValueList = [[NSMutableArray alloc] initWithCapacity:items.count];//存储长/宽的数组
	if(self.layoutDirection==HVUILayoutConstraintDirectionHorizontal){//水平方向布局:A B C ...
		switch (self.layoutHorizontalAlignment) {
			case HVUILayoutConstraintHorizontalAlignmentCenter://水平居中
			{
				for (id<HVUILayoutConstraintItemProtocol> item in items) {
					CGSize s = [item sizeOfLayout];
					if(s.width>0){
						[itemValueList addObject:@(s.width)];
					}
				}
				if(itemValueList.count>0){
					CGFloat sumWidth = (itemValueList.count-1)*interitemSpacing;//元素的总长度
					for (NSNumber *n in itemValueList) {
						sumWidth += [n floatValue];
					}
					f.origin.x += (bounds.size.width-sumWidth)/2;
					for (id<HVUILayoutConstraintItemProtocol> item in items) {
						f.size = [item sizeOfLayout];
						switch (self.layoutVerticalAlignment) {
							case HVUILayoutConstraintVerticalAlignmentTop://垂直靠顶
								f.origin.y = bounds.origin.y;
								break;
							case HVUILayoutConstraintVerticalAlignmentCenter://垂直居中
								f.origin.y = bounds.origin.y+(bounds.size.height-f.size.height)/2;
								break;
							case HVUILayoutConstraintVerticalAlignmentBottom://垂直靠底
								f.origin.y = bounds.origin.y+(bounds.size.height-f.size.height);
								break;
						}
						[item setLayoutFrame:f];
						if(f.size.width>0){
							f.origin.x += (f.size.width+interitemSpacing);
						}
					}
				}
			}
				break;
			case HVUILayoutConstraintHorizontalAlignmentLeft://水平靠左
				for (id<HVUILayoutConstraintItemProtocol> item in items) {
					f.size = [item sizeOfLayout];
					switch (self.layoutVerticalAlignment) {
						case HVUILayoutConstraintVerticalAlignmentTop://垂直靠顶
							f.origin.y = bounds.origin.y;
							break;
						case HVUILayoutConstraintVerticalAlignmentCenter://垂直居中
							f.origin.y = bounds.origin.y+(bounds.size.height-f.size.height)/2;
							break;
						case HVUILayoutConstraintVerticalAlignmentBottom://垂直靠底
							f.origin.y = bounds.origin.y+(bounds.size.height-f.size.height);
							break;
					}
					[item setLayoutFrame:f];
					if(f.size.width>0){
						f.origin.x += (f.size.width+interitemSpacing);
					}
				}
				break;
			case HVUILayoutConstraintHorizontalAlignmentRight://水平靠右
				f.origin.x = CGRectGetMaxX(bounds);
				for (NSInteger i=count-1; i>=0; i--) {
					id<HVUILayoutConstraintItemProtocol> item = [items objectAtIndex:i];
					f.size = [item sizeOfLayout];
					switch (self.layoutVerticalAlignment) {
						case HVUILayoutConstraintVerticalAlignmentTop://垂直靠顶
							f.origin.y = bounds.origin.y;
							break;
						case HVUILayoutConstraintVerticalAlignmentCenter://垂直居中
							f.origin.y = bounds.origin.y+(bounds.size.height-f.size.height)/2;
							break;
						case HVUILayoutConstraintVerticalAlignmentBottom://垂直靠底
							f.origin.y = bounds.origin.y+(bounds.size.height-f.size.height);
							break;
					}
					f.origin.x -= f.size.width;
					[item setLayoutFrame:f];
					if(f.size.width>0){
						f.origin.x -= (interitemSpacing);
					}
				}
				break;
			default:
				break;
		}
	}else{//垂直方向布局
		switch (self.layoutVerticalAlignment) {
			case HVUILayoutConstraintVerticalAlignmentCenter://垂直居中
			{
				for (id<HVUILayoutConstraintItemProtocol> item in items) {
					CGSize s = [item sizeOfLayout];
					if(s.height>0){
						[itemValueList addObject:@(s.height)];
					}
				}
				if(itemValueList.count>0){
					CGFloat sumHeight = (itemValueList.count-1)*interitemSpacing;//元素的总高度
					for (NSNumber *n in itemValueList) {
						sumHeight += [n floatValue];
					}
					f.origin.y += (bounds.size.height-sumHeight)/2;
					for (id<HVUILayoutConstraintItemProtocol> item in items) {
						f.size = [item sizeOfLayout];
						switch (self.layoutHorizontalAlignment) {
							case HVUILayoutConstraintHorizontalAlignmentLeft://水平居左
								f.origin.x = bounds.origin.x;
								break;
							case HVUILayoutConstraintHorizontalAlignmentCenter://水平居中
								f.origin.x = bounds.origin.x+(bounds.size.width-f.size.width)/2;
								break;
							case HVUILayoutConstraintHorizontalAlignmentRight://水平居右
								f.origin.x = bounds.origin.x+(bounds.size.width-f.size.width);
								break;
						}
						[item setLayoutFrame:f];
						if(f.size.height>0){
							f.origin.y += (f.size.height+interitemSpacing);
						}
					}
				}
			}
				break;
			case HVUILayoutConstraintVerticalAlignmentTop://垂直靠顶
				for (id<HVUILayoutConstraintItemProtocol> item in items) {
					f.size = [item sizeOfLayout];
					switch (self.layoutHorizontalAlignment) {
						case HVUILayoutConstraintHorizontalAlignmentLeft://水平居左
							f.origin.x = bounds.origin.x;
							break;
						case HVUILayoutConstraintHorizontalAlignmentCenter://水平居中
							f.origin.x = bounds.origin.x+(bounds.size.width-f.size.width)/2;
							break;
						case HVUILayoutConstraintHorizontalAlignmentRight://水平居右
							f.origin.x = bounds.origin.x+(bounds.size.width-f.size.width);
							break;
					}
					[item setLayoutFrame:f];
					if(f.size.height>0){
						f.origin.y += (f.size.height+interitemSpacing);
					}
				}
				break;
			case HVUILayoutConstraintVerticalAlignmentBottom://垂直靠底
				f.origin.y = CGRectGetMaxY(bounds);
				for (NSInteger i=count-1; i>=0; i--) {
					id<HVUILayoutConstraintItemProtocol> item = [items objectAtIndex:i];
					f.size = [item sizeOfLayout];
					switch (self.layoutHorizontalAlignment) {
						case HVUILayoutConstraintHorizontalAlignmentLeft://水平居左
							f.origin.x = bounds.origin.x;
							break;
						case HVUILayoutConstraintHorizontalAlignmentCenter://水平居中
							f.origin.x = bounds.origin.x+(bounds.size.width-f.size.width)/2;
							break;
						case HVUILayoutConstraintHorizontalAlignmentRight://水平居右
							f.origin.x = bounds.origin.x+(bounds.size.width-f.size.width);
							break;
					}
					f.origin.y -= f.size.height;
					[item setLayoutFrame:f];
					if(f.size.height>0){
						f.origin.y -= (interitemSpacing);
					}
				}
				break;
		}
	}
}
@end

@implementation HVUIFlowLayoutConstraint(InitMethod)
- (id)initWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items constraintParam:(HVUIFlowLayoutConstraintParam)param contentInsets:(UIEdgeInsets)contentInsets interitemSpacing:(CGFloat)interitemSpacing{
	if(self=[self init]){
		self.items = items;
		self.contentInsets = contentInsets;
		self.interitemSpacing = interitemSpacing;
		[self configWithConstraintParam:param];
	}
	return self;
}
- (void)configWithConstraintParam:(HVUIFlowLayoutConstraintParam)param{
	switch (param) {
		case HVUIFlowLayoutConstraintParam_H_C_C:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
			break;
		case HVUIFlowLayoutConstraintParam_H_C_L:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
			break;
		case HVUIFlowLayoutConstraintParam_H_C_R:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
			break;
		case HVUIFlowLayoutConstraintParam_H_T_C:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
			break;
		case HVUIFlowLayoutConstraintParam_H_T_L:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
			break;
		case HVUIFlowLayoutConstraintParam_H_T_R:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
			break;
		case HVUIFlowLayoutConstraintParam_H_B_L:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
			break;
		case HVUIFlowLayoutConstraintParam_H_B_C:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
			break;
		case HVUIFlowLayoutConstraintParam_H_B_R:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
			break;
		case HVUIFlowLayoutConstraintParam_V_C_C:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
			break;
		case HVUIFlowLayoutConstraintParam_V_C_L:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
			break;
		case HVUIFlowLayoutConstraintParam_V_C_R:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
			break;
		case HVUIFlowLayoutConstraintParam_V_T_C:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
			break;
		case HVUIFlowLayoutConstraintParam_V_T_L:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
			break;
		case HVUIFlowLayoutConstraintParam_V_T_R:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
			break;
		case HVUIFlowLayoutConstraintParam_V_B_C:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
			break;
		case HVUIFlowLayoutConstraintParam_V_B_L:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
			break;
		case HVUIFlowLayoutConstraintParam_V_B_R:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
			break;
	}
}
@end
