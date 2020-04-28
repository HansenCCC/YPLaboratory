//
//  KKBadgeView.m
//  QMKKXProduct
//
//  Created by Hansen on 4/8/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKBadgeView.h"

@implementation KKBadgeView
- (instancetype)init{
    if (self = [super init]) {
        self.textColor = [UIColor whiteColor];
        self.font = AdaptedFontSize(12);
        self.backgroundColor = [UIColor redColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)setText:(NSString *)text{
    [super setText:text];
    if (text.length == 0) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
}
- (void)setBadgeString:(NSString *)badgeString{
    self.text = badgeString;
}
- (NSString *)badgeString{
    return self.text;
}
- (void)setBadgeInteger:(NSInteger)badgeInteger{
    if (badgeInteger == 0) {
        self.text = nil;
    }else{
        self.text = @(badgeInteger).stringValue;
    }
}
- (NSInteger)badgeInteger{
    return self.text.integerValue;
}
- (CGSize)sizeThatFits:(CGSize)size{
    size = [super sizeThatFits:size];
    size.height += 5.f;
    size.width += 10.f;
    if (size.width < size.height) {
        size.width = size.height;
    }
    return size;
}
- (void)setIsBadge:(BOOL)isBadge{
    _isBadge = isBadge;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect superviewBounds = self.superview.bounds;
    if (CGRectIsEmpty(superviewBounds)) {
        return;
    }
    CGSize size = [self sizeThatFits:CGSizeZero];
    CGRect f1 = superviewBounds;
    f1.size = size;
    if (!self.isBadge) {
        f1.size = CGSizeMake(AdaptedWidth(5.f), AdaptedWidth(5.f));
    }
    if (self.superview.clipsToBounds) {
        //不允许超出范围
        f1.origin.x = superviewBounds.size.width - f1.size.width;
        f1.origin.y = 0;
    }else{
        //允许超出范围
        f1.origin.x = superviewBounds.size.width - f1.size.width/2.0;
        f1.origin.y = -f1.size.height/2.0;
    }
    self.frame = f1;
    CGRect bounds = self.bounds;
    self.layer.cornerRadius = bounds.size.height/2.0f;
}
@end

@implementation KKBadgeView (KExtension)
+ (KKBadgeView *)showBadgeToView:(UIView *)view badgeInteger:(NSInteger )badgeInteger{
    KKBadgeView *badgeView = nil;
    badgeView = (KKBadgeView *)[view traversalAllForClass:[KKBadgeView class]].firstObject;
    if (!badgeView) {
        badgeView = [[KKBadgeView alloc] init];
        [view addSubview:badgeView];
    }
    badgeView.isBadge = YES;
    badgeView.badgeInteger = badgeInteger;
    [badgeView setNeedsLayout];
    [badgeView layoutIfNeeded];
    return badgeView;
}
/// 展示红点在试图右上角上面
/// @param view 要展示的试图
+ (KKBadgeView *)showBadgeToView:(UIView *)view{
    KKBadgeView *badgeView = nil;
    badgeView = (KKBadgeView *)[view traversalAllForClass:[KKBadgeView class]].firstObject;
    if (!badgeView) {
        badgeView = [[KKBadgeView alloc] init];
        [view addSubview:badgeView];
    }
    badgeView.isBadge = NO;
    [badgeView setNeedsLayout];
    [badgeView layoutIfNeeded];
    return badgeView;
}
+ (KKBadgeView *)hiddenBadgeToView:(UIView *)view{
    KKBadgeView *badgeView = nil;
    badgeView = (KKBadgeView *)[view traversalAllForClass:[KKBadgeView class]].firstObject;
    if (badgeView) {
        [badgeView removeFromSuperview];
    }
    return badgeView;
}
@end
