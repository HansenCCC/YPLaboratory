//
//  UIImage+KExtension.h
//  KExtension
//
//  Created by Herson on 17/2/5.
//  Copyright © 2017年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KExtension)


#pragma mark - size

/**
 返回最大相对尺寸。x/y 为0时，尺寸不受约束
 
 @param size 尺寸
 @return 最佳尺寸
 */
- (CGSize)sizeWithMaxRelativeSize:(CGSize)size;

/**
 返回最小相对尺寸。x/y 为0时，尺寸不受约束
 
 @param size 尺寸
 @return 最佳尺寸
 */
- (CGSize)sizeWithMinRelativeSize:(CGSize)size;



#pragma mark -

/**
 返回图片在内存里的像素点所占的内存大小,单位为字节(Byte) 1kb = 1024btye

 @return 字节大小
 */
- (NSUInteger)lengthOfRawData;

/**
 是否是png,判断依据是是否含有alpha通道

 @return 是否png
 */
- (BOOL)isPngImage;


#pragma mark - 资源获取
/**
 获取bundle里面图片
 
 @param name   图片名称
 @param bundle bundle文件
 
 @return 返回图片
 */
+ (UIImage *)imageWithName:(NSString *)name forBundle:(NSBundle *)bundle;


#pragma mark - 图片操作
/**
 将颜色转化成图片
 
 @param color 需要转化成图片的颜色
 
 @return UIImage
 */
+(UIImage*)imageWithColor:(UIColor*) color;


/**
 黑白化图片
 
 @return GreyImage
 */
-(UIImage *)convertImageToGrey;

/**
 将图片缩放到指定的CGSize大小

 @param image 原始的图片
 @param size 要缩放到的大小
 @return 处理后的图片
 */
+ (UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size;

/**
 从图片中按指定的位置大小截取图片的一部分
 
 @param image UIImage image 原始的图片
 @param rect  要截取的区域
 
 @return 截取部分
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;


/**
 压缩图片到指定尺寸大小

 @param image 原图片
 @param size 目标尺寸
 @return 生成图片
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size scale:(CGFloat) scale;


/**
 矫正image 位置

 @param image image
 @return image
 */
+ (UIImage *)fixOrientation:(UIImage *)image;

/**
 限制图片大小，传入的maxSize单位是KB

 @param sourceImage 要处理的图片
 @param maxSize 大小
 @return 返回响应尺寸
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxSizeWithKB:(CGFloat)maxSize;
@end


@interface UIImage (KExtension_UIColor)

/**
 *  使用blend来渲染图片的颜色
 *
 *  @param tintColor 混合的颜色
 *  @return 新的图片
 */
- (UIImage *)kk_imageWithTintColor:(UIColor *)tintColor;

@end

