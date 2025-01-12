//
//  YPPageRouterModule+Network.h
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPPageRouterModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPPageRouterModule (Network)

// 网络
+ (NSArray *)NetworkRouters;

// 网络请求
+ (NSArray *)NetworkRouters_Request;

// 请求头
+ (NSArray *)NetworkRouters_Request_Headers;

// 请求体
+ (NSArray *)NetworkRouters_Request_Body;

@end

NS_ASSUME_NONNULL_END
