//
//  KKAppIcon.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/11.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "KKAppIcon.h"

@interface KKAppIcon ()
@property(assign, nonatomic) CGSize size;
@property(assign, nonatomic) CGFloat scale;
@property(strong, nonatomic) UIImage *scaledImage;
@end

@implementation KKAppIcon
- (BOOL)canCompressed{
    CGSize s1 = self.originImage.size;
    s1.width *= self.originImage.scale;
    s1.height *= self.originImage.scale;
    CGSize s2 = self.size;
    s2.width *= self.scale;
    s2.height *= self.scale;
    BOOL canCompressed = s1.width>s2.width||s1.height>s2.height;
    return canCompressed;
}
- (instancetype)initWithOriginImage:(UIImage *)originImage name :(NSString *)name size:(CGSize)size scale:(CGFloat)scale{
    if (self = [super init]) {
        self.originImage = originImage;
        self.name = name;
        self.size = size;
        self.scale = scale;
    }
    return self;
}
- (id)initWithName:(NSString *)name size:(CGSize)size scale:(CGFloat)scale{
    if ([self initWithOriginImage:nil name:name size:size scale:scale]) {
    }
    return self;
}
- (void)compressImage{
    self.scaledImage = [UIImage compressOriginalImage:self.originImage toSize:self.size scale:self.scale];
}
- (void)saveToDir:(NSString *)dirPath{
    if(![[NSFileManager defaultManager] fileExistsAtPath:dirPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    NSData *data = UIImagePNGRepresentation(self.scaledImage);
    NSString *filePath = [dirPath stringByAppendingPathComponent:self.name];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}
+ (NSArray <KKAppIcon *> *)appIconListWithOriginImage:(UIImage *)originImage{
    NSArray<KKAppIcon *> *allIcons =
  @[
    //iPhone
    [self icon_iPhone_20_2x],
    [self icon_iPhone_20_3x],
    [self icon_iPhone_29_2x],
    [self icon_iPhone_29_3x],
    [self icon_iPhone_40_2x],
    [self icon_iPhone_40_3x],
    [self icon_iPhone_60_2x],
    [self icon_iPhone_60_3x],
    
    //iPad
    [self icon_iPad_20],
    [self icon_iPad_20_2x],
    [self icon_iPad_29],
    [self icon_iPad_29_2x],
    [self icon_iPad_40],
    [self icon_iPad_40_2x],
    [self icon_iPad_76],
    [self icon_iPad_76_2x],
    
    [self icon_iPad_167],//83.5*83.5_2x
    
    //App Store
    [self icon_AppStore_1024],
    ];
    NSMutableArray<KKAppIcon *> *icons = [[NSMutableArray alloc] initWithCapacity:allIcons.count];
    for (KKAppIcon *icon in allIcons) {
        icon.originImage = originImage;
        [icon compressImage];
        [icons addObject:icon];
//        if([icon canCompressed]){//不允许原尺寸小于变化尺寸
//            [icon compressImage];
//            [icons addObject:icon];
//        }
    }
    return allIcons;
}
@end

@implementation KKAppIcon (AppIcom)
#pragma mark - iPhone
+(KKAppIcon *)icon_iPhone_20_2x{
    return [[KKAppIcon alloc] initWithName:@"IconiPhone-20@2x.png" size:CGSizeMake(20, 20) scale:2];
}
+(KKAppIcon *)icon_iPhone_20_3x{
    return [[KKAppIcon alloc] initWithName:@"IconiPhone-20@3x.png" size:CGSizeMake(20, 20) scale:3];
}
+(KKAppIcon *)icon_iPhone_29_2x{
    return [[KKAppIcon alloc] initWithName:@"IconiPhone-29@2x.png" size:CGSizeMake(29, 29) scale:2];
}
+(KKAppIcon *)icon_iPhone_29_3x{
    return [[KKAppIcon alloc] initWithName:@"IconiPhone-29@3x.png" size:CGSizeMake(29, 29) scale:3];
}
+(KKAppIcon *)icon_iPhone_40_2x{
    return [[KKAppIcon alloc] initWithName:@"IconiPhone-40@2x.png" size:CGSizeMake(40, 40) scale:2];
}
+(KKAppIcon *)icon_iPhone_40_3x{
    return [[KKAppIcon alloc] initWithName:@"IconiPhone-40@3x.png" size:CGSizeMake(40, 40) scale:3];
}
+(KKAppIcon *)icon_iPhone_60_2x{
    return [[KKAppIcon alloc] initWithName:@"IconiPhone-60@2x.png" size:CGSizeMake(60, 60) scale:2];
}
+(KKAppIcon *)icon_iPhone_60_3x{
    return [[KKAppIcon alloc] initWithName:@"IconiPhone-60@3x.png" size:CGSizeMake(60, 60) scale:3];
}

#pragma mark - iPad
+(KKAppIcon *)icon_iPad_20{
    return [[KKAppIcon alloc] initWithName:@"IconiPad-20.png" size:CGSizeMake(20, 20) scale:1];
}
+(KKAppIcon *)icon_iPad_20_2x{
    return [[KKAppIcon alloc] initWithName:@"IconiPad-20@2x.png" size:CGSizeMake(20, 20) scale:2];
}
+(KKAppIcon *)icon_iPad_29{
    return [[KKAppIcon alloc] initWithName:@"IconiPad-29.png" size:CGSizeMake(29, 29) scale:1];
}
+(KKAppIcon *)icon_iPad_29_2x{
    return [[KKAppIcon alloc] initWithName:@"IconiPad-29@2x.png" size:CGSizeMake(29, 29) scale:2];
}
+(KKAppIcon *)icon_iPad_40{
    return [[KKAppIcon alloc] initWithName:@"IconiPad-40.png" size:CGSizeMake(40, 40) scale:1];
}
+(KKAppIcon *)icon_iPad_40_2x{
    return [[KKAppIcon alloc] initWithName:@"IconiPad-40@2x.png" size:CGSizeMake(40, 40) scale:2];
}
+(KKAppIcon *)icon_iPad_76{
    return [[KKAppIcon alloc] initWithName:@"IconiPad-76.png" size:CGSizeMake(76, 76) scale:1];
}
+(KKAppIcon *)icon_iPad_76_2x{
    return [[KKAppIcon alloc] initWithName:@"IconiPad-76@2x.png" size:CGSizeMake(76, 76) scale:2];
}

+(KKAppIcon *)icon_iPad_167{//83.5*83.5_2x
    return [[KKAppIcon alloc] initWithName:@"IconiPad-167.png" size:CGSizeMake(167, 167) scale:1];
}
#pragma mark - App Store
+(KKAppIcon *)icon_AppStore_1024{
    return [[KKAppIcon alloc] initWithName:@"IconAppStore-1024.png" size:CGSizeMake(1024, 1024) scale:1];
}
+ (void)saveContentJsonToDir:(NSString *)dirPath{
    if(![[NSFileManager defaultManager] fileExistsAtPath:dirPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    NSString *fileName = @"Contents.json";
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}
@end
