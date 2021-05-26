//
//  KKPostedIssueRequestModel.h
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KKPostedIssueRequestModel : NSObject
@property (strong, nonatomic) NSArray *imgUrls;//图片地址
@property (strong, nonatomic) NSString *content;//描述详情
@property (strong, nonatomic) NSString *apLatitude;//维度
@property (strong, nonatomic) NSString *apLongitude;//经度
//
@property (strong, nonatomic) NSString *iconUrl;//图片地址
@property (strong, nonatomic) NSString *channelId;//渠道id
@property (strong, nonatomic) NSString *timeStamp;//当前请求时间戳
@property (strong, nonatomic) NSString *token;//登陆状态token
@property (strong, nonatomic) NSString *versionCode;//versionCode

@property (strong, nonatomic) NSString *device;//设备型号
@property (strong, nonatomic) NSString *sys;//系统
@property (strong, nonatomic) NSString *systemName;//系统名称
@property (strong, nonatomic) NSString *dateString;//当前时间
@property (strong, nonatomic) NSString *identification;//唯一标识
@property (strong, nonatomic) NSString *batteryLevel;//电池电量
@property (strong, nonatomic) NSArray *languageInfo;//语言
@end
