//
//  KKWeChatMomentsLikeModel.m
//  QMKKXProduct
//
//  Created by Hansen on 1/28/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatMomentsLikeModel.h"

@implementation KKWeChatMomentsLikeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    //@"id":@"new_id"
    return @{};
}
+ (NSDictionary *)mj_objectClassInArray{
    //@"list":@"class",
    return @{};
}
- (instancetype)initWithId:(NSString *)userId userName:(NSString *)userName{
    if (self = [self init]) {
        self.userId = userId;
        self.userName = userName;
    }
    return self;
}
@end
