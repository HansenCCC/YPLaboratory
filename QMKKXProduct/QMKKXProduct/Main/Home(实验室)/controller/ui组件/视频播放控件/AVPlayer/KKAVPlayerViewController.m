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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基于AVPlayer自定义UI";
    [self.view addSubview:self.player];
    //
    NSURL *url = [NSURL URLWithString:@"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"];
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
