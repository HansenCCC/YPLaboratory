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
 
 @return YES or NO
 */
- (BOOL)isValidPhone;

/**
 判断是不是有效url
 
 @return YES or NO
 */
- (BOOL)isValidURL;

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

#pragma mark - NSNumber
/**
 *  如果字符串内容为数字时,返回数字对应的NSNumber对象
 *
 *  @return 数字对象
 */
- (NSNumber *)numberValue;
- (NSNumber *)numberOfInteger;
- (NSNumber *)numberOfLongLong;
- (NSNumber *)numberOfCGFloat;
- (NSNumber *)numberOfFloat;
- (NSNumber *)numberOfDouble;

/**
 * 判断字符字符是否是数字 （包含小数点）
 */
-(BOOL)isInputShouldNumber;

/**
 * 判断字符字符是否是数字 0-9 （不包含小数点）
 */
-(BOOL)isInputShouldNumber0_9;

#pragma mark - date

/**
 字符串转指定格式时间
 
 @param format 时间格式
 @return 返回指定格式format
 */
- (NSDate *)dateWithFormat:(NSString *)format;


#pragma mark - 文件格式
//常见文档格式集合 TXT、DOC、XLS、PPT、DOCX、XLSX、PPTX
+ (NSArray <NSString *> *)fileArchives;
//常见图片格式集合 JPG、PNG、PDF、TIFF、SWF
+ (NSArray <NSString *> *)fileImages;
//常见视频格式集合FLV、RMVB、MP4、MVB
+ (NSArray <NSString *> *)fileVideo;
//常见音频格式集合WMA、MP3
+ (NSArray <NSString *> *)fileMusics;
//常见压缩格式集合ZIP RAR
+ (NSArray <NSString *> *)fileZips;
//常见网站格式集合html
+ (NSArray <NSString *> *)fileWeb;
//常见数据库集合db
+ (NSArray <NSString *> *)fileDatabase;
@end
