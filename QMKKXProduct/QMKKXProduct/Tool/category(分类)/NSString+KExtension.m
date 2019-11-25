//
//  NSString+KExtension.m
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/26.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "NSString+KExtension.h"
#import "NSData+KExtension.h"
#import <sys/utsname.h>//要导入头文件

@implementation NSString (KExtension)
//转URL
- (NSURL *)toURL{
    return [NSURL URLWithString:self];
}
-(NSString *)md5{
    NSString *md5 = [self dataUsingEncoding:NSUTF8StringEncoding].md5String;
    return md5;
}
-(NSString *)MD5{
    NSString *MD5 = [self dataUsingEncoding:NSUTF8StringEncoding].MD5String;
    return MD5;
}

- (id)jsonValue{
    if (self.length == 0) return nil;
    NSData *value = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id objc = [NSJSONSerialization JSONObjectWithData:value options:NSJSONReadingMutableContainers error:&error];
    if (objc==nil&&error!=nil) {
        NSLog(@"%@",error.localizedDescription);
    }
    return objc;
}
- (NSArray *)jsonArray{
    id jsonValue = [self jsonValue];
    if ([jsonValue isKindOfClass:[NSArray class]]) {
        return jsonValue;
    }else{
        return nil;
    }
}
- (NSDictionary *)jsonDictionary{
    id jsonValue = [self jsonValue];
    if ([jsonValue isKindOfClass:[NSDictionary class]]) {
        return jsonValue;
    }else{
        return nil;
    }
}
- (BOOL)isValidPhone{
    NSString *mobile = self;
    if (mobile.length != 11){
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES)){
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)isValidURL{
    NSString *URLString = self;
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:URLString];
}
//校验当前版本是否需要更新
+ (BOOL)compareVesionWithServerVersion:(NSString *)version locaVersion:(NSString *)locaVersion{
    NSArray *versionArray = [version componentsSeparatedByString:@"."];//服务器返回版
    NSArray *currentVesionArray = [locaVersion componentsSeparatedByString:@"."];//当前版本
    NSInteger a = (versionArray.count> currentVesionArray.count)?currentVesionArray.count : versionArray.count;
    for (int i = 0; i < a; i ++) {
        NSInteger a = [[versionArray objectAtIndex:i] integerValue];
        NSInteger b = [[currentVesionArray objectAtIndex:i] integerValue];
        if (a > b) {
            return YES;
        }else if(a < b){
            return NO;
        }
    }
    return NO;
}

- (NSString *)addString:(NSString *)string {
    return [NSString stringWithFormat:@"%@%@",self,string];
}

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSString *)getCurrentDeviceModel{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceModel;
}

#pragma mark - NSNumber
/**
 *  如果字符串内容为数字时,返回数字对应的NSNumber对象
 *
 *  @return 数字对象
 */
- (NSNumber *)numberValue{
    NSNumber *number;
    number = [self numberOfInteger];
    if(!number){
        number = [self numberOfLongLong];
    }
    if(!number){
        number = [self numberOfCGFloat];
    }
    return number;
}
- (NSNumber *)numberOfInteger{
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    NSInteger value;
    if([scanner scanInteger:&value]&&scanner.isAtEnd){
        return @(value);
    }
    return nil;
}
- (NSNumber *)numberOfLongLong{
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    long long value;
    if([scanner scanLongLong:&value]&&scanner.isAtEnd){
        return @(value);
    }
    return nil;
}
- (NSNumber *)numberOfCGFloat{
#if defined(__LP64__) && __LP64__
    return [self numberOfDouble];
#else
    return [self numberOfFloat];
#endif
}
- (NSNumber *)numberOfFloat{
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    float value;
    if([scanner scanFloat:&value]&&scanner.isAtEnd){
        return @(value);
    }
    return nil;
}
- (NSNumber *)numberOfDouble{
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    double value;
    if([scanner scanDouble:&value]&&scanner.isAtEnd){
        return @(value);
    }
    return nil;
}
//判断字符字符是否是数字
-(BOOL)isInputShouldNumber{
    NSString *strValue = self;
    if (strValue == nil || [strValue length] <= 0){
        return NO;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![strValue isEqualToString:filtered]){
        return NO;
    }
    return YES;
}

//判断字符字符是否是数字 0-9 （不包含小数点）
-(BOOL)isInputShouldNumber0_9{
    NSString *strValue = self;
    if (strValue == nil || [strValue length] <= 0){
        return NO;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![strValue isEqualToString:filtered]){
        return NO;
    }
    return YES;
}
#pragma mark - date
- (NSDate *)dateWithFormat:(NSString *)format{
    NSDate *date = [NSDate dateWithString:self dateFormat:format];
    return date;
}

#pragma mark - 文件格式
//常见文档格式集合 TXT、DOC、XLS、PPT、DOCX、XLSX、PPTX
+ (NSArray <NSString *> *)fileArchives{
    return @[@"TXT",@"txt",
             @"DOC",@"doc",
             @"XLS",@"xls",
             @"PPT",@"ppt",
             @"DOCX",@"docx",
             @"XLSX",@"xlsx",
             @"PPTX",@"pptx",];
}
//常见图片格式集合 JPG、PNG、PDF、TIFF、SWF
+ (NSArray <NSString *> *)fileImages{
    return @[@"JPG",@"jpg",
             @"PNG",@"png",
             @"PDF",@"pdf",
             @"TIFF",@"tiff",
             @"SWF",@"swf",];
}
//常见视频格式集合FLV、RMVB、MP4、MVB
+ (NSArray <NSString *> *)fileVideo{
    return @[@"FLV",@"flv",
             @"RMVB",@"rmvb",
             @"MP4",@"mp4",
             @"MVB",@"mvb",
            ];
}
//常见音频格式集合WMA、MP3
+ (NSArray <NSString *> *)fileMusics{
    return @[@"WMA",@"wma",
             @"MP3",@"mp3",];
}
//常见压缩格式集合ZIP RAR
+ (NSArray <NSString *> *)fileZips{
    return @[@"ZIP",@"zip",
             @"RAR",@"rar",
             @"XIP",@"xip",];
}
//常见网站格式集合html
+ (NSArray <NSString *> *)fileWeb{
    return @[@"HTML",@"html",];
}
@end
