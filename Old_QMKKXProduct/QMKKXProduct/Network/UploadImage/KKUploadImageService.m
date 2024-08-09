//
//  KKUploadImageService.m
//  Bee
//
//  Created by 程恒盛 on 2019/10/21.
//  Copyright © 2019 南京. All rights reserved.
//

#import "KKUploadImageService.h"

@implementation KKUploadImageService
//上传单张图片
+ (void)uploadWithImage:(UIImage *)image progress:(void(^)(NSProgress *uploadProgress))progress complete:(void(^)(BOOL success, NSString *key))complete{
    NSData *imageData = [UIImage reSizeImageData:image maxSizeWithKB:kDefaultMaxImageSize];
    NSString *last = API_File_UploadOneImage;
    NSString *url = [NSString stringWithFormat:@"%@%@",API_HOST,last];
    NSString *imageKey = [@([NSDate date].timeIntervalSince1970).stringValue addString:@".png"];
    NSDictionary *parameters = @{};
    NSDictionary *headers = @{};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置服务器允许的请求格式内容
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters headers:headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:imageKey mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        KKBaseResponse *response = [KKBaseResponse mj_objectWithKeyValues:json];
        if (complete) {
            NSDictionary *items = response.data;
            if ([items isKindOfClass:[NSDictionary class]]) {
                complete(YES,items[@"url"]);
            }else{
                complete(NO,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complete) {
            complete(NO,nil);
        }
    }];
}
//上传单张图片
+ (void)uploadWithImage:(UIImage *)image complete:(void(^)(BOOL success, NSString *key))complete{
    [self uploadWithImage:image progress:nil complete:complete];
}

/**
 上传多张图片

 @param images 图片
 @param complete 回调
 */
+ (void)uploadWithImages:(NSArray <UIImage *>*)images complete:(void(^)(BOOL success, NSArray <NSString *> *keys))complete{
    NSMutableArray *uploadSuccessImages = [[NSMutableArray alloc] init];
    NSMutableArray *uploadImageKeyArr = [[NSMutableArray alloc] init]; //保存的key值
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < images.count; i++) {
        UIImage *image = images[i];
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            //上传图片
            [self uploadWithImage:image complete:^(BOOL success, NSString *key) {
                if (success) {
                    //上传成功
                    [uploadSuccessImages addObject:image];
                    NSString *image_url = key;
                    [uploadImageKeyArr addObject:image_url];
                }else {
                    //上传失败
                    NSLog(@"==============⚠️⚠️⚠️⚠️⚠️上传失败⚠️⚠️⚠️⚠️⚠️==============");
                }
                dispatch_group_leave(group);
            }];
        });
    }
    //线程同步，
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //图片上传完毕
        if (uploadSuccessImages.count == images.count) {
            //失败（逻辑是只要选中的其中一张上传失败，就报上传失败）
            complete(YES,uploadImageKeyArr);
        }else {
            //图片上传失败
            complete(NO,nil);
        }
    });
}

