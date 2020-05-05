//
//  KKAVPlayerViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 2/18/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKAVPlayerViewController.h"
#import "KKBeeAVPlayerView.h"

@interface KKAVPlayerViewController ()
@property (strong, nonatomic) KKBeeAVPlayerView *player;//视频播放管理

@end

@implementation KKAVPlayerViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //试图即将消失 -> 暂停播放
    if(self.player.isPlaying){
        [self.player pause];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"AVPlayer";
    [self.view addSubview:self.player];
    [self updateDatas];
}
- (void)updateDatas{
    //占位图
    self.player.placeholderImage = @"https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3023045797,2628106807&fm=26&gp=0.jpg";
    //视频
    /*
     1、https://media.w3.org/2010/05/sintel/trailer.mp4
     2、http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4
     3、https://img.qumeng666.com/be8da24a2de0d75014d3e9e2803f47d0.mp4?v=233825
     */
    NSString *value = @"https://img.qumeng666.com/be8da24a2de0d75014d3e9e2803f47d0.mp4?v=233825";
    NSURL *url = [NSURL URLWithString:value];
    self.player.playerItemUrl = url;
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.size.height = f1.size.width/2.0;
    f1.origin.y = SafeAreaTopHeight;
    if (self.player.isFullScreen) {
        self.player.frame = bounds;
    }else{
        self.player.frame = f1;
    }
}
#pragma mark - lazy load
- (KKBeeAVPlayerView *)player{
    if (!_player) {
        _player = [[KKBeeAVPlayerView alloc] init];
    }
    return _player;
}
@end
