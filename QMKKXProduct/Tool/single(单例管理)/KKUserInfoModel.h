//
//  KKUserInfoModel.h
//  Bee
//
//  Created by 程恒盛 on 2019/10/17.
//  Copyright © 2019 南京猫玩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKUserInfoModel : NSObject
@property (nonatomic, assign) BOOL isLogin;//判断是否登录

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *center_id;
@property (nonatomic, strong) NSString *avatar;//用户头像
@property (nonatomic, strong) NSString *username;//用户姓名
@property (nonatomic, strong) NSString *status;//用户状态 1：正常 2： 禁用
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *fans;//粉丝
@property (nonatomic, strong) NSString *focus;//关注
@property (nonatomic, strong) NSString *phone;//手机号
@property (nonatomic, strong) NSString *level;//等级
@property (nonatomic, strong) NSString *updated_at;//


#pragma mark - 辅助字段
//App制作icon
@property (nonatomic, strong) NSString *iconFilePath;//icon本地路径地址
@property (nonatomic, strong) NSString *betaString;//beta
@property (nonatomic, strong) NSString *betaColor;//betaColor
@property (nonatomic, strong) NSString *betaBackgroundColor;//betaBackgroundColor
@end
