//
//  KKWeChatMomentsCommentModel.m
//  QMKKXProduct
//
//  Created by Hansen on 1/28/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatMomentsCommentModel.h"

@implementation KKWeChatMomentsCommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    //@"id":@"new_id"
    return @{};
}
+ (NSDictionary *)mj_objectClassInArray{
    //@"list":@"class",
    return @{};
}
- (instancetype)initWithId:(NSString *)userId userName:(NSString *)userName content:(NSString *)content{
    if (self = [self init]) {
        self.content = content;
        self.userName = userName;
        self.userId = userId;
    }
    return self;
}
@end
