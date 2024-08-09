//
//  KKAppIcon.h
//  lwlab
//  图标制作工具类
//  Created by 程恒盛 on 2018/4/11.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKAppIcon : NSObject

@property(strong, nonatomic) UIImage *originImage;//原始图片
@property(strong, nonatomic) NSString *name;

@property(readonly, nonatomic) UIImage *scaledImage;//改变后图片
@property(readonly, nonatomic) CGSize size;
@property(readonly, nonatomic) CGFloat scale;//倍数
@property(readonly, nonatomic) BOOL canCompressed;//不允许原尺寸小于变化尺寸
- (void)compressImage;//压缩图片
- (instancetype)initWithOriginImage:(UIImage *)originImage name :(NSString *)name size:(CGSize)size scale:(CGFloat)scale;
- (id)initWithName:(NSString *)name size:(CGSize)size scale:(CGFloat)scale;

- (void)saveToDir:(NSString *)dirPath;//保存指定路径

+ (NSArray <KKAppIcon *> *)appIconListWithOriginImage:(UIImage *)originImage;
@end


/**
 appIcon图标
 iPhone
        20*20_2x 20*20_3x  29*29_2x 29*29_3x
        40*40_2x 40*40_3x  60*60_2x 60*60_3x
 iPad
        20*20_1x 20*20_2x  29*29_1x 29*29_2x
        40*40_1x 40*40_2x  76*76_1x 76*76_2x
        83.5*83.5_2x
 App Store
        1024*1024
 */
@interface KKAppIcon (AppIcom)

#pragma mark - iPhone
+(KKAppIcon *)icon_iPhone_20_2x;
+(KKAppIcon *)icon_iPhone_20_3x;
+(KKAppIcon *)icon_iPhone_29_2x;
+(KKAppIcon *)icon_iPhone_29_3x;
+(KKAppIcon *)icon_iPhone_40_2x;
+(KKAppIcon *)icon_iPhone_40_3x;
+(KKAppIcon *)icon_iPhone_60_2x;
+(KKAppIcon *)icon_iPhone_60_3x;


#pragma mark - iPad
+(KKAppIcon *)icon_iPad_20;
+(KKAppIcon *)icon_iPad_20_2x;
+(KKAppIcon *)icon_iPad_29;
+(KKAppIcon *)icon_iPad_29_2x;
+(KKAppIcon *)icon_iPad_40;
+(KKAppIcon *)icon_iPad_40_2x;
+(KKAppIcon *)icon_iPad_76;
+(KKAppIcon *)icon_iPad_76_2x;

+(KKAppIcon *)icon_iPad_167;//83.5*83.5_2x

#pragma mark - App Store
+(KKAppIcon *)icon_AppStore_1024;

+ (void)saveContentJsonToDir:(NSString *)dirPath;//保存Appicon json文件到指定路径
@end
