//
//  AppDelegate+KKThird.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/27.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "AppDelegate+KKThird.h"
#import <AVOSCloud/AVOSCloud.h>

#define AVOSCloudApplicationId @"5XSpHqbdhVi1OUzPnbhcrxX3-gzGzoHsz"
#define AVOSCloudClientKey @"c3TRcYsDk7rgx233GCvM417y"

@implementation AppDelegate (KKThird)

//cleanCloud SDK初始化
- (void)setupAVOSCloud{
    [AVOSCloud setApplicationId:AVOSCloudApplicationId clientKey:AVOSCloudClientKey];
}
@end
