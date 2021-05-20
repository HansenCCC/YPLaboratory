//
//  UIView+KKXib.m
//  Bee
//
//  Created by 程恒盛 on 2019/10/25.
//  Copyright © 2019 南京. All rights reserved.
//

#import "UIView+KKXib.h"

@implementation UIView (KKXib)
- (CGFloat)cornerRadious {
    return self.layer.cornerRadius;
}
- (void)setCornerRadious:(CGFloat)cornerRadious {
    self.layer.cornerRadius = cornerRadious;
}
- (BOOL)masksToBounds {
    return self.layer.masksToBounds;
}
- (void)setMasksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
}
- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}
@end
