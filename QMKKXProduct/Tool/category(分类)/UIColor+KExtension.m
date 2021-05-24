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
+ (UIColor *)colorWithMorandiRandomColor{
    static NSArray *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = @[
            [UIColor colorWithHexString:@"c1cbd7"],
            [UIColor colorWithHexString:@"afb0b2"],
            [UIColor colorWithHexString:@"939391"],
            [UIColor colorWithHexString:@"bfbfbf"],
            [UIColor colorWithHexString:@"e0e5df"],
            [UIColor colorWithHexString:@"b5c4b1"],
            [UIColor colorWithHexString:@"8696a7"],
            [UIColor colorWithHexString:@"9ca8b8"],
            [UIColor colorWithHexString:@"ececea"],
            [UIColor colorWithHexString:@"fffaf4"],
            [UIColor colorWithHexString:@"96a48b"],
            [UIColor colorWithHexString:@"7b8b6f"],
            [UIColor colorWithHexString:@"dfd7d7"],
            [UIColor colorWithHexString:@"656565"],
            [UIColor colorWithHexString:@"d8caaf"],
            [UIColor colorWithHexString:@"c5b8a5"],
            [UIColor colorWithHexString:@"fdf9ee"],
            [UIColor colorWithHexString:@"f0ebe5"],
            [UIColor colorWithHexString:@"d3d4cc"],
            [UIColor colorWithHexString:@"e0cdcf"],
            [UIColor colorWithHexString:@"b7b1a5"],
            [UIColor colorWithHexString:@"a29988"],
            [UIColor colorWithHexString:@"dadad8"],
            [UIColor colorWithHexString:@"f8ebd8"],
            [UIColor colorWithHexString:@"965454"],
            [UIColor colorWithHexString:@"6b5152"],
            [UIColor colorWithHexString:@"f0ebe5"],
            [UIColor colorWithHexString:@"cac3bb"],
            [UIColor colorWithHexString:@"a6a6a8"],
            [UIColor colorWithHexString:@"7a7281"],
            [UIColor colorWithHexString:@"a27e7e"],
            [UIColor colorWithHexString:@"ead0d1"],
            [UIColor colorWithHexString:@"faead3"],
            [UIColor colorWithHexString:@"c7b8a1"],
            [UIColor colorWithHexString:@"c9c0d3"],
            [UIColor colorWithHexString:@"eee5f8"],
        ];
    });
    NSInteger rand = random()%colors.count;
    return colors[rand];
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
