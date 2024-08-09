//
//  KKNetworkApi.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKNetworkApi.h"

#if QMKKXProductDEV//测试环境
NSString *const API_HOST = @"https://ch.ssswzl.xyz:4466/";//ip地址
NSString *const API_H5HOST = @"https://ch.ssswzl.xyz:4466/";//h5 ip地址
#elif QMKKXProduct//正式环境
NSString *const API_HOST = @"https://ch.ssswzl.xyz:4466/";//ip地址
NSString *const API_H5HOST = @"https://ch.ssswzl.xyz:4466/";//h5 ip地址
#endif

#pragma mark - 文件上传
NSString *const API_File_UploadOneImage = @"file/uploadOneImage";//图片上传

#pragma mark - 发布信息
NSString *const API_Posted_GetJson = @"api/value/getJson";//获取帖子
NSString *const API_Posted_AddJson = @"api/value/addJson";//发布帖子

#pragma mark - html
NSString *const API_HTML_POST = @"post.html";//iOS实验室发帖协议
NSString *const API_HTML_Policy = @"policy.html";//ios实验室隐私协议
