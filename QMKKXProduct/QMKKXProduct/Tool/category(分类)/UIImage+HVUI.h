//
//  UIImage+HVUI.h
//  hvui
//	对图片进行仿射映射矩阵变换
//  Created by moon on 14/12/17.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HVUI)


/**
 *  水平翻转图片
 *
 *  @return 新的图片
 */
- (UIImage *)horizontalInvertImage;
/**
 *  垂直翻转图片
 *
 *  @return 新的图片
 */
- (UIImage *)verticalInvertImage;
/**
 *  以图片中心为圆点,旋转图片
 *
 *  @param radians 旋转的弧度值,正值时逆时针旋转,负值顺时针旋转
 *
 *  @return 新的图片
 */
- (UIImage *)rotateImageWithRadians:(CGFloat)radians;
/**
 *  对图片进行仿射矩阵变换,得到新的图片
 *
 *  @param transform 要变换的矩阵
 *  @param newSize   进行矩阵变换后,图片尺寸可能会有变化(如旋转15度,尺寸变大了),此时要换入新的尺寸,如果是二倍大小,则该尺寸也要是二倍大小的值
 *
 *  @return 新的图片
 */
- (UIImage *)transformImageWithCTM:(CGAffineTransform)transform newSize:(CGSize)newSize;

/**
 *  对图片进行仿射矩阵变换,得到新的图片
 *
 *  @param transform 要变换的矩阵
 *  @param newSize   进行矩阵变换后,图片尺寸可能会有变化(如旋转15度,尺寸变大了),此时要换入新的尺寸,如果是二倍大小,则该尺寸也要是二倍大小的值
 *  @param orientation 变换后图片的朝向
 *
 *  @return 新的图片
 */
- (UIImage *)transformImageWithCTM:(CGAffineTransform)transform newSize:(CGSize)newSize newOrientation:(UIImageOrientation)orientation;

/**
 *  将图片朝向调整到指定的朝向
 *
 *  @param orientation 新的朝向
 *
 *  @return 如果朝向不变,返回self,否则返回调整后新的图片
 */
- (UIImage *)imageWithOrientation:(UIImageOrientation)orientation;

/**
 *  裁剪出指定rect的图片(限定在自己的size之内)
 *	内部已考虑到retina图片,rect不必为retina图片进行x2处理
 *  @param rect 指定的矩形区域,坐标系为图片坐标系,原点在图片的左上角
 *
 *  @return 新的图片
 */
- (UIImage *)cropImageWithRect:(CGRect)rect;

/**
 *  如果图片的长宽比例与aspectRatio不一致时,裁剪图片,使其比例与aspectRatio一致
 *	如果self是retina图片,则处理后的图片也是retina图片
 *
 *  @param aspectRatio height/width的比例值
 *
 *  @return 调整后的图片
 */
- (UIImage *)cropImageToFitAspectRatio:(CGFloat)aspectRatio;

/**
 *  如果图片的长宽比例与aspectRatioSize不一致时,裁剪图片,使其比例与aspectRatioSize一致
 *	如果self是retina图片,则处理后的图片也是retina图片
 *
 *  @param aspectRatioSize 用于指定长宽比的尺寸
 *
 *  @return 调整后的图片
 */
- (UIImage *)cropImageToFitAspectRatioSize:(CGSize)aspectRatioSize;

/**
 *  返回图片在内存里的像素点所占的内存大小,单位为字节
 *
 *  @return 字节大小
 */
- (NSUInteger)lengthOfRawData;

/**
 *  是否为png图片,判断依据是是否含有alpha通道
 *
 *  @return 是否是png图片
 */
- (BOOL)isPngImage;

/**
 *  获取图片压缩后的二进制数据,如果图片大小超过bytes时,会对图片进行等比例缩小尺寸处理
 *	会自动进行png检测,从而保持alpha通道
 *
 *  @param bytes              二进制数据的大小上限,0代表不限制
 *  @param compressionQuality 压缩后图片质量,取值为0...1,值越小,图片质量越差,压缩比越高,二进制大小越小
 *
 *  @return 二进制数据
 */
- (NSData *)imageDataThatFitBytes:(NSUInteger)bytes withCompressionQuality:(CGFloat)compressionQuality;

/**
 *  获取图片压缩后的二进制数据,如果图片大小超过bytes时,会对图片进行等比例缩小尺寸处理
 *	会自动进行png检测,从而保持alpha通道
 *	如果图片为jpg,默认的图片压缩质量为0.6
 *
 *  @param bytes              二进制数据的大小上限,0代表不限制
 *
 *  @return 二进制数据
 */
