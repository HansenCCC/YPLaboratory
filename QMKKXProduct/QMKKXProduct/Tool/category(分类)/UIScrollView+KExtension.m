//
//  UIScrollView+KExtension.m
//  KExtensionUI
//
//  Created by 程恒盛 on 16/12/3.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "UIScrollView+KExtension.h"

@implementation UIScrollView (KExtension)

- (void)scrollToBottomWithAnimated:(BOOL)animated{
    CGFloat offsetYMax = self.contentOffsetOfMaxY;
    CGFloat offsetYMin = self.contentOffsetOfMinY;
    if(offsetYMax<offsetYMin){
        offsetYMax = offsetYMin;
    }
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = offsetYMax;
    if(animated){
        [self setContentOffset:contentOffset animated:animated];
    }else{
        self.contentOffset = contentOffset;
    }
}
- (void)scrollToTopWithAnimated:(BOOL)animated{
    CGFloat offsetYMin = self.contentOffsetOfMinY;
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = offsetYMin;
    if(animated){
        [self setContentOffset:contentOffset animated:animated];
    }else{
        self.contentOffset = contentOffset;
    }
}
- (UIEdgeInsets)contentOffsetOfRange{
    CGRect bounds = self.bounds;
    CGSize contentSize = self.contentSize;
    UIEdgeInsets contentInset = self.contentInset;
    CGFloat minY = -contentInset.top;
    CGFloat maxY = -(bounds.size.height-contentInset.bottom-contentSize.height);
    CGFloat minX = -contentInset.left;
    CGFloat maxX = -(bounds.size.width-contentInset.right-contentSize.width);
    UIEdgeInsets range = UIEdgeInsetsMake(minY, minX, maxY, maxX);
    //	NSLog(@"bounds:%@,contentSize:%@,contentOffset:%@,contentInset:%@,offsetYMin:%@,offsetYMax:%@",NSStringFromCGRect(bounds),NSStringFromCGSize(contentSize),NSStringFromCGPoint(contentOffset),NSStringFromUIEdgeInsets(contentInset),@(offsetYMin),@(offsetYMax));
    return range;
}
- (CGFloat)contentOffsetOfMinX{
    CGFloat v = self.contentOffsetOfRange.left;
    return v;
}
- (CGFloat)contentOffsetOfMaxX{
    CGFloat v = self.contentOffsetOfRange.right;
    return v;
}
- (CGFloat)contentOffsetOfMinY{
    CGFloat v = self.contentOffsetOfRange.top;
    return v;
}
- (CGFloat)contentOffsetOfMaxY{
    CGFloat v = self.contentOffsetOfRange.bottom;
    return v;
}

-(void)scrollToTrackOfPoint:(UIView *)trackView{
    CGFloat contance = CGRectGetMaxX(trackView.frame);//让cell定位到选中位置
    if ((contance - self.contentOffset.x-self.bounds.size.width)>0) {
        CGFloat contanceX = contance - self.contentOffset.x-self.bounds.size.width+self.contentOffset.x;
        [self setContentOffset:CGPointMake(contanceX, 0) animated:YES];
    }else if((trackView.frame.origin.x - self.contentOffset.x)<0){
        CGFloat contanceX = self.contentOffset.x + trackView.frame.origin.x - self.contentOffset.x;
        [self setContentOffset:CGPointMake(contanceX, 0) animated:YES];
    }
}
@end
