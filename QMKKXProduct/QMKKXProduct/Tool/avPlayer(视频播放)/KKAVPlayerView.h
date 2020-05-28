//
//  KKAVPlayerView.h
//  QMKKXProduct
//
//  Created by Hansen on 2/18/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKAVPlayerView;
typedef void(^KKAVPlayerViewObserveBlock)(KKAVPlayerView *view);

@interface KKAVPlayerView : UIView
@property (readonly, nonatomic) AVPlayer *avPlayer;//视频播放管理
@property (readonly, nonatomic) AVPlayerLayer *avPlayerLayer;//成像视图
@property (readonly, nonatomic) UIView *contentView;//内容视图
@property (readonly, nonatomic) BOOL isPlaying;//是否正在播放
@property (readonly, nonatomic) BOOL isBuffer;//是否正在缓冲
@property (readonly, nonatomic) BOOL isPausing;//是否正在暂停
@property (readonly, nonatomic) NSError *error;//播放失败的原因
@property (readonly, nonatomic) BOOL needAgainSetupAVPlayer;//需要重新创建AVplayer

@property (strong, nonatomic) NSURL *playerItemUrl;//设置视频播放地址
@property (copy,   nonatomic) KKAVPlayerViewObserveBlock stateChange;//检测视频错误
@property (copy,   nonatomic) KKAVPlayerViewObserveBlock timeControlStatusChange;//播放状态改变回调
@property (copy,   nonatomic) KKAVPlayerViewObserveBlock whenEndOfPlay;//播放结束回调
@property (assign, nonatomic) CGFloat voiceSize;//设置声音大小 0-1
@property (assign, nonatomic) CGFloat brightnessSize;//设置亮度大小 0-1
@property (assign, nonatomic) CGFloat progress;//设置进度 0-1

//更新ui
- (void)updateProgressIfNeeded;
//监听currentTime发生变化
- (void)videoTimeJumped;
//视频结束播放回调
- (void)videoDidPlayToEndTime;
//监听未能播放到其结束时间就中断时
- (void)videoFailedToPlayToEndTime;

//开始播放
- (void)play;
//重新开始播放
- (void)replay;
//暂停播放
- (void)pause;
@end
