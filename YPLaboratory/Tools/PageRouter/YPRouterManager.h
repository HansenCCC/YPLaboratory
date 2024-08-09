//
//  YPRouterManager.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/20.
//

#import <Foundation/Foundation.h>
#import "YPPageRouterModule.h"
#import "YPPageRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPRouterManager : NSObject

@property (nonatomic, readonly) YPPageRouter *homeRouter;

+ (instancetype)shareInstance;

/// 通过 Model 获取列表
/// - Parameter model: model
- (NSArray <YPPageRouterModule *>*)getRoutersByModel:(YPPageRouter *)model;

@end

NS_ASSUME_NONNULL_END
