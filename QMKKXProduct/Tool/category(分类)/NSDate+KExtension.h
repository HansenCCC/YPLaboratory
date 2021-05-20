//
//  NSDate+KExtension.h
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/20.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (KExtension)
@property (readonly, nonatomic) NSDateComponents *dateComponents;

/**
 *  当前日前往前一天的时间
 *
 *  @return 日期
 */
- (NSDate *)yesterday;

/**
 *  当前日前往后一天的时间
 *
 *  @return 日期
 */
- (NSDate *)tomorrow;

/**
 *  当前时刻与指定的时刻是否在同一天
 *
 *  @param date 另一时刻
 *
 *  @return 是否在同一天内
 */
- (BOOL)isSameDayWithDate:(NSDate *)date;

/**
 *  返回日期字符串
 *
 *  @param dateFormat 日期的显示格式，如YYYY-MM-dd HH:mm:ss
 *
 *  @return 字符串
 */
- (NSString *)stringWithDateFormat:(NSString *)dateFormat;

/**
 *  从字符串中实例出日期
 *
 *  @param dateString 字符串，如1999-9-10
 *  @param dateFormat 日期字符串的格式
 *
 *  @return 日期对象
 */
+ (NSDate *)dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat;


/// 失物招领时间格式  时间转化->刚刚，一分钟前，一个小时前，一天前
/// @param compareDate 时间
+ (NSString *)kk_transformCurrentTime:(NSDate *)compareDate;

@end
