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
static NSString *kNSUserDefaultsStartImg = @"kNSUserDefaultsStartImg";//启动图片信息
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
- (NSString *)platform{
    return @"2";
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
//设置启动图片
- (void)setStartImg:(NSString *)startImg{
    [[NSUserDefaults standardUserDefaults] setObject:startImg?:@"" forKey:kNSUserDefaultsStartImg];
}
//获取启动图片
- (NSString *)startImg{
    NSString *startImg = [[NSUserDefaults standardUserDefaults] objectForKey:kNSUserDefaultsStartImg];
    return startImg;
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
//发送退出登录通知
- (void)postNotificationToLogout{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterLogout object:nil];
}
//发送注册成功通知
- (void)postNotificationToDidRegister{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterDidRegister object:nil];
}
//发送注册失败通知
- (void)postNotificationToFailedRegister{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterFailedRegister object:nil];
}
//发送资料修改通知
- (void)postNotificationToUserInfoUpdate{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterUserInfoUpdate object:nil];
}
//发送qmkkx唤起授权界面
- (void)postNotificationToQMKKXAuthLogin:(NSString *)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterQMKKXAuthLogin object:info];
}
#pragma mark - config
//获取配置（退出登录和重新登录需要重新请求）
- (void)setupConfig{
    //to do
}

#pragma mark - webPush
//present webview
- (void)presentWebViewContoller:(UIViewController *)selfVC url:(NSString *)urlString complete:(void(^)(BOOL refresh))complete{
    NSString *url = urlString;
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    KKUIWebViewController *vc = [[KKUIWebViewController alloc] init];
    KKNavigationController *nav = [[KKNavigationController alloc] initWithRootViewController:vc];
    vc.requestURL = url.toURL;
    vc.whenComplete = complete;
    [selfVC presentViewController:nav animated:YES completion:nil];
}
//present webview
- (void)presentWebViewContoller:(UIViewController *)selfVC title:(NSString *)title url:(NSString *)urlString complete:(void(^)(BOOL refresh))complete{
    NSString *url = urlString;
    //    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    KKUIWebViewController *vc = [[KKUIWebViewController alloc] init];
    KKNavigationController *nav = [[KKNavigationController alloc] initWithRootViewController:vc];
    vc.requestURL = url.toURL;
    vc.title = title;
    vc.whenComplete = complete;
    [selfVC presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 超链接打开操作
//打开地址
- (BOOL)openURL:(NSURL*)url{
    return [[UIApplication sharedApplication] openURL:url];
}
//是否能打开
- (BOOL)canOpenURL:(NSURL *)url{
    return [[UIApplication sharedApplication] canOpenURL:url];
}
//打开这款游戏 SenTL+pid 例如 SenTL1382
- (BOOL)openGameByGameId:(NSString*)gameId{
    NSString *string = [NSString stringWithFormat:@"qmkkx%@://",gameId];
    return [self openURL:string.toURL];
}
//是否安装这款游戏
- (BOOL)canOpenGameByGameid:(NSString *)gameId{
    NSString *string = [NSString stringWithFormat:@"qmkkx%@://",gameId];
    return [self canOpenURL:string.toURL];
}
@end
