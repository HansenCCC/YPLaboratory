//
//  KKFindPostedRequestModel.m
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKFindPostedRequestModel.h"

@implementation KKFindPostedRequestModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    //@"id":@"new_id"
    return @{};
}
+ (NSDictionary *)mj_objectClassInArray{
    //@"list":@"class",
    return @{};
}
@end


@implementation KKFindPostedResponseModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
        @"postedId":@"id",
    };
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{
        @"value":@"KKPostedIssueRequestModel",
    };
}
@end
