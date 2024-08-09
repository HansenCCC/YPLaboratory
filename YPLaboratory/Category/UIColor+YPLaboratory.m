//
//  NSObject+HAHA.m
//  YPPrompts
//
//  Created by Hansen on 2023/5/9.
//

#import "UIColor+YPLaboratory.h"

@implementation UIColor (YPLaboratory)

+ (UIColor *)yp_themeColor {
    return [UIColor yp_colorWithHexString:@"0000FF"];
}

+ (UIColor *)yp_backgroundColor {
    return [UIColor yp_colorWithHexString:@"FAFAFC"];
}

@end
