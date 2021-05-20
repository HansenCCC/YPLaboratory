//
//  KKMuteDetector.m
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKMuteDetector.h"

typedef void (^DetectCompleteBlock)(BOOL isMute);
@interface KKMuteDetector()
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) SystemSoundID soundId;
@property (nonatomic,   copy) DetectCompleteBlock completeBlock;

@end

@implementation KKMuteDetector
void KKSoundMuteNotificationCompletionProc(SystemSoundID  ssID,void* clientData){
    NSTimeInterval elapsed = [NSDate timeIntervalSinceReferenceDate] - [KKMuteDetector sharedDetecotr].interval;
    BOOL isMute = elapsed < 0.1;
    [KKMuteDetector sharedDetecotr].completeBlock(isMute);
}
+ (KKMuteDetector*)sharedDetecotr{
    static KKMuteDetector* sharedDetecotr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDetecotr = [KKMuteDetector new];
        NSURL* url = [[NSBundle bundleForClass:[self class]] URLForResource:@"EBMuteDetector" withExtension:@"mp3"];
        if (AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &sharedDetecotr->_soundId) == kAudioServicesNoError){
            AudioServicesAddSystemSoundCompletion(sharedDetecotr.soundId, CFRunLoopGetMain(), kCFRunLoopDefaultMode, KKSoundMuteNotificationCompletionProc,(__bridge void *)(self));
            UInt32 yes = 1;
            AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(sharedDetecotr.soundId),&sharedDetecotr->_soundId,sizeof(yes), &yes);
        } else {
            sharedDetecotr.soundId = -1;
        }
    });
    return sharedDetecotr;
}
- (void)detectComplete:(void (^)(BOOL isMute))completionHandler{
    self.interval = [NSDate timeIntervalSinceReferenceDate];
    AudioServicesPlaySystemSound(self.soundId);
    self.completeBlock = completionHandler;
}
- (void)dealloc{
    if (self.soundId != -1){
        AudioServicesRemoveSystemSoundCompletion(self.soundId);
        AudioServicesDisposeSystemSoundID(self.soundId);
    }
}
@end
