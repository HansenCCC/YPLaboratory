//
//  UIColor+LW.m
//  KExtension
//
//  Created by 程恒盛 on 16/12/19.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "UIColor+KExtension.h"

@implementation UIColor (KExtension)
+(NSDictionary <NSString *,UIColor *> *)commonColors{
    static NSDictionary *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors =
        @{
          @"clearColor":[UIColor clearColor],
          @"blackColor":[UIColor blackColor],
          @"darkGrayColor":[UIColor darkGrayColor],
          @"lightGrayColor":[UIColor lightGrayColor],
          @"whiteColor":[UIColor whiteColor],
          @"grayColor":[UIColor grayColor],
          @"redColor":[UIColor redColor],
          @"greenColor":[UIColor greenColor],
          @"blueColor":[UIColor blueColor],
          @"cyanColor":[UIColor cyanColor],
          @"yellowColor":[UIColor yellowColor],
          @"magentaColor":[UIColor magentaColor],
          @"orangeColor":[UIColor orangeColor],
          @"purpleColor":[UIColor purpleColor],
          @"brownColor":[UIColor brownColor],
          @"purpleColor":[UIColor purpleColor]
          };
    });
    return colors;
}

+ (UIColor *)colorWithImage:(UIImage *) image{
    UIColor *color = [UIColor colorWithPatternImage:image];
    return color;
}
+ (UIColor *) colorWithHexString:(NSString *)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#"withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = 16 - [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            return [UIColor clearColor];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}
+ (UIColor *)colorWithRandomColor{
    UIColor *color = [UIColor colorWithRed:rand()%255/255.0 green:rand()%255/255.0 blue:rand()%255/255.0 alpha:1];
    return color;
}
+ (NSString *)hexStringFromColor:(UIColor *)color {
    //http://blog.sina.com.cn/s/blog_a5b73bad0102x01x.html
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    NSString *r,*g,*b;
    (int)((CGColorGetComponents(color.CGColor))[0]*255.0) == 0?(r = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]):(r = [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]);
    (int)((CGColorGetComponents(color.CGColor))[1]*255.0) == 0?(g = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]):(g = [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]);
    (int)((CGColorGetComponents(color.CGColor))[2]*255.0) == 0?(b = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]):(b = [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]);
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
}
@end
