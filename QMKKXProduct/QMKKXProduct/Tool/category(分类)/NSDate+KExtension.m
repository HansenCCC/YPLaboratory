//
//  NSDate+KExtension.m
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/20.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "NSDate+KExtension.h"
#import <UIKit/UIKit.h>

@implementation NSDate (KExtension)
- (NSDateComponents *)dateComponents{
    NSDate *currentDate = [self copy];
    NSCalendar *calendar = [NSCalendar currentCalendar];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//    NSCalendarUnitEra                = kCFCalendarUnitEra,
//    NSCalendarUnitYear               = kCFCalendarUnitYear,
//    NSCalendarUnitMonth              = kCFCalendarUnitMonth,
//    NSCalendarUnitDay                = kCFCalendarUnitDay,
//    NSCalendarUnitHour               = kCFCalendarUnitHour,
//    NSCalendarUnitMinute             = kCFCalendarUnitMinute,
//    NSCalendarUnitSecond             = kCFCalendarUnitSecond,
//    NSCalendarUnitWeekday            = kCFCalendarUnitWeekday,
//    NSCalendarUnitWeekdayOrdinal     = kCFCalendarUnitWeekdayOrdinal,
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
#pragma clang diagnostic pop
    return components;
}
- (NSDate *)yesterday{
    NSTimeInterval time = [self timeIntervalSinceReferenceDate];
    NSTimeInterval oneDayTime = 3600*24;
    time -= oneDayTime;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:time];
    return date;
}
- (NSDate *)tomorrow {
    NSTimeInterval time = [self timeIntervalSinceReferenceDate];
    NSTimeInterval oneDayTime = 3600*24;
    time += oneDayTime;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:time];
    return date;
}
- (NSString *)stringWithDateFormat:(NSString *)dateFormat{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = dateFormat;
    NSString *string = [f stringFromDate:self];
    return string;
}
+ (NSDate *)dateWithString:(NSString *)dateString dateFormat:(NSString *)dateFormat{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = dateFormat;
    NSDate *date = [f dateFromString:dateString];
    return date;
}
- (BOOL)isSameDayWithDate:(NSDate *)date{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0?NSCalendarIdentifierGregorian:NSGregorianCalendar)];
#pragma clang diagnostic pop
    NSDateComponents *comps1 = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    NSDateComponents *comps2 = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    BOOL is = comps1.year==comps2.year&&comps1.month==comps2.month&&comps1.day==comps2.day;
    return is;
}

/// 失物招领时间格式  时间转化->刚刚，一分钟前，一个小时前，一天前
+ (NSString *)kk_transformCurrentTime:(NSDate *)compareDate{
    //当前时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    //创建时间戳
    NSTimeInterval createTime = [compareDate timeIntervalSince1970];
    NSTimeInterval time = currentTime - createTime;
    NSString *result;
    //秒转刚刚
    if (time < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        return result;
    }
    //秒转分钟
    NSInteger minute = time/60;
    if(minute < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",(long)minute];
        return result;
    }
    //秒转小时
    NSInteger hour = time/3600;
    if (time/3600 < 24) {
        result = [NSString stringWithFormat:@"%ld小时前",(long)hour];
        return result;
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 3) {
        result = [NSString stringWithFormat:@"%ld天前",(long)days];
        return result;
    }
    result = [compareDate stringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return result;
}
@end
