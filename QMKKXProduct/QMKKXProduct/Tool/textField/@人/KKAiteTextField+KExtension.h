//
//  KKAiteTextField+KExtension.h
//  QMKKXProduct
//
//  Created by Hansen on 1/10/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKAiteTextField.h"

@interface KKAiteTextField (KExtension)

/// 字符转化为Attributed格式
/// @param string string
/// @param highlightColor 高亮颜色
/// @param normalColor        正常颜色
/// @人，昵称高亮 特殊字符转化 例如：程恒盛盛世美颜<remind id="10013",nickname="张三"/>真的 -> 程恒盛盛世美颜张三真的（张三高亮）
+ (NSMutableAttributedString *)transformAttributedByString:(NSString *)string highlightColor:(UIColor *)highlightColor normalColor:(UIColor *)normalColor;

/// Attributed为格式string
/// @param attributedText attributedString
+ (NSString *)transformStringByAttributed:(NSAttributedString *)attributedText;

/// Attributed获取艾特人列表
/// @param attributedText attributedString
+ (NSArray <KKAiteModel *>*)transformAitesByAttributed:(NSAttributedString *)attributedText;
@end

