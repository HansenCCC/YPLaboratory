//
//  NSString+KExtension.h
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/26.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (KExtension)
@property(nonatomic, readonly) NSString *md5;//返回小写md5值
@property(nonatomic, readonly) NSString *MD5;//返回大写md5值
@property(nonatomic, readonly) NSURL *toURL;//返回url值

#pragma mark - analysis
/**
 对json格式的字符串进行处理，返回其对应的NSDictionary或者NSArray等对象
 例如：NSString *str = @"{\"name\":\"kaixuan_166\"}";
 @return json对象
 */
- (id)jsonValue;

/**
 string为NSDictionary的json格式

 @return json对应的Dictionary
 */
- (NSDictionary *)jsonDictionary;

/**
 string為NSArray的json格式

 @return json对应的Array
 */
- (NSArray *)jsonArray;


#pragma mark - class methods
/**
 判断是否是手机号码
 @param mobile 手机号字符串
 @return YES or NO
 */
+ (BOOL)valiMobile:(NSString *)mobile;

/**
 判断是不是有效url
 
 @return YES or NO
 */
+ (BOOL)validURLString:(NSString *)URLString;

/**
 校验当前版本是否需要更新
 
 @param version 服务器版本
 @param locaVersion 本地版本
 @return 是否需要更新
 */
+ (BOOL)compareVesionWithServerVersion:(NSString *)version locaVersion:(NSString *)locaVersion;

/**
 拼接字符串
 
 @param string 被拼接的字符
 @return 拼接完成的字符
 */
- (NSString *)addString:(NSString *)string;

/**
 通过字符字体获取现在试图的宽度
 
 @param font font
 @param maxSize 最大尺寸
 @return 尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 获取当前版本型号
 
 @return 手机型号
 */
+ (NSString *)getCurrentDeviceModel;
@end
