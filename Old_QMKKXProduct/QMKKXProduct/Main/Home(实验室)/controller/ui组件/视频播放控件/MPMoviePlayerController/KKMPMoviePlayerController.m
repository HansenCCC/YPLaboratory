//
//  KKMPMoviePlayerController.m
//  QMKKXProduct
//
//  Created by Hansen on 5/5/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKMPMoviePlayerController.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//is deprecated: first deprecated in iOS 9.0 - Use AVPlayerViewController in AVKit.

@interface KKMPMoviePlayerController ()
@property (strong, nonatomic) MPMoviePlayerController *movePlayer;//iOS9中被弃用（不推荐）

@end

@implementation KKMPMoviePlayerController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MPMoviePlayerController(iOS 13已弃用)";
    [self setupSubviews];
}
- (void)setupSubviews{
    if (@available(iOS 13.0, *)) {
        [self showError:@"MPMoviePlayerController(iOS 13已弃用)\n *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'MPMoviePlayerController is no longer available. Use AVPlayerViewController in AVKit.'"];
    } else {
        // Fallback on earlier versions
        NSString *url = @"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4";
        self.movePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url.toURL];
        self.movePlayer.controlStyle = MPMovieControlStyleFullscreen;//全屏
        [self.view addSubview:self.movePlayer.view];
    }
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.movePlayer.view.frame = bounds;
}
@end
#pragma clang diagnostic pop
