//
//  UIImage+KExtension.m
//  KExtension
//
//  Created by Herson on 17/2/5.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "UIImage+KExtension.h"

@implementation UIImage (KExtension)

- (CGSize)sizeWithMaxRelativeSize:(CGSize)size isMax:(BOOL) isMax{
    CGSize imageSize = self.size;
    CGSize resultSize = CGSizeZero;
    if (size.width == 0&&size.height != 0) {
        resultSize.height = size.height;
        resultSize.width = imageSize.width/imageSize.height * resultSize.height;
        return resultSize;
    }else if(size.width != 0&&size.height == 0){
        resultSize.width = size.width;
        resultSize.height = resultSize.width * imageSize.height/imageSize.width;
        return resultSize;
    }else if(size.width == 0&&size.height == 0){
        return self.size;
    }
    if ((imageSize.width/imageSize.height >= size.width/size.height&&isMax)||(imageSize.width/imageSize.height < size.width/size.height&&!isMax)){
        resultSize.height = size.height;
        resultSize.width = imageSize.width/imageSize.height * resultSize.height;
        return resultSize;
    }else{
        resultSize.width = size.width;
        resultSize.height = resultSize.width * imageSize.height/imageSize.width;
        return resultSize;
    }
    return resultSize;
}
- (CGSize)sizeWithMaxRelativeSize:(CGSize)size{
    CGSize resize = [self sizeWithMaxRelativeSize:size isMax:YES];
    return resize;
}
- (CGSize)sizeWithMinRelativeSize:(CGSize)size{
    CGSize resize = [self sizeWithMaxRelativeSize:size isMax:NO];
    return resize;
}
- (BOOL)isPngImage{
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    BOOL isPng = !(alphaInfo==kCGImageAlphaNone||alphaInfo==kCGImageAlphaNoneSkipLast||alphaInfo==kCGImageAlphaNoneSkipFirst);
    return isPng;
}
- (NSUInteger)lengthOfRawData{
    CGDataProviderRef providerRef = CGImageGetDataProvider(self.CGImage);
    CFDataRef dataRef = CGDataProviderCopyData(providerRef);
    CFIndex len = CFDataGetLength(dataRef);
    CFRelease(dataRef);
    return (NSUInteger)len;
}


+(UIImage*)imageWithColor:(UIColor*) color{
    UIImage *image = [UIImage createImageWithColor:color];
    return image;
}

+(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(UIImage *)convertImageToGrey{
    UIImage *image = nil;
    if (self){
        image = [self convertImageToGreyScale:self]?:self;
    }
    return image;
}
- (UIImage*)convertImageToGreyScale:(UIImage*) image
{
    CGRect imageRect = CGRectMake(0, 0.f, image.size.width, image.size.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8.f, 0.f, colorSpace, kCGImageAlphaNone);
    CGContextDrawImage(context, imageRect, [image CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    return newImage;
}

+ (UIImage *)imageWithName:(NSString *)name forBundle:(NSBundle *)bundle{
    if(name.length==0)return nil;
    UIImage *image;
    //获取到的是类似文件的相对路径
    /*
     NSString *path = [[NSBundle mainBundle]pathForResource:@"login@2x" ofType:@"png"];
     不使用该方法获取路径是因为该方法是获取到的是具体的某一个文件，不能进行自动匹配
     */
    NSString *path = [[bundle resourcePath] stringByAppendingPathComponent:name];
    //@2x、@3x就是imageWithContentsOfFile:自动来匹配了。
    image = [UIImage imageWithContentsOfFile:path];
    return image;
}
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    //返回剪裁后的图片
    return newImage;
}
+ (UIImage*)image:(UIImage *)image scaleToSize:(CGSize)size{
    // 得到图片上下文，指定绘制范围
    UIGraphicsBeginImageContext(size);
    // 将图片按照指定大小绘制
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前图片上下文中导出图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 当前图片上下文出栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake( 0.f, 0.f, size.width, size.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size scale:(CGFloat) scale{
    size.width *= scale;
    size.height *= scale;
    return [self compressOriginalImage:image toSize:size];
}
//矫正image 位置
+ (UIImage *)fixOrientation:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp)
        return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform,M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width,0);
            transform = CGAffineTransformRotate(transform,M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform,0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width,0);
            transform = CGAffineTransformScale(transform, -1,1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height,0);
            transform = CGAffineTransformScale(transform, -1,1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage),0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx,CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
        default:
            CGContextDrawImage(ctx,CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end

@implementation UIImage (KExtension_UIColor)
- (UIImage *)imageWithTintColor:(UIColor *)tintColor{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake( 0.f, 0.f, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}
@end