- (NSData *)imageDataThatFitBytes:(NSUInteger)bytes;

/**
 *  获取图片png压缩后的二进制数据,如果图片大小超过bytes时,会对图片进行等比例缩小尺寸处理
 *
 *  @param bytes 二进制数据的大小上限,0代表不限制
 *
 *  @return 二进制数据
 */
- (NSData *)imageDataOfPngThatFitBytes:(NSUInteger)bytes;

/**
 *  获取图片jpg压缩后的二进制数据,如果图片大小超过bytes时,会对图片进行等比例缩小尺寸处理
 *
 *  @param bytes              二进制数据的大小上限,0代表不限制
 *  @param compressionQuality 压缩后图片质量,取值为0...1,值越小,图片质量越差,压缩比越高,二进制大小越小
 *
 *  @return 二进制数据
 */
- (NSData *)imageDataOfJpgThatFitBytes:(NSUInteger)bytes withCompressionQuality:(CGFloat)compressionQuality;

/**
 *  将图片等比例缩放到指定的尺寸,当比例不对时,图片会内缩,从而导致透明区域出现
 *	如果self是retina图片,则处理后的图片也是retina图片,其image.size=size
 *
 *  @param size 指定的尺寸
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)scaleImageToAspectFitSize:(CGSize)size;

/**
 *  将图片等比例缩放到指定的尺寸,当比例不对时,图片会外扩,从而导致截断图片
 *	如果self是retina图片,则处理后的图片也是retina图片,其image.size=size
 *
 *  @param size 指定的尺寸
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)scaleImageToAspectFillSize:(CGSize)size;

/**
 *  将图片缩放到指定的尺寸(比例不对时,图片会拉伸)
 *	如果self是retina图片,则处理后的图片也是retina图片,其image.size=size
 *
 *  @param size 指定的尺寸
 *
 *  @return 拉伸后的图片
 */
- (UIImage *)scaleImageToFillSize:(CGSize)size;

/**
 *  如果图片尺寸大于size,则等比例缩小图片,直到满足尺寸<=size;如果图片尺寸小于size,则返回自身
 *
 *  @param size 最大尺寸,此size不需要考虑retina
 *
 *  @return 图片
 */
- (UIImage *)reduceImageSizeToMaxSize:(CGSize)size;

/**
 *  如果图片的像素尺寸大于size*scale,则等比例缩小图片,直到满足尺寸<=size*scale;如果图片尺寸小于size*scale,则返回自身
 *
 *  @param size  最大尺寸
 *  @param scale size放大倍数
 *
 *  @return 图片
 */
- (UIImage *)reduceImageSizeToMaxSize:(CGSize)size scale:(CGFloat)scale;

/**
 *  输出方便阅读的图片信息字符串,例如:size:{943, 943},retinaSize:{943, 943},scale:1,orientation:UIImageOrientationUp,rawBytes:3.39MB,bitsPerComponent:8,bitsPerPixel:32,alphaInfo:kCGImageAlphaPremultipliedLast,spaceModel:kCGColorSpaceModelRGB
 *
 *  @return 字符串
 */
- (NSString *)descriptionOfImage;

/**
 *  返回转换成jpg格式的NSData的大小字符串
 *
 *  @return 文件大小字符串
 */
- (NSString *)filesizeString;
- (NSString *)filesizeStringWithCompressionQuality:(CGFloat)compressionQuality;
@end

@interface UIImage(UIViewTransform)//视图的仿照映射
/**
 *  根据ContentMode属性,获取图片的仿射矩阵,该矩阵的作用是将图片缩放到视图范围内.
	图片进行缩放时,坐标系为UIView的视图坐标系,图片从(0,0,self.size.width*self.scale,self.size.heigt*self.scale)变换到最终的显示效果
*
*  @param contentMode 视图的ContentMode属性
*  @param bounds      限定的矩阵区域
*
*  @return 矩阵
*/
- (CGAffineTransform)transformWithContentMode:(UIViewContentMode)contentMode toBounds:(CGRect)bounds;

/**
 根据contentMode属性,计算从fromBounds坐标系变换到bounds坐标系的仿射矩阵

 @param contentMode 视图的ContentMode属性
 @param fromBounds 起始坐标系
 @param bounds 终止坐标系
 @param imageScale bounds坐标系的缩放参数.对应于UIImage的scale属性值.没有缩放时,传1
 @return 矩阵
 */
+ (CGAffineTransform)transformWithContentMode:(UIViewContentMode)contentMode fromBounds:(CGRect)fromBounds toBounds:(CGRect)bounds scale:(CGFloat)imageScale;
@end

