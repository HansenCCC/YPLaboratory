//
//  KKNetworkApi.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKNetworkApi.h"

#if QMKKXProductDEV//测试环境
NSString *const API_HOST = @"http://api.t.mitoo.cn/";//ip地址
#elif QMKKXProduct//正式环境
NSString *const API_HOST = @"http://api.mitoo.cn/";//ip地址
#endif
