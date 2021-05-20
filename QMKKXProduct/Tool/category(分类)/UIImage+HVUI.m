//
//  UIImage+HVUI.m
//  hvui
//
//  Created by moon on 14/12/17.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "UIImage+HVUI.h"
@implementation UIImage (HVUI)

- (UIImage *)transformImageWithCTM:(CGAffineTransform)transform newSize:(CGSize)newSize{
	UIImage *img = [self transformImageWithCTM:transform newSize:newSize newOrientation:self.imageOrientation];
	return img;
}
- (CGContextRef)createRGBABitmapContext{
	UIImage *aImage = self;
	CGImageRef imageRef = aImage.CGImage;
	CGFloat width = CGImageGetWidth(imageRef);//向下取整
	CGFloat height = CGImageGetHeight(imageRef);//向下取整
	size_t bitsPerComponent = CGImageGetBitsPerComponent(aImage.CGImage);
	size_t bytesPerRow = width*4;
	CGColorSpaceRef space = CGImageGetColorSpace(aImage.CGImage);
	//	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(aImage.CGImage);//当图片的bitmapinfo为kCGImageAlphaLast时,创建context失败,失败是不支持colorspace与该bitmapinfo的组合
	CGBitmapInfo bitmapInfo = (CGBitmapInfo)kCGImageAlphaPremultipliedLast;
	CGContextRef ctx = CGBitmapContextCreate(NULL,//由系统自动创建和管理位图内存
											 width,//画布的宽度(要求整数值)
											 height,//画布的高度(要求整数值)
											 bitsPerComponent,//每个像素点颜色分量(如R通道)所点的比特数
											 bytesPerRow,//每一行所占的字节数
											 space,//画面使用的颜色空间
											 bitmapInfo//每个像素点内存空间的使用信息,如是否使用alpha通道,内存高低位读取方式等
											 );
	return ctx;
}
- (UIImage *)transformImageWithCTM:(CGAffineTransform)transform newSize:(CGSize)newSize newOrientation:(UIImageOrientation)orientation{
	CGFloat width = floor(newSize.width);//向下取整
	CGFloat height = floor(newSize.height);//向下取整
	UIImage *aImage = self;
	CGFloat scale = aImage.scale;
	size_t bitsPerComponent = CGImageGetBitsPerComponent(aImage.CGImage);
	size_t bytesPerRow = width*4;
	CGColorSpaceRef space = CGImageGetColorSpace(aImage.CGImage);
	//	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(aImage.CGImage);//当图片的bitmapinfo为kCGImageAlphaLast时,创建context失败,失败是不支持colorspace与该bitmapinfo的组合
	CGBitmapInfo bitmapInfo = (CGBitmapInfo)kCGImageAlphaPremultipliedLast;
	CGContextRef ctx = CGBitmapContextCreate(NULL,//由系统自动创建和管理位图内存
											 width,//画布的宽度(要求整数值)
											 height,//画布的高度(要求整数值)
											 bitsPerComponent,//每个像素点颜色分量(如R通道)所点的比特数
											 bytesPerRow,//每一行所占的字节数
											 space,//画面使用的颜色空间
											 bitmapInfo//每个像素点内存空间的使用信息,如是否使用alpha通道,内存高低位读取方式等
											 );
	CGContextConcatCTM(ctx, transform);//对画面里的每个像素点,应用变换矩阵.即最终要显示的像素点的值f([x,y,1])=f([x,y,1]*[矩阵:transform])
	CGContextDrawImage(ctx, CGRectMake(0, 0, CGImageGetWidth(aImage.CGImage), CGImageGetHeight(aImage.CGImage)), aImage.CGImage);//在画布上下文的原来图片所占的矩形区域绘制位图,绘制后,画面上下文会再对该区域里的每一个像素点应用转置矩阵
	CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
	UIImage *img = [UIImage imageWithCGImage:cgimg scale:scale orientation:orientation];
	CGImageRelease(cgimg);
	CGContextRelease(ctx);
	return img;
}
- (UIImage *)horizontalInvertImage{
	CGSize imageSize = CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));//该方法已经考虑到了@2x图片的情况
	CGAffineTransform m = CGAffineTransformIdentity;
	m = CGAffineTransformConcat(m, CGAffineTransformMakeScale(-1, 1));
	m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(imageSize.width, 0));
	UIImage *img = [self transformImageWithCTM:m newSize:imageSize];
	return img;
}
- (UIImage *)verticalInvertImage{
	CGSize imageSize = CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));
	CGAffineTransform m = CGAffineTransformIdentity;
	m = CGAffineTransformConcat(m, CGAffineTransformMakeScale(1, -1));
	m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(0, imageSize.height));
	UIImage *img = [self transformImageWithCTM:m newSize:imageSize];
	return img;
}
- (UIImage *)rotateImageWithRadians:(CGFloat)radians{
	CGSize imageSize = CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));
	CGAffineTransform m = CGAffineTransformIdentity;
	//将图片的中心移动到原点
	m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(-imageSize.width*0.5, -imageSize.height*0.5));
	m = CGAffineTransformConcat(m, CGAffineTransformMakeRotation(radians));//旋转
	//旋转后,图片的矩形大小会变发变化,因此要重新计算矩形大小
	CGRect f = (CGRect){CGPointZero,imageSize};
	CGRect bounds = CGRectApplyAffineTransform(f,m);
	
	m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(bounds.size.width*0.5, bounds.size.height*0.5));//将矩形的左下角移动到原点
	CGSize newSize = bounds.size;
	UIImage *img = [self transformImageWithCTM:m newSize:newSize];
	return img;
}
- (UIImage *)imageWithOrientation:(UIImageOrientation)orientation{
	UIImageOrientation oldOrientation = self.imageOrientation;
	if(self.imageOrientation==orientation){
		return self;
	}
	CGSize imageSize = CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));//该方法已经考虑到了@2x图片的情况和图片的朝向
	CGSize newSize = imageSize;
	
	CGAffineTransform m = CGAffineTransformIdentity;
	BOOL mirrored = NO;
	CGFloat radians = 0;
	//oldOrientation=>UIImageOrientationUp
	switch (oldOrientation) {
		case UIImageOrientationUp:
			break;
		case UIImageOrientationDown:
			radians = M_PI;
			break;
		case UIImageOrientationLeft:
			radians = M_PI_2;
			break;
		case UIImageOrientationRight:
			radians = -M_PI_2;
			break;
		case UIImageOrientationUpMirrored:
			mirrored = YES;
			break;
		case UIImageOrientationDownMirrored:
			mirrored = YES;
			radians = M_PI;
			break;
		case UIImageOrientationLeftMirrored:
			radians = M_PI_2;
			mirrored = YES;
			break;
		case UIImageOrientationRightMirrored:
			radians = -M_PI_2;
			mirrored = YES;
			break;
		default:
			break;
	}
	if(mirrored){
		m = CGAffineTransformConcat(m, CGAffineTransformMakeScale(-1, 1));
		m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(imageSize.width, 0));
	}
	if(radians){
		//将图片的中心移动到原点
		m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(-imageSize.width*0.5, -imageSize.height*0.5));
		m = CGAffineTransformConcat(m, CGAffineTransformMakeRotation(radians));//旋转
		//旋转后,图片的矩形大小会变发变化,因此要重新计算矩形大小
		CGRect f = (CGRect){CGPointZero,imageSize};
		CGRect bounds = CGRectApplyAffineTransform(f,m);
		
		m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(bounds.size.width*0.5, bounds.size.height*0.5));//将矩形的左下角移动到原点
		newSize = bounds.size;
	}
	//UIImageOrientationUp=>orientation
	mirrored = NO;
	radians = 0;
	switch (orientation) {
		case UIImageOrientationUp:
			break;
		case UIImageOrientationDown:
			radians = M_PI;
			break;
		case UIImageOrientationLeft:
			radians = -M_PI_2;
			break;
		case UIImageOrientationRight:
			radians = M_PI_2;
			break;
		case UIImageOrientationUpMirrored:
			mirrored = YES;
			break;
		case UIImageOrientationDownMirrored:
			mirrored = YES;
			radians = M_PI;
			break;
		case UIImageOrientationLeftMirrored:
			radians = -M_PI_2;
			mirrored = YES;
			break;
		case UIImageOrientationRightMirrored:
			radians = M_PI_2;
			mirrored = YES;
			break;
		default:
			break;
	}
	if(mirrored){
		m = CGAffineTransformConcat(m, CGAffineTransformMakeScale(-1, 1));
		m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(imageSize.width, 0));
	}
	if(radians){
		//将图片的中心移动到原点
		m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(-imageSize.width*0.5, -imageSize.height*0.5));
		m = CGAffineTransformConcat(m, CGAffineTransformMakeRotation(radians));//旋转
		//旋转后,图片的矩形大小会变发变化,因此要重新计算矩形大小
		CGRect f = (CGRect){CGPointZero,imageSize};
		CGRect bounds = CGRectApplyAffineTransform(f,m);
		
		m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(bounds.size.width*0.5, bounds.size.height*0.5));//将矩形的左下角移动到原点
		newSize = bounds.size;
	}
	
	UIImage *img = [self transformImageWithCTM:m newSize:newSize newOrientation:orientation];
	return img;
}
- (UIImage *)cropImageWithRect:(CGRect)cropRect{
	CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
	cropRect = CGRectIntersection(bounds, cropRect);//限制在自己的尺寸里面
	CGRect drawRect = CGRectMake(-cropRect.origin.x , -cropRect.origin.y, self.size.width * self.scale, self.size.height * self.scale);
	UIGraphicsBeginImageContext(cropRect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, CGRectMake(0, 0, cropRect.size.width, cropRect.size.height));
	[self drawInRect:drawRect];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}
