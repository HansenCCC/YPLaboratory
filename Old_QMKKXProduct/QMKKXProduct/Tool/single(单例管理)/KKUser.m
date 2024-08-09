//
//  KKUser.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKUser.h"
//获取ip
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

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
- (NSString *)channel{
    return @"10000";
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
//发送qmkkx支付宝支付回调
- (void)postNotificationToQMKKXAliPay:(id)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterQMKKXAliPay object:info];
}
//发送qmkkx支付宝支付回调
- (void)postNotificationToQMKKXAliLogin:(id)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterQMKKXAliLogin object:info];
}
//发送qmkkx微信支付回调
- (void)postNotificationToQMKKXWeChatPay:(id)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterQMKKXWeChatPay object:info];
}
//发送qmkkx微信登录回调
- (void)postNotificationToQMKKXWeChatLogin:(id)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterQMKKXWeChatLogin object:info];
}
#pragma mark - config
//获取配置（退出登录和重新登录需要重新请求）
- (void)setupConfig{
    //数据库
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"kk_common.db"];
    KKDatabase *database = [KKDatabase databaseWithPath:dbPath];
    KKDatabaseColumnModel *idModel = [[KKDatabaseColumnModel alloc] initWithName:@"id"];
    idModel.pk = @"1";
    KKDatabaseColumnModel *jsonModel = [[KKDatabaseColumnModel alloc] initWithName:@"json"];
    //创建朋友圈数据库
    [database createTableWithTableName:@"kk_wechat_moments" columnModels:@[idModel,jsonModel]];
    //创建用户行为数据库
    NSString *userActionTable = self.userActionTable;
    [database createTableWithTableName:userActionTable columnModels:@[idModel,jsonModel]];
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
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //'openURL:' is deprecated: first deprecated in iOS 10.0
    return [[UIApplication sharedApplication] openURL:url];
    #pragma clang diagnostic pop
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

#pragma mark - 历史存储相关
- (NSString *)userActionTable{
    return @"kk_qmkkx_user_actions";
}
/// 添加用户行为
/// @param jsonValue json
- (BOOL)savaUserActionWithJson:(NSString *)jsonValue{
    //table
    NSString *tableName = self.userActionTable;
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //db
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"kk_common.db"];
    KKDatabase *database = [KKDatabase databaseWithPath:dbPath];
    //
    BOOL success = [database insertTableWithTableName:tableName contents:@{@"json":jsonValue}];
    return success;
}
#pragma mark - 获取ip
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
- (NSDictionary *)ipAddresses{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
@end