///**
// 获取七牛token
//
// @param requestModel 请求model
// @param success 成功回调
// @param failure 失败回调
// */
//+ (void)getQiNiuiWithRequestModel:(KKGetQiNiuTokenRequestModel *)requestModel success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure{
//    [KKNetworkBase GET_HOST:API_Public_GetImageToken parameters:requestModel.mj_keyValues success:^(KKBaseResponse *response) {
//        if (success) {
//            success(response);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
////上传多张图片
//+ (void)uploadWithImages:(NSArray <UIImage *>*)images complete:(void(^)(BOOL success, NSArray <NSString *> *keys))complete{
//    NSMutableArray *uploadSuccessImages = [[NSMutableArray alloc] init];
//    NSMutableArray *uploadImageKeyArr = [[NSMutableArray alloc] init]; //保存的key值
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    for (int i = 0; i < images.count; i++) {
//        UIImage *image = images[i];
//        dispatch_group_enter(group);
//        dispatch_async(queue, ^{
//            //上传图片
//            [self uploadWithImage:image complete:^(BOOL success, NSString *key) {
//                if (success) {
//                    //上传成功
//                    [uploadSuccessImages addObject:image];
//                    NSString *image_url = key;
//                    [uploadImageKeyArr addObject:image_url];
//                }else {
//                    //上传失败
//                    NSLog(@"==============⚠️⚠️⚠️⚠️⚠️上传失败⚠️⚠️⚠️⚠️⚠️==============");
//                }
//                dispatch_group_leave(group);
//            }];
//        });
//    }
//    //线程同步，
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        //图片上传完毕
//        if (uploadSuccessImages.count == images.count) {
//            //失败（逻辑是只要选中的其中一张上传失败，就报上传失败）
//            complete(YES,uploadImageKeyArr);
//        }else {
//            //图片上传失败
//            complete(NO,nil);
//        }
//    });
//}
//
////上传单张图片
//+ (void)uploadWithImage:(UIImage *)image complete:(void(^)(BOOL success, NSString *key))complete{
//    KKQiNiuModel *model = [KKUser shareInstance].qnModel;
//    NSString *token = model.qiniu_token;
//    NSString *imageKey = @([NSDate date].timeIntervalSince1970).stringValue;
//    [self uploadWithImage:image qiniuToken:token imageKey:imageKey complete:complete];
//}
////上传单张图片
//+ (void)uploadWithImage:(UIImage *)image qiniuToken:(NSString *)token imageKey:(NSString *)imageKey complete:(void(^)(BOOL success, NSString *key))complete{
//    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
//        builder.timeoutInterval = 30;
//    }];
//    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
//    //限制图片2m内
//    NSData *imageData = [UIImage reSizeImageData:image maxSizeWithKB:kDefaultMaxImageSize];
//    //key 及所有需要输入的字符串必须采用 utf8 编码，如果使用非 utf8 编码访问七牛云存储将反馈错误。
//    WeakSelf
//    [upManager putData:imageData key:imageKey token:token complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        if(info.ok){
//            if (complete) {
//                KKQiNiuModel *model = [KKUser shareInstance].qnModel;
//                key = [model.domain addString:key];
//                complete(YES, key);
//            }
//        }else{
//            if (complete) {
//                complete(NO, key);
//            }
//            //上传失败时，重新请求获取七牛云token
//            [weakSelf qiniuTokenNeedUpdate:^(BOOL success) {
//                if (success) {
//                    [weakSelf uploadWithImage:image qiniuToken:token imageKey:imageKey complete:complete];
//                }
//            }];
//        }
//    } option:nil];
//}
////上传资源文件（视频）
//+ (void)uploadWithAsset:(PHAsset *)asset complete:(void(^)(BOOL success, NSString *key))complete{
//    KKQiNiuModel *model = [KKUser shareInstance].qnModel;
//    NSString *token = model.qiniu_token;
//    NSString *imageKey = @([NSDate date].timeIntervalSince1970).stringValue;
//    [self uploadWithAsset:asset qiniuToken:token dataKey:imageKey complete:complete];
//}
////上传资源文件（视频）
//+ (void)uploadWithAsset:(PHAsset *)asset qiniuToken:(NSString *)token dataKey:(NSString *)assetKey complete:(void(^)(BOOL success, NSString *key))complete{
//    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
//        builder.timeoutInterval = 30;
//    }];
//    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
//    //key 及所有需要输入的字符串必须采用 utf8 编码，如果使用非 utf8 编码访问七牛云存储将反馈错误。
//    WeakSelf
//    [upManager putPHAsset:asset key:assetKey token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        if(info.ok){
//            if (complete) {
//                KKQiNiuModel *model = [KKUser shareInstance].qnModel;
//                key = [model.domain addString:key];
//                complete(YES, key);
//            }
//        }else{
//            if (complete) {
//                complete(NO, key);
//            }
//            //上传失败时，重新请求获取七牛云token
//            [weakSelf qiniuTokenNeedUpdate:^(BOOL success) {
//                if (success) {
//                    [weakSelf uploadWithAsset:asset qiniuToken:token dataKey:assetKey complete:complete];
//                }
//            }];
//        }
//    } option:nil];
//}
//+ (void)qiniuTokenNeedUpdate:(void(^)(BOOL success))complete{
//    //已经登陆状态下，七牛云token失效，需要重新获取七牛云token，进行上传图片操作
//    if ([KKUser shareInstance].isLogin) {
//        KKGetQiNiuTokenRequestModel *model = [[KKGetQiNiuTokenRequestModel alloc] init];
//        model.user_id = [KKUser shareInstance].userModel.user_id?:@"";
//        [KKUploadImageService getQiNiuiWithRequestModel:model success:^(KKBaseResponse *response) {
//            //to do
//            [[KKUser shareInstance].qnModel mj_setKeyValues:response.data];
//            if (complete) {
//                complete(YES);
//            }
//        } failure:^(NSError *error) {
//            //to do
//            //七牛token获取失败，清空登陆信息
//            if (complete) {
//                complete(NO);
//            }
//        }];
//    }
//}
@end
