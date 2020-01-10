//
//  NSMutableAttributedString+KExtension.m
//  QMKKXProduct
//
//  Created by Hansen on 1/10/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "NSMutableAttributedString+KExtension.h"
//缓存参数
NSAttributedStringKey const NSAttributedInfoAttributeName = @"NSAttributedInfoAttributeName";
@implementation NSMutableAttributedString (KExtension)
/// 获取储存参数
- (NSString *)attributedInfo{
    NSRange range = NSMakeRange(0, self.length);
    if (range.length == 0) {
        return nil;
    }
    NSDictionary *dictionary = [self attributesAtIndex:0 longestEffectiveRange:&range inRange:range];
    NSString *attributedInfo = [dictionary objectForKey:NSAttributedInfoAttributeName];
    return attributedInfo;
}

/// 储存参数
/// @param attributedInfo 参数
- (void)setAttributedInfo:(NSString *)attributedInfo{
    NSRange range = NSMakeRange(0, self.length);
    [self addAttribute:NSAttributedInfoAttributeName value:attributedInfo range:range];
}
@end
