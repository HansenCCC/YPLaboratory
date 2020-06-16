//
//  KKWeChatPayModel.h
//  QMKKXProduct
//
//  Created by Hansen on 6/15/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

//微信支付model
@interface KKWeChatPayModel : NSObject
@property (strong, nonatomic) NSString *appid;
@property (strong, nonatomic) NSString *noncestr;
@property (strong, nonatomic) NSString *package;
@property (strong, nonatomic) NSString *partnerid;
@property (strong, nonatomic) NSString *prepayid;
@property (strong, nonatomic) NSString *sign;
@property (strong, nonatomic) NSString *timestamp;

@end

typedef enum : NSUInteger {
    KKWeChatShareSessionType = 0,//会话
    KKWeChatShareTimelineType,//朋友圈
    KKWeChatShareFavoriteType,//收藏
    KKWeChatShareSpecifiedSessionType,//指定一个人
} KKWeChatShareType;

/// 微信分享支持以下：图片分享、文字分享、声音分享、视频分享、网页分享
/// 当前model只支持两种分享：文字分享、网页分享
@interface KKWeChatShareModel : NSObject
@property (assign, nonatomic) KKWeChatShareType sceneType;//分享类型
@property (strong, nonatomic) NSString *text;//一级标题
@property (strong, nonatomic) NSString *detail;//二级标题
@property (strong, nonatomic) NSData *thumbData;
@property (strong, nonatomic) NSString *webpageUrl;//网站url

@end
