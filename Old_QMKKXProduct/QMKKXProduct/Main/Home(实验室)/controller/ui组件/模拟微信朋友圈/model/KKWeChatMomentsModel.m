//
//  KKWeChatMomentsModel.m
//  QMKKXProduct
//
//  Created by Hansen on 1/27/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatMomentsModel.h"

@implementation KKWeChatMomentsModel
//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    return @{@"":@""};
//}
+ (NSDictionary *)mj_objectClassInArray{
    return @{
        @"likes":@"KKWeChatMomentsLikeModel",
        @"comments":@"KKWeChatMomentsCommentModel",
    };
}
@end
