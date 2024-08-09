//
//  KKNetworkPostedService.m
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKNetworkPostedService.h"

@implementation KKNetworkPostedService

/// 发帖请求
/// @param requestModel 请求model
/// @param success 成功回调
/// @param failure 失败回调
+ (void)issueWithRequestModel:(KKPostedIssueRequestModel *)requestModel success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure{
    NSDictionary *param = @{@"value":requestModel.mj_JSONString,@"application/x-www-form-urlencoded":@"YES"};
    [KKNetworkBase POST_HOST:API_Posted_AddJson parameters:param success:^(KKBaseResponse *response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/// 获取帖子列表
/// @param requestModel 请求model
/// @param success 成功回调
/// @param failure 失败回调
+ (void)findPostedListWithRequestModel:(KKFindPostedRequestModel *)requestModel success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure{
    [KKNetworkBase GET_HOST:API_Posted_GetJson parameters:requestModel.mj_keyValues success:^(KKBaseResponse *response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
