//
//  KKBeeAVPlayerView.m
//  QMKKXProduct
//
//  Created by Hansen on 2/18/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKBeeAVPlayerView.h"
#import "KKBeeSlider.h"
#import <MediaPlayer/MediaPlayer.h>
#import "KKBeeProgressView.h"


typedef NS_ENUM(NSInteger,KKBeeAVPlayerViewChangeType) {
    KKBeeAVPlayerViewChangeUnknownType,//未知
    KKBeeAVPlayerViewChangeProgressType,//进度
    KKBeeAVPlayerViewChangeVoiceType,//声音
    KKBeeAVPlayerViewChangeBrightnessType,//亮度
};

@interface KKBeeAVPlayerView ()
@property (strong, nonatomic) UIButton *backButton;//返回按钮
@property (strong, nonatomic) UIButton *playButton;//播放按钮
@property (strong, nonatomic) UIButton *fullScreenButton;//全屏按钮
@property (strong, nonatomic) UILabel *beginLabel;//显示开始时间
@property (strong, nonatomic) UILabel *endLabel;//显示结束时间
@property (strong, nonatomic) KKBeeSlider *slider;//显示进度
@property (strong, nonatomic) UIView *bottomView;//底部控制view
@property (strong, nonatomic) KKBeeProgressView *progressView;//进度条
@property (strong, nonatomic) UIImageView *placeholderImageView;//占位图
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@property (assign, nonatomic) BOOL isTouchUpInside;//是否正在修改进度 default NO

@property (assign, nonatomic) CGPoint beginPoint;//开始点
@property (assign, nonatomic) CGFloat beginProgress;//开始进度
@property (assign, nonatomic) CGFloat beginVoice;//开始声音
@property (assign, nonatomic) CGFloat beginBrightness;//开始亮度
@property (assign, nonatomic) KKBeeAVPlayerViewChangeType changeType;//修改类型

@property (  weak, nonatomic) UIView *parentView;//原父视图
@property (assign, nonatomic) CGRect originFrame;//原尺寸大小
@end

