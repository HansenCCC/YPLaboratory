//
//  KKUserInfoModel.m
//  Bee
//
//  Created by 程恒盛 on 2019/10/17.
//  Copyright © 2019 南京猫玩. All rights reserved.
//

#import "KKUserInfoModel.h"

@implementation KKUserInfoModel
-(BOOL)isLogin{
    if (self.token.length > 0) {
        return YES;
    }else{
        return NO;
    }
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userId":@"id",
             };
}
@end
