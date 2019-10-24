//
//  NSTimer+KExtension.m
//  lwbasic
//
//  Created by 程恒盛 on 2018/5/2.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "NSTimer+KExtension.h"

@interface __LWNSTimerHandler : NSObject
@property(nonatomic,copy) void(^whenTimer)(NSTimer *timer);
- (void)onTimer:(NSTimer *)timer;
@end
@implementation __LWNSTimerHandler
- (void)onTimer:(NSTimer *)timer{
    if (self.whenTimer) {
        self.whenTimer(timer);
    }
}
@end

@implementation NSTimer (KExtension)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo handler:(void(^)(NSTimer *timer))handler{
    __LWNSTimerHandler *timerHandler = [[__LWNSTimerHandler alloc] init];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:timerHandler selector:@selector(onTimer:) userInfo:userInfo repeats:yesOrNo];
    timerHandler.whenTimer = handler;
    return timer;
}
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo handler:(void(^)(NSTimer *timer))handler{
    return [self scheduledTimerWithTimeInterval:ti userInfo:nil repeats:yesOrNo handler:handler];
}
@end
