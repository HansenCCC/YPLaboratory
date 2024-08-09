//
//  KKMuteDetector.h
//  FanRabbit
//  检测静音键开关
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKMuteDetector : NSObject

/**
 标准初始化
 */
+ (KKMuteDetector*)sharedDetecotr;


/**
 检测静音键是否关闭  ismute YES=关闭  NO=开启

 @param completionHandler 回调
 */
- (void)detectComplete:(void (^)(BOOL isMute))completionHandler;

@end


