//
//  KKNetworkPostedService.h
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKPostedIssueRequestModel.h"
#import "KKFindPostedRequestModel.h"

@interface KKNetworkPostedService : NSObject

/// 发帖请求
/// @param requestModel 请求model
/// @param success 成功回调
/// @param failure 失败回调
+ (void)issueWithRequestModel:(KKPostedIssueRequestModel *)requestModel success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure;

/// 获取帖子列表
/// @param requestModel 请求model
/// @param success 成功回调
/// @param failure 失败回调
+ (void)findPostedListWithRequestModel:(KKFindPostedRequestModel *)requestModel success:(void (^)(KKBaseResponse *response))success failure:(void (^)(NSError *error))failure;

@end