- (UIImage *)cropImageToFitAspectRatioSize:(CGSize)aspectRatioSize{
	return [self cropImageToFitAspectRatio:aspectRatioSize.height/aspectRatioSize.width];
}
- (UIImage *)cropImageToFitAspectRatio:(CGFloat)aspectRatio{//aspectRatio=height/width
	CGSize imageSize = self.size;
	if(imageSize.width==0){
		return self;
	}
	UIImage *resultImage = self;
	CGFloat myAspectRatio = imageSize.height/imageSize.width;
	if(ABS(myAspectRatio-aspectRatio)>0.0000001){//比例不相同
		CGRect r = CGRectZero;
		if(myAspectRatio>aspectRatio){//height太大了
			r.size.width = imageSize.width;
			r.size.height = imageSize.width*aspectRatio;
		}else{//width太大了
			r.size.height = imageSize.height;
			r.size.width = imageSize.height/aspectRatio;
		}
		r.origin.x = (imageSize.width-r.size.width)/2;
		r.origin.y = (imageSize.height-r.size.height)/2;
		resultImage = [self cropImageWithRect:r];
	}
	return resultImage;
}
- (NSUInteger)lengthOfRawData{
	CGDataProviderRef providerRef = CGImageGetDataProvider(self.CGImage);
	CFDataRef dataRef = CGDataProviderCopyData(providerRef);
	CFIndex len = CFDataGetLength(dataRef);
	CFRelease(dataRef);
	return (NSUInteger)len;
}
- (BOOL)isPngImage{
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
	BOOL isPng = !(alphaInfo==kCGImageAlphaNone||alphaInfo==kCGImageAlphaNoneSkipLast||alphaInfo==kCGImageAlphaNoneSkipFirst);
	return isPng;
}
- (NSData *)imageDataThatFitBytes:(NSUInteger)bytes withCompressionQuality:(CGFloat)compressionQuality{
	BOOL isPng = self.isPngImage;
	NSData *data;
	if(isPng){
		data = [self imageDataOfPngThatFitBytes:bytes];
	}else{
		data = [self imageDataOfJpgThatFitBytes:bytes withCompressionQuality:compressionQuality];
	}
	return data;
}
- (NSData *)imageDataThatFitBytes:(NSUInteger)bytes{
	NSData *data = [self imageDataThatFitBytes:bytes withCompressionQuality:0.6];
	return data;
}
- (NSData *)imageDataOfPngThatFitBytes:(NSUInteger)bytes{
	NSData *data = UIImagePNGRepresentation(self);
	NSUInteger len = data.length;
	if(bytes!=0&&len>bytes){//可以简单认为压缩后的大小与像素点数量成正比
		CGFloat factor = 0.9*sqrt(1.0*bytes/len);//由于只是近似计算,因此再乘上0.9系数,让压缩后的值再小点
		CGSize size = self.size;
		size.width *= factor;
		size.height *= factor;
		UIImage *image = [self scaleImageToAspectFitSize:size];
		data = [image imageDataOfPngThatFitBytes:bytes];
	}
	return data;
}
- (NSData *)imageDataOfJpgThatFitBytes:(NSUInteger)bytes withCompressionQuality:(CGFloat)compressionQuality{
	NSData *data = UIImageJPEGRepresentation(self, compressionQuality);
	NSUInteger len = data.length;
	if(bytes!=0&&len>bytes){//可以简单认为压缩后的大小与像素点数量成正比
		CGFloat factor = 0.9*sqrt(1.0*bytes/len);//由于只是近似计算,因此再乘上0.9系数,让压缩后的值再小点
		CGSize size = self.size;
		size.width *= factor;
		size.height *= factor;
		UIImage *image = [self scaleImageToAspectFitSize:size];
		data = [image imageDataOfJpgThatFitBytes:bytes withCompressionQuality:compressionQuality];
	}
	return data;
}
- (UIImage *)scaleImageToAspectFitSize:(CGSize)size{
	return [self scaleImageToSize:size withContentMode:UIViewContentModeScaleAspectFit];
}
- (UIImage *)scaleImageToAspectFillSize:(CGSize)size{
	return [self scaleImageToSize:size withContentMode:UIViewContentModeScaleAspectFill];
}
- (UIImage *)scaleImageToFillSize:(CGSize)size{
	return [self scaleImageToSize:size withContentMode:UIViewContentModeScaleToFill];
}
- (UIImage *)reduceImageSizeToMaxSize:(CGSize)size{
	UIImage *img;
	CGSize imageSize = self.size;
	if(imageSize.width<=size.width&&imageSize.height<=size.height){
		img = self;
	}else{
		//按image的比例,重新计算size的大小
		CGFloat width = (self.size.width/self.size.height)*size.height;
		if(width>size.width){
			size.height = (self.size.height/self.size.width)*size.width;
		}else{
			size.width = width;
		}
		img = [self scaleImageToFillSize:size];
	}
	return img;
}
- (UIImage *)reduceImageSizeToMaxSize:(CGSize)size scale:(CGFloat)scale{
	CGFloat f = scale/self.scale;
	CGSize imageSizeScaled = CGSizeMake(size.width*f, size.height*f);
	UIImage *image = [self reduceImageSizeToMaxSize:imageSizeScaled];
	return image;
}
//缩放图片到指定尺寸,比例不对时,按照mode进行处理
- (UIImage *)scaleImageToSize:(CGSize)size withContentMode:(UIViewContentMode)mode{
	if(CGSizeEqualToSize(size, self.size)){
		return self;
	}
	CGFloat scale = self.scale;
	CGSize retinaSize = self.size;
	retinaSize.width *= scale;
	retinaSize.height *= scale;
	
	CGSize canvasSize = size;
	canvasSize.width *= scale;
	canvasSize.height *= scale;
	
	CGRect imageRect;
	imageRect.origin = CGPointZero;
	imageRect.size = canvasSize;
	
	switch (mode) {
		case UIViewContentModeScaleAspectFit://缩放时,比例不对会出现透明边
		{
			//缩放
			CGFloat widthOfNew = (retinaSize.width/retinaSize.height)*canvasSize.height;
			if(widthOfNew<=canvasSize.width){
				imageRect.size.width = widthOfNew;
			}else{
				imageRect.size.height = (retinaSize.height/retinaSize.width)*canvasSize.width;
			}
			//居中
			imageRect.origin.x = (canvasSize.width-imageRect.size.width)*0.5;
			imageRect.origin.y = (canvasSize.height-imageRect.size.height)*0.5;
		}
			break;
		case UIViewContentModeScaleAspectFill://缩放时,比例不对会出现裁切
		{
			//缩放
			CGFloat widthOfNew = (retinaSize.width/retinaSize.height)*canvasSize.height;
			if(widthOfNew>=canvasSize.width){
				imageRect.size.width = widthOfNew;
			}else{
				imageRect.size.height = (retinaSize.height/retinaSize.width)*canvasSize.width;
			}
			//居中
			imageRect.origin.x = (canvasSize.width-imageRect.size.width)*0.5;
			imageRect.origin.y = (canvasSize.height-imageRect.size.height)*0.5;
		}
		case UIViewContentModeScaleToFill://缩放时,比例不对时,比例会失真
		default:
			break;
	}
	
//	UIImage *aImage = self;
//	CGImageRef imageRef = aImage.CGImage;
//	CGFloat width = canvasSize.width;//向下取整
//	CGFloat height = canvasSize.height;//向下取整
//	size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
//	size_t bytesPerRow = floor(width)*4;
//	CGColorSpaceRef space = CGImageGetColorSpace(imageRef);
//	
//	//	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(aImage.CGImage);//当图片的bitmapinfo为kCGImageAlphaLast时,创建context失败,失败是不支持colorspace与该bitmapinfo的组合
//	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
//	bitmapInfo = (CGBitmapInfo)kCGImageAlphaPremultipliedLast;
////	if(kCGImageAlphaLast==bitmapInfo){
////		bitmapInfo = (CGBitmapInfo)kCGImageAlphaPremultipliedLast;
////	}
//	CGContextRef ctx = CGBitmapContextCreate(NULL,//由系统自动创建和管理位图内存
//											 width,//画布的宽度(要求整数值)
//											 height,//画布的高度(要求整数值)
//											 bitsPerComponent,//每个像素点颜色分量(如R通道)所点的比特数
//											 bytesPerRow,//每一行所占的字节数
//											 space,//画面使用的颜色空间
//											 bitmapInfo//每个像素点内存空间的使用信息,如是否使用alpha通道,内存高低位读取方式等
//											 );
//	CGContextDrawImage(ctx, imageRect, aImage.CGImage);
//	CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
//	UIImage *img = [UIImage imageWithCGImage:cgimg scale:scale orientation:UIImageOrientationUp];
//	CGImageRelease(cgimg);
//	CGContextRelease(ctx);

	UIGraphicsBeginImageContextWithOptions(canvasSize, NO, 1);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	[self drawInRect:imageRect];
	CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
	UIImage *img = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
	CGImageRelease(imageRef);
	UIGraphicsEndImageContext();
	return img;

}
- (NSString *)descriptionOfImage{
	CGSize size = self.size;
	CGFloat scale = self.scale;
	CGSize retinaSize = CGSizeMake(size.width*scale, size.height*scale);
	NSString *orientationInfo;
	NSUInteger length = [self lengthOfRawData];
	NSString *lengthString = [self __transFileSize:length];
	CGImageRef imageRef = self.CGImage;
	size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
	NSString *alphaInfoString;
	NSString *spaceModelString;
	NSString *bitmapInfoString;
	NSString *info = [NSString stringWithFormat:@"size:%@,retinaSize:%@,scale:%@,orientation:%@,rawBytes:%@,bitsPerComponent:%@,bitsPerPixel:%@,alphaInfo:%@,bitmapInfo:%@,spaceModel:%@",NSStringFromCGSize(size),NSStringFromCGSize(retinaSize),@(scale),orientationInfo,lengthString,@(bitsPerComponent),@(bitsPerPixel),alphaInfoString,bitmapInfoString,spaceModelString];
	return info;
}
- (NSString *)filesizeString{
	NSString *str = [self filesizeStringWithCompressionQuality:1];
	return str;
}
- (NSString *)filesizeStringWithCompressionQuality:(CGFloat)compressionQuality{
	NSData *data = UIImageJPEGRepresentation(self, compressionQuality);
	NSUInteger filesize = data.length;
	NSString *str = [self __transFileSize:filesize];
	return str;
}
- (NSString *)__transFileSize:(NSUInteger)fileSize{//输出方便阅读的文件大小字符串
	NSDictionary *map = [NSDictionary dictionaryWithObjectsAndKeys:
						 [NSNumber numberWithInteger:1024*1024*1024],@"GB",
						 [NSNumber numberWithInteger:1024*1024],@"MB",
						 [NSNumber numberWithInteger:1024],@"KB",
						 [NSNumber numberWithInteger:1],@"B",
						 nil];
	NSString *str = nil;
	for (NSString *unit in map) {
		NSUInteger n = [[map objectForKey:unit] integerValue];
		double v = fileSize*1.0/n;
		if(v>=1||n==1){
			str = [NSString stringWithFormat:@"%.1f%@",v,unit];
		}
	}
	return str;
}
//在指定bundle中,查找指定scale的图片
+ (UIImage *)__imageNamed:(NSString *)name atBundle:(NSBundle *)bundle withScale:(CGFloat)scale{
	UIImage *image;
	NSString *ext = [name pathExtension];
	NSString *fileName = ext.length?[name substringToIndex:name.length-ext.length-1]:name;
	if(scale>1){
		fileName = [NSString stringWithFormat:@"%@@%@x",fileName,@(scale)];
	}
	NSString *path = [bundle pathForResource:fileName ofType:ext];
	if(!path&&ext.length==0){
		ext = @"png";
		path = [bundle pathForResource:fileName ofType:ext];
	}
	if(path){
		image = [UIImage imageWithContentsOfFile:path];
		if(image&&scale>1){
			image = [UIImage imageWithCGImage:image.CGImage scale:scale orientation:image
					 .imageOrientation];
		}
	}
	return image;
}
@end

