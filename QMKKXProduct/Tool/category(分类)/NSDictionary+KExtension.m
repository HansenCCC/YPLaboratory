//
//  NSDictionary+KExtension.m
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/20.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "NSDictionary+KExtension.h"

@implementation NSDictionary (KExtension)
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
    //NSJSONReadingMutableContainers：返回可变容器，NSMutableDictionary或NSMutableArray。
    //NSJSONReadingMutableLeaves：返回的JSON对象中字符串的值为NSMutableString，目前在iOS 7上测试不好用，应该是个bug
    //NSJSONReadingAllowFragments：允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。
    //NSJSONWritingPrettyPrinted：的意思是将生成的json数据格式化输出，这样可读性高，不设置则输出的json字符串就是一整行。
    //    [NSJSONSerialization JSONObjectWithData:(nonnull NSData *) options:(NSJSONReadingOptions) error:(NSError * _Nullable __autoreleasing * _Nullable)]
    NSError *error;
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:self options:compact?0:NSJSONWritingPrettyPrinted error:&error];
    return stringData;
}
@end
