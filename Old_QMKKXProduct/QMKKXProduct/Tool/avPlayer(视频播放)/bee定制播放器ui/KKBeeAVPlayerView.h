//
//  KKBeeAVPlayerView.h
//  QMKKXProduct
//  给bee定制一款播放器ui，基于KKAVPlayerView
//  Created by Hansen on 2/18/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKAVPlayerView.h"

@interface KKBeeAVPlayerView : KKAVPlayerView
@property (assign, nonatomic) CGFloat speedProgressThreshold;//进度的阈值，默认为bounds.size.width
@property (assign, nonatomic) CGFloat voiceProgressThreshold;//音量的阈值，默认为self.bounds.size.height/4.0
@property (assign, nonatomic) CGFloat brightnessProgressThreshold;//亮度的阈值，默认为self.bounds.size.height/4.0
@property (assign, nonatomic) BOOL showSetting;//是否操作框，默认NO
@property (assign, nonatomic) BOOL isFullScreen;//当前是否是全屏
@property (strong, nonatomic) NSString *placeholderImage;//未播放时占位图


//是否全屏
- (void)changeScreenFullScreen:(BOOL)fullScreen;
@end
