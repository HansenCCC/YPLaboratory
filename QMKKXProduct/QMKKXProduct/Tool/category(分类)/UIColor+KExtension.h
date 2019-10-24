
//
//  UIColor+LW.h
//  KExtension
//
//  Created by 程恒盛 on 16/12/19.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (KExtension)
/**
 常见color

 @return @[@"colorName":color];
 */
+(NSDictionary <NSString *,UIColor *> *)commonColors;

/**
 将图片转化成颜色
 
 @param image 需要转化成颜色的图片
 
 @return 返回color
 */
+ (UIColor *)colorWithImage:(UIImage *) image;

/**
 通过hexsting获取颜色

 @param hexString #RGB #ARGB #RRGGBB #AARRGGBB

 @return 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *) hexString;

/**
 随机颜色
 
 @return 随机颜色
 */
+ (UIColor *)colorWithRandomColor;

/**
 通过color获取颜色hexstring

 @param color 颜色对象
 @return hex
 */
+ (NSString *)hexStringFromColor:(UIColor *)color;
@end