@implementation KKBeeAVPlayerView
- (instancetype)init{
    if (self = [super init]) {
        //默认NO
        self.isFullScreen = NO;
        self.showSetting = NO;
        self.isTouchUpInside = NO;
        self.speedProgressThreshold = kScreenW;//进度的阈值，默认为bounds.size.width
        self.voiceProgressThreshold = kScreenH/4.0;//音量的阈值，默认为self.bounds.size.height/4.0
        self.brightnessProgressThreshold = kScreenH/4.0;//亮度的阈值，默认为self.bounds.size.height/4.0
        self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.changeType = KKBeeAVPlayerViewChangeUnknownType;
        [self setupSubviews];//构造视图
        [self addGestureRecognizer];//添加手势
    }
    return self;
}
- (void)setPlaceholderImage:(NSString *)placeholderImage{
    _placeholderImage = placeholderImage;
    [self.placeholderImageView kk_setImageWithUrl:placeholderImage];
}
- (void)setupSubviews{
    //
    self.placeholderImageView = [[UIImageView alloc] init];
    self.placeholderImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.placeholderImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.placeholderImageView];
    //
    self.bottomView = [[UIView alloc] init];
    self.bottomView.userInteractionEnabled = YES;
    self.bottomView.alpha = 0;
    [self addSubview:self.bottomView];
    //
    self.backButton = [[UIButton alloc] init];
    self.backButton.hidden = YES;
    [self.backButton addTarget:self action:@selector(whenBackAction:) forControlEvents:UIControlEventTouchUpInside];
    //默认状态显示播放
    [self.backButton setImage:UIImageWithName(@"kk_bee_videoBack") forState:UIControlStateNormal];
    [self.contentView addSubview:self.backButton];
    //
    self.playButton = [[UIButton alloc] init];
    self.playButton.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6];
    //默认状态显示播放
    [self.playButton setImage:UIImageWithName(@"kk_bee_play") forState:UIControlStateNormal];
    [self.playButton setImage:UIImageWithName(@"kk_bee_pause") forState:UIControlStateSelected];
    [self.playButton addTarget:self action:@selector(whenPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.playButton];
    //
    self.fullScreenButton = [[UIButton alloc] init];
    //默认状态显示全屏
    [self.fullScreenButton setImage:UIImageWithName(@"kk_bee_fullScreen") forState:UIControlStateNormal];
    [self.fullScreenButton setImage:UIImageWithName(@"kk_bee_unFullScreen") forState:UIControlStateSelected];
    [self.fullScreenButton addTarget:self action:@selector(whenFullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.fullScreenButton];
    //
    self.beginLabel = [[UILabel alloc] init];
    self.beginLabel.textColor = KKColor_FFFFFF;
    self.beginLabel.textAlignment = NSTextAlignmentLeft;
    self.beginLabel.text = @"00:00";
    [self.bottomView addSubview:self.beginLabel];
    //
    self.endLabel = [[UILabel alloc] init];
    self.endLabel.textColor = KKColor_FFFFFF;
    self.endLabel.textAlignment = NSTextAlignmentRight;
    self.endLabel.text = @"00:00";
    [self.bottomView addSubview:self.endLabel];
    //
    self.slider = [[KKBeeSlider alloc] init];
    [self.slider setThumbImage:[UIImage imageNamed:@"kk_bee_progressPoint"] forState:UIControlStateNormal];
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    self.slider.minimumTrackTintColor = KKColor_0091FF;
    self.slider.maximumTrackTintColor = KKColor_FFFFFF;
    //结束拖动
    [self.slider addTarget:self action:@selector(sliderEventTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    //开始拖动
    [self.slider addTarget:self action:@selector(sliderEventTouchDown:) forControlEvents:UIControlEventTouchDown];
    //拖动中
    [self.slider addTarget:self action:@selector(sliderEventValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.bottomView addSubview:self.slider];
    //
    self.progressView = [[KKBeeProgressView alloc] init];
    [self addSubview:self.progressView];
}
//结束拖动
- (void)sliderEventTouchUpInside:(UISlider *)slider{
    NSLog(@"sliderEventTouchUpInside");
    self.isTouchUpInside = NO;
    CGFloat value = slider.value;
    NSTimeInterval durationTime = CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    NSTimeInterval currentTime = durationTime * value;
    // 播放移动到当前播放时间
    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
//开始拖动
- (void)sliderEventTouchDown:(UISlider *)slider{
    NSLog(@"sliderEventTouchDown");
    self.isTouchUpInside = YES;
}
//拖动中
- (void)sliderEventValueChanged:(UISlider *)slider{
    NSLog(@"sliderEventValueChanged");
    //刷新时间
    CGFloat value = slider.value;
    NSTimeInterval durationTime = CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    NSTimeInterval currentTime = durationTime * value;
    self.beginLabel.text = [self timeToStringWithTimeInterval:currentTime];
    self.endLabel.text = [self timeToStringWithTimeInterval:durationTime];
    //拖动时，不隐藏设置栏
    self.showSetting = YES;
    // 播放移动到当前播放时间
    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
#pragma mark - action
//更新进度
- (void)updateProgressIfNeeded{
    [super updateProgressIfNeeded];
    NSTimeInterval currentTime = CMTimeGetSeconds(self.avPlayer.currentTime);
    NSTimeInterval durationTime = CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    if (self.isPlaying == NO&&self.progress == 0.f) {
        self.placeholderImageView.hidden = NO;
    }else{
        self.placeholderImageView.hidden = YES;
    }
    if (self.isTouchUpInside) {
        //正在拖动精度条，不更新进度
        return;
    }
    if (currentTime < 0) {
        currentTime = 0;
    }
    if (durationTime == 0) {
        self.slider.value = 0;
    }else{
        self.slider.value = currentTime/durationTime;
    }
    self.beginLabel.text = [self timeToStringWithTimeInterval:currentTime];
    self.endLabel.text = [self timeToStringWithTimeInterval:durationTime];
}
//监听currentTime发生变化
- (void)videoTimeJumped{
    [super videoTimeJumped];
    [self updateProgressIfNeeded];
}
//视频结束播放
- (void)videoDidPlayToEndTime{
    [super videoDidPlayToEndTime];
    //播放结束重置视频
    CGFloat value = 0.f;
    NSTimeInterval durationTime = CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    NSTimeInterval currentTime = durationTime * value;
    // 播放移动到当前播放时间
    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}
//监听未能播放到其结束时间就中断时
- (void)videoFailedToPlayToEndTime{
    [super videoFailedToPlayToEndTime];
}
- (void)play{
    self.playButton.selected = YES;
    self.showSetting = YES;
    [super play];
}
- (void)pause{
    self.playButton.selected = NO;
    self.showSetting = YES;
    [super pause];
}
//点击播放|暂停按钮
- (void)whenPlayAction:(id)sender{
    //AVPlayerTimeControlStatusPaused = 0,//控件状态正在暂停
    //AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate = 1,//控件状态等待以指定速率播放
    //AVPlayerTimeControlStatusPlaying = 2//控件状态正在播放
    if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused) {
        //暂停->播放
        [self play];
    }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate) {
        //to do
        NSLog(@"控件状态等待以指定速率播放1");
        AVPlayerItem *item = self.avPlayer.currentItem;
        NSLog(@"%@",item.error);
        if (item.error) {
            self.playButton.selected = NO;
            [self.topViewController showError:item.error.description];
        }
    }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
        //播放->暂停
        [self pause];
    }
}
//点击全屏|缩小按钮
- (void)whenFullScreenAction:(id)sender{
    if (self.isFullScreen == NO) {
        //竖屏->右横屏
        self.fullScreenButton.selected = YES;
        self.backButton.hidden = NO;
        [self addHandlePanGestureRecognizer];
    }else{
        //横屏->竖屏
        self.fullScreenButton.selected = NO;
        self.backButton.hidden = YES;
        [self removeHandlePanGestureRecognizer];
    }
    [self changeScreenFullScreen:!self.isFullScreen];
}
//是否全屏
- (void)changeScreenFullScreen:(BOOL)fullScreen{
    self.isFullScreen = fullScreen;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:0.3f animations:^{
        if (fullScreen) {
            //是全屏
            [self removeFromSuperview];
            [window addSubview:self];
            self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }else{
            self.transform  = CGAffineTransformIdentity;
            self.frame = self.originFrame;
            [self removeFromSuperview];
            [self.parentView addSubview:self];
        }
    }];
}
//点击返回按钮
- (void)whenBackAction:(id)sender{
    //点击返回，缩小全屏模式
    [self whenFullScreenAction:self.fullScreenButton];
}
#pragma mark - do
//秒转分秒  61 -> 01:01
-(NSString *)timeToStringWithTimeInterval:(NSTimeInterval)interval{
    if(isnan(interval)){
        interval = 0;
    }
    NSInteger Min = interval / 60;
    NSInteger Sec = (NSInteger)interval % 60;
    NSString *intervalString = [NSString stringWithFormat:@"%02ld:%02ld",Min,Sec];
    return intervalString;
}
//监听播放状态，播放中允许旋转屏幕
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    //
    if (object == self.avPlayer && [keyPath isEqualToString:@"timeControlStatus"]) {
        if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused) {
            //暂停
            self.playButton.selected = NO;
        }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate) {
            //to do
            NSLog(@"控件状态等待以指定速率播放2");
            AVPlayerItem *item = self.avPlayer.currentItem;
            NSLog(@"%@",item.error);
            if (item.error) {
                self.playButton.selected = NO;
                [self.topViewController showError:item.error.description];
            }
        }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
            //播放
            self.playButton.selected = YES;
        }
    }else if(object == self.avPlayer && [keyPath isEqualToString:@"status"]) {
        //AVPlayerStatusUnknown = 0,
        //AVPlayerStatusReadyToPlay = 1,
        //AVPlayerStatusFailed = 2
        if (self.avPlayer.status == AVPlayerStatusUnknown) {
            //未知
        }else if (self.avPlayer.status == AVPlayerStatusReadyToPlay) {
            //准备播放
        }else if (self.avPlayer.status == AVPlayerStatusFailed) {
            //失败
            AVPlayerItem *playerItem = self.avPlayer.currentItem;
            NSLog(@"%@",playerItem.error);
        }
    }
}
#pragma mark - 手势部分
- (void)addGestureRecognizer{
    //单击
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.numberOfTouchesRequired  = 1;
    [self.contentView addGestureRecognizer:singleTapGesture];
    //双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 1;
    [self.contentView addGestureRecognizer:doubleTapGesture];
    //只有当doubleTapGesture识别失败的时候(即识别出这不是双击操作)，singleTapGesture才能开始识别
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
}
//横屏时，添加手势
- (void)addHandlePanGestureRecognizer{
    //添加右滑手势 -> 进度+
    if (self.panGestureRecognizer == nil) {
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        self.panGestureRecognizer = panGestureRecognizer;
        [self.contentView addGestureRecognizer:panGestureRecognizer];
    }
}
//竖屏时，移除手势
- (void)removeHandlePanGestureRecognizer{
    if(self.panGestureRecognizer){
        [self.contentView removeGestureRecognizer:self.panGestureRecognizer];
        self.panGestureRecognizer = nil;
    }
}
//单击
-(void)handleSingleTap:(UIGestureRecognizer *)sender{
    //to do
    self.showSetting = !self.showSetting;
}
//双击
-(void)handleDoubleTap:(UIGestureRecognizer *)sender{
    //双击全屏或者小屏幕
    [self whenFullScreenAction:self.fullScreenButton];
}
- (void)handlePanFrom:(UIPanGestureRecognizer *)sender{
    //to do
    CGPoint point = [sender locationInView:self];// 上下控制点
    CGPoint tranPoint = [sender translationInView:self];//差值
    CGFloat changeThreshold = AdaptedWidth(8.f);//设置阈值
    if (sender.state == UIGestureRecognizerStateBegan) {
        //开始
        self.beginPoint = point;
        self.beginProgress = self.slider.value;//获取当前播放进度
        self.beginVoice = self.voiceSize;//获取当前声音
        self.beginBrightness = self.brightnessSize;//获取当前亮度
    }else if (sender.state == UIGestureRecognizerStateChanged){
        if (self.changeType == KKBeeAVPlayerViewChangeUnknownType) {
            //未知类型
            //达到修改条件，确定修改内容
            if (fabs(tranPoint.x) > changeThreshold||fabs(tranPoint.y) > changeThreshold) {
                if (fabs(tranPoint.x) > fabs(tranPoint.y)) {
                    //左右滑动，切换进度
                    self.changeType = KKBeeAVPlayerViewChangeProgressType;
                    [self sliderEventTouchDown:self.slider];
                }else{
                    //上下滑动，切换屏幕亮度|声音大小
                    if (self.beginPoint.x < self.bounds.size.width/2.0f) {
                        //左边修改屏幕亮度
                        self.changeType = KKBeeAVPlayerViewChangeBrightnessType;
                    }else{
                        //右边修改声音大小
                        self.changeType = KKBeeAVPlayerViewChangeVoiceType;
                    }
                }
            }
        }else if (self.changeType == KKBeeAVPlayerViewChangeProgressType) {
            //正在修改进度
            //左右滑动，切换进度
            CGFloat threshold = self.speedProgressThreshold;
            CGFloat value = tranPoint.x / threshold;
            NSLog(@"进度+:%f",value);
            self.slider.value = self.beginProgress + value;
            [self sliderEventValueChanged:self.slider];
        }else if (self.changeType == KKBeeAVPlayerViewChangeVoiceType) {
            //正在修改声音
            CGFloat threshold = self.voiceProgressThreshold;
            CGFloat value = - (tranPoint.y / threshold);
            NSLog(@"声音+:%f",value);
            self.voiceSize = self.beginVoice + value;
        }else if (self.changeType == KKBeeAVPlayerViewChangeBrightnessType) {
            //正在修改亮度
            CGFloat threshold = self.brightnessProgressThreshold;
            CGFloat value = - (tranPoint.y / threshold);
            NSLog(@"亮度+:%f",value);
            self.brightnessSize = self.beginBrightness + value;
        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
        //结束
        if (self.changeType == KKBeeAVPlayerViewChangeUnknownType) {
            //未知类型
        }else if (self.changeType == KKBeeAVPlayerViewChangeProgressType) {
            //正在修改进度
            //左右滑动，结束切换进度
            [self sliderEventTouchUpInside:self.slider];
        }else if (self.changeType == KKBeeAVPlayerViewChangeVoiceType) {
            //正在修改声音
        }else if (self.changeType == KKBeeAVPlayerViewChangeBrightnessType) {
            //正在修改亮度
        }
        self.changeType = KKBeeAVPlayerViewChangeUnknownType;
        self.beginPoint = CGPointZero;
    }else if (sender.state == UIGestureRecognizerStateCancelled){
        //取消
        self.beginPoint = CGPointZero;
    }else if (sender.state == UIGestureRecognizerStateFailed){
        //失败
        self.beginPoint = CGPointZero;
    }else if (sender.state == UIGestureRecognizerStateRecognized){
        //识别器已接收到被识别为手势的触摸。操作方法将在下一轮运行循环中调用，识别器将重置为UIGestureRecognizerStatePossible
        self.beginPoint = CGPointZero;
    }else if (sender.state == UIGestureRecognizerStatePossible){
        //识别器尚未识别其手势，但可能正在评估触摸事件。这是默认状态
        self.beginPoint = CGPointZero;
    }
}
#pragma mark - 显示bottom设置页面
- (void)setShowSetting:(BOOL)showSetting{
    if (_showSetting == showSetting) {
        if(showSetting){
            //点击显示时，重新开始计时隐藏
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [self performSelector:@selector(whenAfterHiddenSetting:) withObject:nil afterDelay:5.f];
        }else{
            //点击隐藏式，取消计时隐藏
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
        }
        return;
    }
    _showSetting = showSetting;
    if (showSetting) {
        //显示操作框
        WeakSelf
        [UIView animateWithDuration:0.2 animations:^{
            self.playButton.alpha = 1.0f;
            self.bottomView.alpha = 1.0f;
            self.backButton.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [weakSelf performSelector:@selector(whenAfterHiddenSetting:) withObject:nil afterDelay:5.f];
        }];
    }else{
        //取消计时隐藏
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        //隐藏操作框
        [UIView animateWithDuration:0.2 animations:^{
            if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPaused) {
                //暂停状态下，
                self.playButton.alpha = 1.f;
            }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate) {
                //to do
                NSLog(@"控件状态等待以指定速率播放4");
            }else if (self.avPlayer.timeControlStatus == AVPlayerTimeControlStatusPlaying) {
                //播放状态下，隐藏播放按钮
                self.playButton.alpha = 0.f;
            }
            self.bottomView.alpha = 0.f;
            self.backButton.alpha = 0.f;
            [self.progressView selfHiddenAnimated:nil];
        } completion:^(BOOL finished) {
            //to do
        }];
    }
}
- (void)whenAfterHiddenSetting:(id)sender{
    self.showSetting = NO;
}
#pragma mark - 关于控制音量
//更改系统的音量
- (void)setVoiceSize:(CGFloat)voiceSize{
    //越小幅度越小0-1之间的数值
    [super setVoiceSize:voiceSize];
    self.progressView.isBrightness = NO;
    self.progressView.progress = voiceSize;
}
#pragma mark - 关于控制亮度
- (void)setBrightnessSize:(CGFloat)brightnessSize{
    [super setBrightnessSize:brightnessSize];
    self.progressView.isBrightness = YES;
    self.progressView.progress = brightnessSize;
}
#pragma mark - dealloc
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - layout
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect fm = bounds;
    fm.size.height = AdaptedWidth(40.f);
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = [[[[UIApplication sharedApplication] delegate] window] safeAreaInsets];
    } else {
        // Fallback on earlier versions
    }
    if (self.isFullScreen == NO) {
        //竖屏
        fm.origin.y = bounds.size.height - fm.size.height;
    }else{
        //横屏
        fm.origin.y = bounds.size.height - fm.size.height - safeAreaInsets.bottom;
    }
    self.bottomView.frame = fm;
    //
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(10.f);
    f1.origin.y = AdaptedWidth(5.f);
    f1.size = CGSizeMake(AdaptedWidth(30.f), AdaptedWidth(30.f));
    self.backButton.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = CGSizeMake(AdaptedWidth(60.f), AdaptedWidth(60.f));
    f2.origin.x = (bounds.size.width - f2.size.width)/2.0;
    f2.origin.y = (bounds.size.height - f2.size.height)/2.0;
    self.playButton.frame = f2;
    self.playButton.layer.cornerRadius = f2.size.height/2.0f;
    //
    CGRect f3 = bounds;
    f3.size = [self.beginLabel sizeThatFits:CGSizeZero];
    f3.size.width = f3.size.width + AdaptedWidth(5.f);
    f3.origin.x = AdaptedWidth(15.f);
    f3.origin.y = fm.size.height - AdaptedWidth(10.f) - f3.size.height;
    self.beginLabel.frame = f3;
    //
    CGRect f4 = bounds;
    f4.size = CGSizeMake(AdaptedWidth(24.f), AdaptedWidth(24.f));
    f4.origin.x = bounds.size.width - AdaptedWidth(15.f) - f4.size.width;
    f4.origin.y = CGRectGetMidY(f3) - f4.size.height/2.0;
    self.fullScreenButton.frame = f4;
    //
    CGRect f5 = bounds;
    f5.size = [self.endLabel sizeThatFits:CGSizeZero];
    f5.size.width = f5.size.width + AdaptedWidth(5.f);
    f5.origin.x = f4.origin.x - AdaptedWidth(15.f) - f5.size.width;
    f5.origin.y = f3.origin.y;
    self.endLabel.frame = f5;
    //
    CGRect f6 = bounds;
    f6.origin.x = CGRectGetMaxX(f3) + AdaptedWidth(5);
    f6.size = [self.slider sizeThatFits:CGSizeZero];
    f6.size.height = f6.size.height * 2.0f;
    f6.size.width = f5.origin.x - AdaptedWidth(5) - f6.origin.x;
    f6.origin.y = CGRectGetMidY(f3) - f6.size.height/2.0;
    self.slider.frame = f6;
    //
    CGRect f7 = bounds;
    f7.size = CGSizeMake(AdaptedWidth(240.f), AdaptedWidth(70.f));
    f7.origin.x = (bounds.size.width - f7.size.width)/2.0f;
    f7.origin.y = (bounds.size.height - f7.size.height)/2.0f;
    self.progressView.frame = f7;
    if (self.isFullScreen) {
        //to do
    }else{
        //to do
        self.parentView = self.superview;
        self.originFrame = self.frame;
    }
    self.placeholderImageView.frame = bounds;
}
@end
