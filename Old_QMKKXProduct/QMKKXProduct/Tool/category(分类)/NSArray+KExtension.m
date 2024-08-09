//
//  NSArray+KExtension.m
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/20.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "NSArray+KExtension.h"

@implementation NSArray (KExtension)
- (NSString *)jsonString{
    NSString *jsonString = [self jsonStringWithCompacted:NO];
    return jsonString;
}
- (NSData *)jsonData{
    NSData *stringData = [self jsonDataWithCompacted:NO];
    return stringData;
}
- (NSString *)jsonStringWithCompacted:(BOOL)compact{
    NSString *jsonString;
    NSData *stringData = [self jsonDataWithCompacted:compact];
    if(stringData){
        jsonString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
- (NSData *)jsonDataWithCompacted:(BOOL)compact{
    NSError *error;
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:self options:compact?0:NSJSONWritingPrettyPrinted error:&error];
    return stringData;
}
@end