@implementation UIImage(UIViewTransform)
- (CGAffineTransform)transformWithContentMode:(UIViewContentMode)contentMode toBounds:(CGRect)bounds{
	CGRect fromBounds = CGRectZero;
	CGSize imageSize = self.size;
	CGFloat imageScale = self.scale;
	imageSize.width *= imageScale;
	imageSize.height *= imageScale;
	fromBounds.size = imageSize;
	return [self.class transformWithContentMode:contentMode fromBounds:fromBounds toBounds:bounds scale:imageScale];
}
+ (CGAffineTransform)transformWithContentMode:(UIViewContentMode)contentMode fromBounds:(CGRect)fromBounds toBounds:(CGRect)bounds scale:(CGFloat)imageScale{
	CGAffineTransform m = CGAffineTransformIdentity;
	CGSize imageSize = fromBounds.size;
	CGSize viewSize = bounds.size;
	switch (contentMode) {
		case UIViewContentModeScaleAspectFit:{
			CGFloat scale = viewSize.width/imageSize.width;//视图/图片的比例值
			CGFloat h_view = imageSize.height*scale;
			if(h_view<=viewSize.height){//正解:按宽度等比例缩放
			}else{//按高度等比例缩放
				scale = viewSize.height/imageSize.height;
			}
			m = CGAffineTransformConcat(m, CGAffineTransformMakeScale(scale, scale));//缩放
			CGPoint imageCenter = CGPointMake(imageSize.width*0.5,imageSize.height*0.5);
			CGPoint imageCenterAfterScale = CGPointApplyAffineTransform(imageCenter, m);
			CGPoint viewCenter = CGPointMake(viewSize.width*0.5, viewSize.height*0.5);
			m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(viewCenter.x-imageCenterAfterScale.x, viewCenter.y-imageCenterAfterScale.y));//平移中心点
		}
			break;
		case UIViewContentModeScaleAspectFill:{
			CGFloat scale = viewSize.width/imageSize.width;//视图/图片的比例值
			CGFloat h_view = imageSize.height*scale;
			if(h_view>=viewSize.height){//正解:按宽度等比例缩放
			}else{//按高度等比例缩放
				scale = viewSize.height/imageSize.height;
			}
			m = CGAffineTransformConcat(m, CGAffineTransformMakeScale(scale, scale));//缩放
			CGPoint imageCenter = CGPointMake(imageSize.width*0.5,imageSize.height*0.5);
			CGPoint imageCenterAfterScale = CGPointApplyAffineTransform(imageCenter, m);
			CGPoint viewCenter = CGPointMake(viewSize.width*0.5, viewSize.height*0.5);
			m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(viewCenter.x-imageCenterAfterScale.x, viewCenter.y-imageCenterAfterScale.y));//平移中心点
		}
			break;
		case UIViewContentModeScaleToFill:{
			CGFloat scaleX = viewSize.width/imageSize.width;
			CGFloat scaleY = viewSize.height/imageSize.height;
			
			m = CGAffineTransformConcat(m, CGAffineTransformMakeScale(scaleX, scaleY));//缩放
		}
			break;
		case UIViewContentModeCenter:
			m = [self transformWithTranslationModePosition:CGPointMake(0.5, 0.5) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		case UIViewContentModeLeft:
			m = [self transformWithTranslationModePosition:CGPointMake(0, 0.5) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		case UIViewContentModeRight:
			m = [self transformWithTranslationModePosition:CGPointMake(1, 0.5) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		case UIViewContentModeTop:
			m = [self transformWithTranslationModePosition:CGPointMake(0.5, 0) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		case UIViewContentModeBottom:
			m = [self transformWithTranslationModePosition:CGPointMake(0.5, 1) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		case UIViewContentModeTopLeft:
			m = [self transformWithTranslationModePosition:CGPointMake(0, 0) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		case UIViewContentModeTopRight:
			m = [self transformWithTranslationModePosition:CGPointMake(1, 0) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		case UIViewContentModeBottomLeft:
			m = [self transformWithTranslationModePosition:CGPointMake(0, 1) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		case UIViewContentModeBottomRight:
			m = [self transformWithTranslationModePosition:CGPointMake(1, 1) fromBounds:fromBounds toBounds:bounds scale:imageScale];
			break;
		default:
			break;
	}
	return m;
}
+ (CGAffineTransform)transformWithTranslationModePosition:(CGPoint)point fromBounds:(CGRect)fromBounds toBounds:(CGRect)bounds scale:(CGFloat)imageScale{
	CGSize imageSize = fromBounds.size;
	CGSize viewSize = bounds.size;
	
	CGAffineTransform m = CGAffineTransformIdentity;
	CGFloat scale = 1/imageScale;
	m = CGAffineTransformConcat(m, CGAffineTransformMakeScale(scale, scale));//缩放
	CGPoint imageCenter = CGPointMake(imageSize.width*point.x,imageSize.height*point.y);
	CGPoint imageCenterAfterScale = CGPointApplyAffineTransform(imageCenter, m);
	CGPoint viewCenter = CGPointMake(viewSize.width*point.x, viewSize.height*point.y);
	m = CGAffineTransformConcat(m, CGAffineTransformMakeTranslation(viewCenter.x-imageCenterAfterScale.x, viewCenter.y-imageCenterAfterScale.y));//平移中心点
	return m;
}
@end

@implementation UIImage (HV_UIColor)
//- (UIImage *)kk_imageWithTintColor:(UIColor *)tintColor{
//	UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
//	[tintColor setFill];
//	CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
//	UIRectFill(bounds);
//
//	//Draw the tinted image in context
//	[self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
//
//	UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
//	UIGraphicsEndImageContext();
//
//	return tintedImage;
//}
+ (UIImage *)imageWithUIColor:(UIColor *)color{
	UIImage *img = [self imageWithUIColor:color size:CGSizeMake(1, 1)];
	return img;
}
+ (UIImage *)imageWithUIColor:(UIColor *)color size:(CGSize)size{
	if(!color)return nil;
	CGRect rect = CGRectZero;
	rect.size = size;
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(ctx, color.CGColor);
	CGContextFillRect(ctx, rect);
	CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
	UIImage *img = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	UIGraphicsEndImageContext();
	return img;
}
+ (UIImage *)imageMaskWithSize:(CGSize)imageSize clearRect:(CGRect)clearRect{
	CGRect rect = CGRectZero;
	rect.size = imageSize;
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	UIColor *backgrondColor = [UIColor blueColor];
	CGContextSetFillColorWithColor(ctx, backgrondColor.CGColor);
	CGContextFillRect(ctx, rect);
	CGContextClearRect(ctx, clearRect);
	CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
	UIImage *img = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	UIGraphicsEndImageContext();
	return img;
}
- (UIColor *)mostColor{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
	int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
	int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
	
	//绘制图片,缩小到60x60,以加快速度
	CGSize imageSize = self.size;
	imageSize.width *= self.scale;
	imageSize.height *= self.scale;
	imageSize.width = MAX(60, imageSize.width);
	imageSize.height = MAX(60, imageSize.height);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL,
												 imageSize.width,
												 imageSize.height,
												 8,//bits per component
												 imageSize.width*4,
												 colorSpace,
												 bitmapInfo);
	CGRect drawRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
	CGContextDrawImage(context, drawRect, self.CGImage);
	CGColorSpaceRelease(colorSpace);
	
	//第二步 取每个点的像素值
	unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) {
        CGContextRelease(context);
        return nil;
    }
	
	NSCountedSet *cls=[NSCountedSet setWithCapacity:imageSize.width*imageSize.height];
	for (int x=0; x<imageSize.width; x++) {
		for (int y=0; y<imageSize.height; y++) {
			int offset = 4*(x*y);
			int red = data[offset];
			int green = data[offset+1];
			int blue = data[offset+2];
			int alpha =  data[offset+3];
			NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
			[cls addObject:clr];
		}
	}
	CGContextRelease(context);
	
	//第三步 找到出现次数最多的那个颜色
	NSArray *MaxColor=nil;
	NSUInteger MaxCount=0;
	for (NSArray *curColor in cls) {
		NSUInteger tmpCount = [cls countForObject:curColor];
		if ( tmpCount < MaxCount ) continue;
		MaxCount=tmpCount;
		MaxColor=curColor;
	}
	UIColor *color = [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
	return color;
}
- (UIColor *)colorWithPoint:(CGPoint)point{
	UIColor *color;
	CGImageRef imageRef = self.CGImage;
	CGRect rect = CGRectZero;
	rect.size.width = CGImageGetWidth(imageRef);
	rect.size.height= CGImageGetHeight(imageRef);
	if(point.x<0||point.x>rect.size.width||point.y<0||point.y>rect.size.height){//越界了,返回nil
		return nil;
	}
	CGContextRef ctx = [self createRGBABitmapContext];
	CGContextDrawImage(ctx, rect, imageRef);
	unsigned char* data = CGBitmapContextGetData(ctx);
	int offset = 4*(rect.size.width*round(point.y)+round(point.x));
	int R = data[offset];
	int G = data[offset+1];
	int B = data[offset+2];
	int A = data[offset+3];
	color = [UIColor colorWithRed:R/255. green:G/255. blue:B/255. alpha:A/255.];
	CGContextRelease(ctx);
	return color;
}
@end

#import <AVFoundation/AVFoundation.h>
@implementation UIImage(HVCIDetector)
- (NSArray<CIFeature *> *)featuresWithType:(NSString *)type options:(NSDictionary *)options{
	CIDetector *detector = [CIDetector detectorOfType:type context:[CIContext contextWithOptions:nil] options:options];
	CIImage *img = self.CIImage;
	if(!img){
		if(self.CGImage){
			UIImage *image = [self imageWithOrientation:UIImageOrientationUp];//将图片调整为向上的朝向,否则会检测不到
//			img = [CIImage imageWithCGImage:image.CGImage];//执行这个这个语句时,控制台会输出:CreateWrappedSurface() failed for a dataprovider-backed CGImageRef.的警告
			NSData *data = [image imageDataThatFitBytes:0];
			img = [CIImage imageWithData:data];
		}
	}
	//options:{CIDetectorImageOrientation:kCGImagePropertyOrientation}
	//kCGImagePropertyOrientation
	NSArray<CIFeature *> *features = [detector featuresInImage:img];
	return features;
}
- (NSArray *)faceFeatures{
	NSArray *faceFeatures = [self faceFeaturesWithOptions:nil];
	return faceFeatures;
}
- (NSArray *)faceFeaturesWithOptions:(NSDictionary *)options{
	NSArray *faceFeatures = [self featuresWithType:CIDetectorTypeFace options:options];
	return faceFeatures;
}
- (CGRect)faceBoundsWithFeatures:(NSArray *)faceFeatures{
	CGRect bounds = CGRectZero;
	for (CIFaceFeature *feature in faceFeatures) {
		CGRect b = feature.bounds;
		if(CGRectEqualToRect(bounds, CGRectZero)){
			bounds = b;
		}else{
			bounds = CGRectUnion(bounds, b);
		}
	}
	return bounds;
}
- (CGRect)faceBounds{
	NSArray *faceFeatures = [self faceFeatures];
	CGRect bounds = [self faceBoundsWithFeatures:faceFeatures];
	return bounds;
}
- (NSString *)qrcodeString{
	//todo:唯独iphone5手机,CIDetector返回nil
	NSArray<CIFeature *> *features = [self featuresWithType:CIDetectorTypeQRCode options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
	NSString *string;
	CIQRCodeFeature *feature = (CIQRCodeFeature *)[features firstObject];
	string = feature.messageString;
	return string;
}
+ (UIImage *)imageWithQRCodeString:(NSString *)qrcode size:(CGSize)size{
	NSData *stringData = [qrcode dataUsingEncoding:NSUTF8StringEncoding];
	
	//生成
	CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
	[qrFilter setValue:stringData forKey:@"inputMessage"];
	[qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
	
	UIColor *onColor = [UIColor blackColor];
	UIColor *offColor = [UIColor whiteColor];
	
	//上色
	CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
									   keysAndValues:
							 @"inputImage",qrFilter.outputImage,
							 @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
							 @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
							 nil];
	
	CIImage *qrImage = colorFilter.outputImage;
	
	//绘制
	CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
	UIGraphicsBeginImageContext(size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(context, kCGInterpolationNone);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
	UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	CGImageRelease(cgImage);
	return codeImage;
}
+ (UIImage *)imageWithQRCodeString:(NSString *)qrcode{
	CGSize size = [UIScreen mainScreen].bounds.size;
	CGFloat scale = [UIScreen mainScreen].scale;
	size.width *= scale;
	size.height *= scale;
	UIImage *image = [UIImage imageWithQRCodeString:qrcode size:size];
	return image;
}
@end

#import <ImageIO/ImageIO.h>
@implementation NSDictionary (HV_UIImage_Metadata)
- (CLLocation *)hv_locationMetadata{
	CLLocation *location = nil;
	NSDictionary *gps = [self objectForKey:(NSString *)kCGImagePropertyGPSDictionary];
	if(gps){
		CLLocationDegrees latitude = [[gps objectForKey:(NSString*)kCGImagePropertyGPSLatitude] floatValue];
		CLLocationDegrees longitude = [[gps objectForKey:(NSString*)kCGImagePropertyGPSLongitude] floatValue];
		location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
	}
	return location;
}
@end
@implementation NSMutableDictionary (HV_UIImage_Metadata)
- (void)hv_setLocationMetadata:(CLLocation *)location{
	if(location){
		NSMutableDictionary *gps = [[NSMutableDictionary alloc] init];
		gps[(NSString*)kCGImagePropertyGPSLatitude] = @(location.coordinate.latitude);
		gps[(NSString*)kCGImagePropertyGPSLongitude] = @(location.coordinate.longitude);
		gps[(NSString*)kCGImagePropertyGPSAltitude] = @(location.altitude);
		[self setObject:gps forKey:(NSString *)kCGImagePropertyGPSDictionary];
	}else{
		[self removeObjectForKey:(NSString *)kCGImagePropertyGPSDictionary];
	}
}
- (void)hv_setImageOrientationMetadataIfNeed:(UIImageOrientation)orientation{
	NSString *key = (NSString *)kCGImagePropertyOrientation;
	if(![self objectForKey:key]){
		NSDictionary *map =
		@{
		  @(UIImageOrientationUp):@(kCGImagePropertyOrientationUp),
		  @(UIImageOrientationUpMirrored):@(kCGImagePropertyOrientationUpMirrored),
		  @(UIImageOrientationDown):@(kCGImagePropertyOrientationDown),
		  @(UIImageOrientationDownMirrored):@(kCGImagePropertyOrientationDownMirrored),
		  @(UIImageOrientationLeft):@(kCGImagePropertyOrientationLeft),
		  @(UIImageOrientationLeftMirrored):@(kCGImagePropertyOrientationLeftMirrored),
		  @(UIImageOrientationRight):@(kCGImagePropertyOrientationRight),
		  @(UIImageOrientationRightMirrored):@(kCGImagePropertyOrientationRightMirrored),
		  };
		CGImagePropertyOrientation cgImageOrientation = (CGImagePropertyOrientation)[[map objectForKey:@(orientation)] integerValue];
		[self setObject:@(cgImageOrientation) forKey:key];
	}
}
@end
@implementation UIImage (HV_UIImage_Metadata)
- (NSDictionary *)hv_imageMetadata{
	NSData *data = [self imageDataThatFitBytes:0 withCompressionQuality:1];
	NSDictionary *metadata = [self.class hv_imageMetadataWithImageData:data];
	return metadata;
}
+ (NSDictionary *)hv_imageMetadataWithImageData:(NSData *)data{
	CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
	CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(source,0,NULL);
	CFRelease(source);
	NSDictionary *metadata = CFBridgingRelease(imageMetaData);
	return metadata;
}
+ (NSData *)hv_setImageMetadata:(NSDictionary *)metadata toImageData:(NSData *)data{
	if(!metadata){
		return data;
	}
	CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
	
	CFStringRef UTI = CGImageSourceGetType(source);
	NSMutableData *newImageData = [NSMutableData data];
	CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)newImageData, UTI, 1, NULL);
	CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef)metadata);
	CGImageDestinationFinalize(destination);
	if(destination){
		CFRelease(destination);
	}
	CFRelease(source);
	return newImageData;
}
+ (NSData *)hv_addImageMetadata:(NSDictionary *)addedMetadata toImageData:(NSData *)data{
	if(!addedMetadata){
		return data;
	}
	CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
	NSMutableDictionary *metadata = [CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source,0,NULL)) mutableCopy];
	[metadata addEntriesFromDictionary:addedMetadata];
	
	CFStringRef UTI = CGImageSourceGetType(source);
	NSMutableData *newImageData = [NSMutableData data];
	CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)newImageData, UTI, 1, NULL);
	CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef)metadata);
	CGImageDestinationFinalize(destination);
	if(destination){
		CFRelease(destination);
	}
	CFRelease(source);
	return newImageData;
}
@end
