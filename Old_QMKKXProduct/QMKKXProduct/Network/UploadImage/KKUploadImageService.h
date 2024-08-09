//
//  KKUploadImageService.h
//  Bee
//  上传图片
//  Created by 程恒盛 on 2019/10/21.
//  Copyright © 2019 南京. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKUploadImageService : NSObject

/**
 上传单张图片

 @param image 图片
 @param complete 回调
 */
+ (void)uploadWithImage:(UIImage *)image complete:(void(^)(BOOL success, NSString *key))complete;

/**
 上传多张图片

 @param images 图片
 @param complete 回调
 */
+ (void)uploadWithImages:(NSArray <UIImage *>*)images complete:(void(^)(BOOL success, NSArray <NSString *> *keys))complete;



///**
// 获取七牛token
//
// @param requestModel 请求model
// @param success 成功回调
// @param failure 失败回调
// */
//+ (void)getQiNiuiWithRequestModel:(KKGetQiNiuTokenRequestModel *)requestModel success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure;
//
///**
// 上传多张图片
//
// @param images 图片
// @param complete 回调
// */
//+ (void)uploadWithImages:(NSArray <UIImage *>*)images complete:(void(^)(BOOL success, NSArray <NSString *> *keys))complete;
//
///**
// 上传单张图片
//
// @param image 图片
// @param complete 回调
// */
//+ (void)uploadWithImage:(UIImage *)image complete:(void(^)(BOOL success, NSString *key))complete;
//
///**
// 上传资源文件（视频）
//
// @param asset 图片
// @param complete 回调
// */
//+ (void)uploadWithAsset:(PHAsset *)asset complete:(void(^)(BOOL success, NSString *key))complete;

@end
