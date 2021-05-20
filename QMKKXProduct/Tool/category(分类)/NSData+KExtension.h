//
//  NSData+KExtension.h
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/20.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (KExtension)
#pragma mark - md5
@property(nonatomic,readonly) NSData *MD5;//返回对应的md5数据
@property(nonatomic,readonly) NSString *MD5String;//返回大写的md5字符串
@property(nonatomic,readonly) NSString *md5String;//返回小写的md5字符串

#pragma mark - encoding
@property(nonatomic,readonly) NSString *UTF8String;//data 转 字符串

@end
