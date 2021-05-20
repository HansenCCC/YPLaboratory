//
//  NSObject+KExtension.h
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/20.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KExtension)

@property(copy, readonly) NSString *lwDescription;//描述

/**
 获取当前类所有的属性列表

 @return 属性列表
 */
+ (NSArray <NSString *> *)getMyAllPropertyNames;
/**
 获取所有的属性列表

 @return 属性列表
 */
+ (NSArray <NSString *> *)getAllPropertyNames;
/**
 获取 当前类 -> root类（包括root类）的属性列表

 @param root 指定根父类
 @return 属性列表
 */
+ (NSArray <NSString *> *)getAllPropertyNamesToRoot:(Class)root;

/**
 获取当前类所有的属性列表及属性对应的值
 
 @return 属性列表
 */
- (NSDictionary *)getMyAllPropertyNamesAndValuesUntilClass;
/**
 获取 当前类 -> root类（包括root类）的属性及属性对应的值

 @param root 指定根父类
 @return 属性及属性对应的值
 */
- (NSDictionary *)getAllPropertyNamesAndValuesUntilClass:(Class)root;
@end
