//
//  UILabel+KExtension.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "UILabel+KExtension.h"

@implementation UILabel (KExtension)

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
