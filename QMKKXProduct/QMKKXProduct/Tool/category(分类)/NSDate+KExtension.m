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
@end
