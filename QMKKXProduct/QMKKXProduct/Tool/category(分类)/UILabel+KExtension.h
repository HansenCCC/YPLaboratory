//
//  UILabel+KExtension.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (KExtension)

/**
 label快速创建
 
 @param font 字体样式 为空默认样式
 @param textColor 字体颜色 为空默认样式
 @return label
 */
+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor;


@end

