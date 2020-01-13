//
//  KKAiteTextField+KExtension.m
//  QMKKXProduct
//
//  Created by Hansen on 1/10/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKAiteTextField+KExtension.h"

@implementation KKAiteTextField (KExtension)

/// 字符转化为Attributed格式
/// @param string string
/// @param highlightColor 高亮颜色
/// @人，昵称高亮 特殊字符转化 例如：程恒盛盛世美颜<remind id="10013",nickname="张三"/>真的 -> 程恒盛盛世美颜张三真的（张三高亮）
+ (NSMutableAttributedString *)transformAttributedByString:(NSString *)string highlightColor:(UIColor *)highlightColor normalColor:(UIColor *)normalColor{
    NSString *headString = @"<remind data=";
    NSString *footString = @"/>";
    NSMutableAttributedString *transformString = [[NSMutableAttributedString alloc] init];
    while (string.length > 0) {
        NSRange range = [string rangeOfString:headString];
        if (range.location == NSNotFound) {
            NSString *value = [string copy];
            string = @"";
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value];
            [transformString appendAttributedString:attributedString];
            continue;
        }
        NSString *value = [string substringToIndex:range.location];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:value];
        [attributedString addAttribute:NSForegroundColorAttributeName value:normalColor range:NSMakeRange(0, attributedString.length)];
        [transformString appendAttributedString:attributedString];
        string = [string substringFromIndex:range.location];
        NSRange rangeHighlight = [string rangeOfString:footString];
        NSString *highlightValue = [string substringToIndex:rangeHighlight.location + rangeHighlight.length];
        NSString *attributedInfo = [highlightValue copy];
        highlightValue = [highlightValue substringFromIndex:headString.length];
        highlightValue = [highlightValue stringByReplacingOccurrencesOfString:footString withString:@""];
        KKAiteModel *aiteModel = [KKAiteModel mj_objectWithKeyValues:highlightValue];
        highlightValue = [NSString stringWithFormat:@"@%@",aiteModel.nickname];
        if (highlightValue) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:highlightValue];
            [attributedString addAttribute:NSForegroundColorAttributeName value:highlightColor range:NSMakeRange(0, attributedString.length)];
            attributedString.attributedInfo = attributedInfo;
            [transformString appendAttributedString:attributedString];
        }
        string = [string substringFromIndex:rangeHighlight.location + rangeHighlight.length];
    }
    return transformString;
}

/// Attributed为格式string
/// @param attributedText attributedString
+ (NSString *)transformStringByAttributed:(NSAttributedString *)attributedText{
    NSMutableString *value = [[NSMutableString alloc] initWithString:@""];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    NSMutableArray *attributedInfos = [[NSMutableArray alloc] init];
    NSMutableArray *deleteAttributedInfos = [[NSMutableArray alloc] init];
    [attributeString enumerateAttribute:NSAttributedInfoAttributeName inRange:NSMakeRange(0, attributeString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:[attributeString attributedSubstringFromRange:range]];
        NSLog(@"%@",attributed);
    }];
    __block NSString *lastValue;
    [attributeString enumerateAttributesInRange:NSMakeRange(0, attributeString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:[attributeString attributedSubstringFromRange:range]];
        if (attributed.attributedInfo&&attributed.attributedInfo.length > 0) {
            if ([attributed.attributedInfo isEqualToString:lastValue]) {
                //放置循环添加
            }else{
                if (![attributedInfos containsObject:attributed.attributedInfo]) {
                    [attributedInfos addObject:attributed.attributedInfo];
                }else{
                    [deleteAttributedInfos addObject:attributed.attributedInfo];
                }
            }
        }
        lastValue = attributed.attributedInfo;
    }];
    __block NSString *lastValue2;
    [attributeString enumerateAttributesInRange:NSMakeRange(0, attributeString.length) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:[attributeString attributedSubstringFromRange:range]];
        if (attributed.attributedInfo&&![deleteAttributedInfos containsObject:attributed.attributedInfo]&&attributed.attributedInfo.length > 0) {
            if ([attributed.attributedInfo isEqualToString:lastValue2]) {
                //放置循环添加
            }else{
                [value appendString:attributed.attributedInfo];
            }
        }else{
            [value appendString:attributed.string];
        }
        lastValue2 = attributed.attributedInfo;
    }];
    return [value copy];
}

/// Attributed获取艾特人列表
/// @param attributedText attributedString
+ (NSArray <KKAiteModel *>*)transformAitesByAttributed:(NSAttributedString *)attributedText{
    NSString *headString = @"<remind data=";
    NSString *footString = @"/>";
    NSMutableArray *aites = [[NSMutableArray alloc] init];
    NSString *string = [self transformStringByAttributed:attributedText];
    while (string.length > 0) {
        NSRange range = [string rangeOfString:headString];
        if (range.location == NSNotFound) {
            string = @"";
            continue;
        }
        string = [string substringFromIndex:range.location];
        NSRange rangeHighlight = [string rangeOfString:footString];
        NSString *highlightValue = [string substringToIndex:rangeHighlight.location + rangeHighlight.length];
        highlightValue = [highlightValue substringFromIndex:headString.length];
        highlightValue = [highlightValue stringByReplacingOccurrencesOfString:footString withString:@""];
        KKAiteModel *aiteModel = [KKAiteModel mj_objectWithKeyValues:highlightValue];
        [aites addObject:aiteModel];
        string = [string substringFromIndex:rangeHighlight.location + rangeHighlight.length];
    }
    return [aites copy];
}

@end
