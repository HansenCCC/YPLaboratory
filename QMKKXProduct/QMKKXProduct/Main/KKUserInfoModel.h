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
@property (nonatomic, strong) NSString *is_promoter;//是否是推广员 0:不是推广员 1：推广员申请中 2：推广员
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *fans;//粉丝
@property (nonatomic, strong) NSString *focus;//关注
@property (nonatomic, strong) NSString *is_chairman;//是否为会长  // 0 不是  1 是
@property (nonatomic, strong) NSString *phone;//手机号
@property (nonatomic, strong) NSString *level;//等级
@property (nonatomic, strong) NSString *contribution;//贡献值；
@property (nonatomic, strong) NSString *role_type;//角色的类型
@property (nonatomic, strong) NSString *tmp_avatar;//临时的头像
@property (nonatomic, strong) NSString *too_coin;//兔币
@property (nonatomic, strong) NSString *turnip_coin;//萝卜
@property (nonatomic, strong) NSString *updated_at;//更新四件
@property (nonatomic, strong) NSString *is_receive_pet;//1为已领取，0为未领取
@property (nonatomic, strong) NSString *is_hidden_pet;//0 - 弹出机暴龙弹窗 ， 1 - 隐藏机暴龙弹窗
@end
