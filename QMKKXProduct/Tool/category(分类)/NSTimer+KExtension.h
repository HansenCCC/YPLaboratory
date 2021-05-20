//
//  NSTimer+KExtension.h
//  lwbasic
//
//  Created by 程恒盛 on 2018/5/2.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (KExtension)

//由于+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo; 方法会持有target和userInfo,直到invalidate,这种方式很容易造成循环引用.
/**
 nstimer 使用此block，不会持有aTarget和userInfo

 @param ti      时间间隔
 @param yesOrNo 是否重复
 @param handler 回调block
 @return        定时器
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo handler:(void(^)(NSTimer *timer))handler;
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo handler:(void(^)(NSTimer *timer))handler;
@end
