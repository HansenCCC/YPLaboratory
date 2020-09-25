//
//  UILabel+KExtension.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "UILabel+KExtension.h"
#import <objc/runtime.h>

@implementation UILabel (KExtension)

- (CGFloat)kk_lineSpacing{
    NSNumber *number = objc_getAssociatedObject(self, @selector(kk_lineSpacing));
    return number.floatValue;
}
- (void)setKk_lineSpacing:(CGFloat)lineSpacing{
    if (self.text.length == 0) {
        return;
    }
    //设置值
    objc_setAssociatedObject(self, @selector(lineSpacing),@(lineSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //to do
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self.attributedText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = self.textAlignment;
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    self.attributedText = attributedStr;
}

//UILabel+KExtension
+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel *label = [[UILabel alloc] init];
    if (font) {
        label.font = font;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    return label;
}



@end