@interface UIImage (HV_UIColor)
///**
// *  使用blend来改变图片的颜色.如一张蓝色的星星图,使用白色的tintColor之后,会变成白色的星星图
// *
// *  @param tintColor 混合的颜色
// *
// *  @return 新的图片
// */
//- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

/**
 *  根据color,获取1x1尺寸的图片.可用于UIButton的backgroundImage属性设置
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithUIColor:(UIColor *)color;

/**
 *  根据color,获取指定尺寸的图片.可用于UIButton的backgroundImage属性设置
 *
 *  @param color 颜色
 *  @param size  图片尺寸
 *
 *  @return 图片
 */
+ (UIImage *)imageWithUIColor:(UIColor *)color size:(CGSize)size;

/**
 *  创建一个遮罩图片,该图片可以作为layer.mask遮罩图片的内容
 *	遮罩图片的底色为蓝色,然后清除掉clearRect(UIView坐标系)指定的区域
 *  @param imageSize 图片大小
 *  @param clearRect 要清除颜色以及alpha值的区域.坐标系为UIView
 *
 *  @return 遮罩图片
 */
+ (UIImage *)imageMaskWithSize:(CGSize)imageSize clearRect:(CGRect)clearRect;

/**
 *  获取图片的主色调
 *
 *  @return 主色调
 */
- (UIColor *)mostColor;

/**
 *  获取某一点的颜色值,坐标系为UIView坐标系(原点在左上角)
 *
 *  @param point 点坐标
 *
 *  @return 颜色对象
 */
- (UIColor *)colorWithPoint:(CGPoint)point;
@end

#import <CoreImage/CoreImage.h>
@interface UIImage(HVUIFaceDetect)//人脸识别

@end

@interface UIImage(HVCIDetector)//图像识别
@property(nonatomic,readonly) NSString *qrcodeString;//二维码识别

+ (UIImage *)imageWithQRCodeString:(NSString *)qrcode size:(CGSize)size;
+ (UIImage *)imageWithQRCodeString:(NSString *)qrcode;//生成屏幕尺寸

/**
 *  返回图片中识别出来的人脸属性
 *  CIFaceFeature.bounds:该bounds是的坐标系是图片坐标系,原点在图片的左下角,bounds.origin为bounds矩形区域的左下角点.图片的长宽为乘以图片scale之后的数值.CIFaceFeature.bounds等坐标值,如果要转换为UIImageView中的坐标值,请使用UIImageView的convertRectFromImageCoordinateSpace:和convertPointFromFromImageCoordinateSpace:方法进行转换
 *  @return @[CIFaceFeature]
 */
@property(nonatomic,readonly) NSArray<CIFaceFeature *> *faceFeatures;

/**
 *  进行人脸识别
 *
 *  @param options 选项,key值有CIDetectorAccuracy,CIDetectorTracking,...
 *
 *  @return @[CIFaceFeature]
 */
- (NSArray<CIFaceFeature *> *)faceFeaturesWithOptions:(NSDictionary *)options;

/**
 *  返回图片中人脸的矩阵区域,如果有多个,取并集
 *
 *  @return 区域,该值是的坐标系是图片坐标系,原点在图片的左下角,bounds.origin为bounds矩形区域的左下角点.图片的长宽为乘以图片scale之后的数值.CIFaceFeature.bounds等坐标值,如果要转换为UIImageView中的坐标值,请使用UIImageView的convertRectFromImageCoordinateSpace:和convertPointFromFromImageCoordinateSpace:方法进行转换
 */
@property(nonatomic,readonly) CGRect faceBounds;
- (CGRect)faceBoundsWithFeatures:(NSArray<CIFaceFeature *> *)faceFeatures;
@end

#import <CoreLocation/CoreLocation.h>
@interface NSDictionary (HV_UIImage_Metadata)
@property(nonatomic,readonly) CLLocation *hv_locationMetadata;
@end
@interface NSMutableDictionary (HV_UIImage_Metadata)
- (void)hv_setLocationMetadata:(CLLocation *)location;
- (void)hv_setImageOrientationMetadataIfNeed:(UIImageOrientation)orientation;
@end
@interface UIImage (HV_UIImage_Metadata)
@property(nonatomic,readonly) NSDictionary *hv_imageMetadata;//获取图片的元数据信息
+ (NSDictionary *)hv_imageMetadataWithImageData:(NSData *)data;
+ (NSData *)hv_setImageMetadata:(NSDictionary *)metadata toImageData:(NSData *)data;
+ (NSData *)hv_addImageMetadata:(NSDictionary *)metadata toImageData:(NSData *)data;
@end
