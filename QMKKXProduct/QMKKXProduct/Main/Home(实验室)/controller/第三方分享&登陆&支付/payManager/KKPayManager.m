//
//  KKPayManager.m
//  QMKKXProduct
//
//  Created by Hansen on 6/15/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKPayManager.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface KKPayManager ()<WXApiDelegate>

@end


@implementation KKPayManager
DEF_SINGLETON(KKPayManager);

#pragma mark - 支付宝相关

/// openurl的回调响应
/// @param openUrl url
- (BOOL)aliPayHandleOpenURL:(NSURL *)openUrl{
    //支付跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:openUrl standbyCallback:^(NSDictionary *resultDic) {
        //to do 判断是否支付成功
        NSInteger errCode = [[resultDic objectForKey:@"resultStatus"] integerValue];
        NSError *error;
        if (errCode == 9000) {
            //to do
        }else if(errCode == 6001){
            error =  [NSError errorWithDomain:@"用户取消支付" code:errCode userInfo:nil];
        }else{
            error =  [NSError errorWithDomain:@"支付宝支付失败" code:errCode userInfo:nil];
        }
        //这里可以发送一些通知，来通知支付是否成功
        [[KKUser shareInstance] postNotificationToQMKKXAliPay:error];
    }];
    return YES;
}
//吊起支付宝客户端支付
- (void)aliPayWithModel:(KKAliPayModel *)model complete:(void(^)(BOOL success,id info))complete{
    //开始支付
    NSString *scheme = @"chsqmkkx";
    [[AlipaySDK defaultService] payOrder:model.alipayStr fromScheme:scheme callback:^(NSDictionary *resultDic) {
        NSInteger errCode = [[resultDic objectForKey:@"resultStatus"] integerValue];
        BOOL flag = NO;
        if (errCode == 9000) {
            flag = YES;
        }
        if (complete) {
            complete(flag,resultDic);
        }
    }];
}

#pragma mark - 微信相关
//初始化微信
- (void)weChatRegisterApp{
    //调起微信支付
    NSString *openId = KKWeChatAppID;
    [WXApi registerApp:openId enableMTA:YES];
}
/// openurl的回调响应
/// @param openUrl url
- (BOOL)weChatHandleOpenURL:(NSURL *)openUrl{
    return [WXApi handleOpenURL:openUrl delegate:self];
}
//响应回调
- (void)onResp:(BaseResp *)resp{
    NSString *app_oauto = @"WeChatOauto";
    //如果是oauth授权
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if ([aresp isKindOfClass:[SendAuthResp class]]) {
        if([aresp.state isEqualToString:app_oauto]){
            NSString *code = @"";
            if (aresp.errCode == 0) {
                code = aresp.code;
            }
            //这里可以发送一些通知，来通知获取微信code是否成功
            [[KKUser shareInstance] postNotificationToQMKKXWeChatLogin:code];
            return;
        }else{
            //todo
        }
    }
    //to do 判断是否支付成功
    NSError *error;
    if (resp.errCode == 0) {
        //to do
    }else if (resp.errCode == -2){
        error = [NSError errorWithDomain:@"用户取消支付" code:-2 userInfo:nil];
    }else{
        error =  [NSError errorWithDomain:@"微信支付失败" code:10000000 userInfo:nil];
    }
    //这里可以发送一些通知，来通知支付是否成功
    [[KKUser shareInstance] postNotificationToQMKKXWeChatPay:error];
}
//微信请求回调
- (void)onReq:(BaseReq *)req{
    //to do
}
//吊起微信客户端支付
- (void)weChatPayWithModel:(KKWeChatPayModel *)model complete:(void(^)(BOOL success,id info))complete{
    [self weChatRegisterApp];
    //
    PayReq *req = [[PayReq alloc] init];
    req.partnerId = model.partnerid;
    req.prepayId = model.prepayid;
    req.nonceStr = model.noncestr;
    req.timeStamp = model.timestamp.intValue;
    req.package = model.package;
    req.sign = model.sign;
    BOOL flag = [WXApi sendReq:req];
    if(complete){
        complete(flag,nil);
    }
}
//吊起微信oauth认证
- (void)weChatOauthComplete:(void(^)(BOOL success,id info))complete{
    //微信登录
    [self weChatRegisterApp];
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"WeChatOauto" ;//用于在OnResp中判断是哪个应用向微信发起的授权，这里填写的会在OnResp里面被微信返回
    //第三方向微信终端发送一个SendAuthReq消息结构
    BOOL flag = [WXApi sendReq:req];
    if(complete){
        complete(flag,nil);
    }
}

//吊起微信分享
- (void)weChatShareWithModel:(KKWeChatShareModel *)model complete:(void(^)(BOOL success,id info))complete{
    //微信分享
    [self weChatRegisterApp];
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = model.text;
    if (model.webpageUrl.length > 0) {
        req.bText = NO;
    }else{
        req.bText = YES;
    }
    req.scene = (int)model.sceneType;
    //
    WXMediaMessage *message = [[WXMediaMessage alloc] init];
    message.title = model.text;
    message.description = model.detail;
    NSData *thumbData = model.thumbData;//缩略图
    message.thumbData = thumbData;
    if (model.webpageUrl.length > 0) {
        WXWebpageObject *webObject = [[WXWebpageObject alloc] init];
        webObject.webpageUrl = model.webpageUrl;
        message.mediaObject = webObject;
        req.message = message;
    }
    BOOL flag = [WXApi sendReq:req];
    if(complete){
        complete(flag,nil);
    }
}

//通过接口获取微信openid
- (void)weChatOauthGetOpenIDWithSecret:(NSString *)secret code:(NSString *)code complete:(void(^)(BOOL success,id info))complete{
    NSString *openId = KKWeChatAppID;
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",openId,secret,code];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *openID = dic[@"openid"];
                NSString *unionid = dic[@"unionid"];
                if (openID.length > 0&&unionid.length >0) {
                    if (complete) {
                        complete(YES,dic);
                    }
                }else{
                    if (complete) {
                        complete(NO,dic);
                    }
                }
            }else{
                if (complete) {
                    complete(NO,@"未知错误");
                }
            }
        });
    });
}

@end
