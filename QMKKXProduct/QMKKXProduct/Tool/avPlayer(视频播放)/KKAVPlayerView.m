//
//  KKAVPlayerView.m
//  QMKKXProduct
//
//  Created by Hansen on 2/18/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKAVPlayerView.h"

@interface KKAVPlayerView ()
@property (strong, nonatomic) AVPlayerItem *avPlayerItem;//播放源
@property (strong, nonatomic) AVPlayer *avPlayer;//视频播放管理
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;//成像视图
@property (strong, nonatomic) UIView *contentView;//内容视图

@property (strong, nonatomic) NSTimer *timer;//监听进度

@end

@implementation KKAVPlayerView
- (instancetype)init{
    if (self = [super init]) {
        //默认竖屏
        _orientationMask = UIInterfaceOrientationMaskPortrait;
        [self setupSubViews];
        [self addTimer];
        [self addObserver];
        [self addNotification];
        [self setConfig];
    }
    return self;
}
- (void)setConfig{
    //使用此类别的应用在手机的静音按钮打开时不会静音，但在手机静音时播放声音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionAllowBluetooth error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
}
- (void)addNotification{
    //监听currentTime发生变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoTimeJumped) name:AVPlayerItemTimeJumpedNotification object:nil];
    //监听未能播放到其结束时间就中断时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFailedToPlayToEndTime) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    //监听视频播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidPlayToEndTime) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)addObserver{
    //监听timeControlStatus
    [self.avPlayer addObserver:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionNew context:nil];
    [self.avPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)addTimer{
    //timer
    WeakSelf
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES handler:^(NSTimer *timer) {
        [weakSelf updateProgressIfNeeded];
    }];
    //设置ui不被干扰
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer setFireDate:[NSDate date]];
}
- (void)setupSubViews{
    //to do
    [self.layer addSublayer:self.avPlayerLayer];
    self.contentView = [[UIView alloc] init];
    [self addSubview:self.contentView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.avPlayerLayer.frame = f1;
    self.contentView.frame = f1;
}
- (void)dealloc{
    if (self.avPlayer) {
        [self.avPlayer removeObserver:self forKeyPath:@"timeControlStatus"];
        [self.avPlayer removeObserver:self forKeyPath:@"status"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - lazy load
- (AVPlayer *)avPlayer{
    if (!_avPlayer) {
        _avPlayer = [[AVPlayer alloc] init];
    }
    return _avPlayer;
}
- (AVPlayerLayer *)avPlayerLayer{
    if (!_avPlayerLayer) {
        _avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
        //AVLayerVideoGravityResizeAspect
        //AVLayerVideoGravityResizeAspectFill
        //AVLayerVideoGravityResize
        _avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    }
    return _avPlayerLayer;
}
#pragma mark - aciton
- (void)setPlayerItemUrl:(NSURL *)playerItemUrl{
    _playerItemUrl = playerItemUrl;
    self.avPlayerItem = [AVPlayerItem playerItemWithURL:playerItemUrl];
    [self.avPlayer replaceCurrentItemWithPlayerItem:self.avPlayerItem];
}
//开始播放
- (void)play{
    if (self.avPlayerItem) {
        [self.avPlayer play];
    }
}
//重新开始播放
- (void)replay{
    if (self.avPlayerItem) {
        //设置开始时间为0
        NSTimeInterval currentTime = 0.f;
        [self.avPlayer seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
        [self.avPlayer play];
    }
}
//暂停
- (void)pause{
    if (self.avPlayerItem) {
        [self.avPlayer pause];
    }
}
//更新进度
- (void)updateProgressIfNeeded{
    
}
//监听currentTime发生变化
- (void)videoTimeJumped{
    NSLog(@"监听currentTime发生变化");
}
//视频结束播放
- (void)videoDidPlayToEndTime{
    if (self.whenEndOfPlay) {
        self.whenEndOfPlay(self);
    }
}
//监听未能播放到其结束时间就中断时
- (void)videoFailedToPlayToEndTime{
    NSLog(@"监听未能播放到其结束时间就中断时");
}
//监听播放状态，播放中允许旋转屏幕
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //to do
    if ([keyPath isEqualToString:@"timeControlStatus"]) {
        if (self.timeControlStatusChange) {
            self.timeControlStatusChange(self);
        }
        if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused) {
            //暂停
            NSLog(@"暂停");
        }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate) {
            //to do
            NSLog(@"控件状态等待以指定速率播放");
        }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
            //播放
            NSLog(@"播放");
        }
    }else if([keyPath isEqualToString:@"status"]) {
        if (self.stateChange) {
            self.stateChange(self);
        }
        if (self.avPlayer.status == AVPlayerStatusUnknown) {
            //未知
            NSLog(@"未知类型");
        }else if (self.avPlayer.status == AVPlayerStatusReadyToPlay) {
            //准备播放
            NSLog(@"准备播放");
        }else if (self.avPlayer.status == AVPlayerStatusFailed) {
            //失败
            NSLog(@"播放失败");
        }
    }
}
#pragma mark - get
- (BOOL)isPlaying{
    BOOL flag = NO;
    if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused) {
        //暂停
        flag = NO;
    }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate) {
        //to do
        flag = NO;
    }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
        //播放
        flag = YES;
    }
    return flag;
}
- (NSError *)error{
    return self.avPlayerItem.error;
}
@end

/*
 //强制修改屏幕朝向
 - (void)setOrientationMask:(UIInterfaceOrientationMask)orientationMask{
     _orientationMask = orientationMask;
     UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
     if (orientationMask == UIInterfaceOrientationMaskPortrait) {
         NSLog(@"向上");
         orientation = UIInterfaceOrientationPortrait;
     }else if (orientationMask == UIInterfaceOrientationMaskLandscapeLeft){
         NSLog(@"向左");
         orientation = UIInterfaceOrientationLandscapeRight;
     }else if (orientationMask == UIInterfaceOrientationMaskLandscapeRight){
         NSLog(@"向右");
         orientation = UIInterfaceOrientationLandscapeLeft;
     }else if (orientationMask == UIInterfaceOrientationMaskPortraitUpsideDown){
         NSLog(@"向下");
         orientation = UIInterfaceOrientationPortraitUpsideDown;
     }else{
         NSLog(@"其他方向");
         orientation = UIInterfaceOrientationUnknown;
     }
     //第一种强制改变屏幕方向
     NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
     [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
     NSNumber *orientationTarget = [NSNumber numberWithInt:(int)orientation];
     [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
     //第二种强制改变屏幕方向(效果不是很好)
 //    UIInterfaceOrientationMask val = orientationMask;
 //    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
 //        SEL selector = NSSelectorFromString(@"setOrientation:");
 //        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
 //        [invocation setSelector:selector];
 //        [invocation setTarget:[UIDevice currentDevice]];
 //        [invocation setArgument:&val atIndex:2];
 //        [invocation invoke];
 //    }
 }
 */
