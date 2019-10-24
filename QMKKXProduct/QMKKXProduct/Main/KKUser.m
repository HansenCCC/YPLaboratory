//
//  KKUser.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKUser.h"

static KKUser *_user = nil;
static NSString *kNSUserDefaultsUserInfoModel = @"kNSUserDefaultsUserInfoModel";//登录信息
@interface KKUser ()
@property (strong, nonatomic) NSString *version;//version
@property (strong, nonatomic) KKUserInfoModel *userModel;//用户登录信息
@end

@implementation KKUser
#pragma mark - init
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[KKUser alloc] init];
    });
    return _user;
}
#pragma mark - lazy load
- (NSString *)version{
    if (!_version) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        _version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    return _version;
}
- (NSString *)appType{
    return @"1";
}
- (NSString *)iosType{
    return @"1";
}
- (BOOL)isLogin{
    return self.userModel.isLogin;
}
- (NSString *)token{
    return self.userModel.token?:@"";
}
- (KKUserInfoModel *)userModel{
    if (!_userModel) {
        _userModel = [[KKUserInfoModel alloc] init];
        NSString *jsonString = [[NSUserDefaults standardUserDefaults] objectForKey:kNSUserDefaultsUserInfoModel];
        [_userModel mj_setKeyValues:jsonString];
    }
    return _userModel;
}
- (void)saveUserModel{
    NSString *jsonString = self.userModel.mj_JSONString;
    [[NSUserDefaults standardUserDefaults] setObject:jsonString?:@"" forKey:kNSUserDefaultsUserInfoModel];
}
- (void)cleanUserModel{
    self.userModel = [[KKUserInfoModel alloc] init];
    [self saveUserModel];
}
#pragma mark - 通知栏
//发送登录通知
- (void)postNotificationToLogging{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterLogging object:nil];
}
//发送登录成功通知
- (void)postNotificationToDidLogin{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterDidLogin object:nil];
}
//发送登录失败通知
- (void)postNotificationToFailedLogin{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterFailedLogin object:nil];
}
//发送注册成功通知
- (void)postNotificationToDidRegister{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterDidRegister object:nil];
}
//发送注册失败通知
- (void)postNotificationToFailedRegister{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterFailedRegister object:nil];
}
@end
