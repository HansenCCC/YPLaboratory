//
//  NSDictionary+KExtension.h
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/20.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KExtension)
/**
 *  返回json格式的字符串
 *
 *  @return 字符串
 */
- (NSString *)jsonString;

/**
 *  返回json格式的二进制数据
 *
 *  @return NSData对象
 */
- (NSData *)jsonData;

/**
 *  返回json格式的字符串
 *
 *  @param compact 是否要压缩字符串,YES:将输出没有分行的字符串,NO:将输出分好行的字符串,便于阅读
 *
 *  @return 字符串
 */
- (NSString *)jsonStringWithCompacted:(BOOL)compact;

/**
 *  返回json格式的二进制数据
 *
 *  @param compact 是否输出紧凑的数据
 *
 *  @return NSData对象
 */
- (NSData *)jsonDataWithCompacted:(BOOL)compact;
@end
