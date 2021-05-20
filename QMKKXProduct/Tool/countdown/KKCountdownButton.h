//
//  KKCountdownButton.h
//  PlayMusic
//  倒计时view
//  Created by 程恒盛 on 2019/9/19.
//  Copyright © 2019 lwgzs. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KKCountdownButtonMaxCount 10

@interface KKCountdownButton : UIView
@property (assign, nonatomic) NSInteger countDown;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIButton *countdownBtn;
@property (copy  , nonatomic) void(^whenSendResponse)(KKCountdownButton *view);//发送响应
@property (copy  , nonatomic) void(^whenUpdateBlock)(NSInteger count);//倒计时回调

- (void)sendVerificationCode;//发送验证码
@end

