//
//  KKCountdownButton.m
//  PlayMusic
//
//  Created by 程恒盛 on 2019/9/19.
//  Copyright © 2019 lwgzs. All rights reserved.
//

#import "KKCountdownButton.h"

@implementation KKCountdownButton
- (instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}
//添加子试图
- (void)setupSubviews{
    self.countdownBtn = [[UIButton alloc] init];
    [self.countdownBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.countdownBtn setTitleColor:KKColor_FD445F forState:UIControlStateNormal];
    self.countdownBtn.titleLabel.font = AdaptedFontSize(12.f);
    self.countdownBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.countdownBtn addTarget:self action:@selector(whenClickAciton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.countdownBtn];
    //
    WeakSelf
    self.countDown = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES handler:^(NSTimer *timer) {
        [weakSelf countDownUpdateView];
    }];
    [self stopCountDown];
}
- (void)whenClickAciton{
    if (self.whenSendResponse) {
        self.whenSendResponse(self);
    }
}
//发送验证码
- (void)sendVerificationCode{
    self.countDown = KKCountdownButtonMaxCount;
    [self starCountdown];
}
//开始
- (void)starCountdown{
    //
    [self.timer setFireDate:[NSDate date]];
}
//结束
- (void)stopCountDown{
    //
    [self.timer setFireDate:[NSDate distantFuture]];
}
//更新试图
- (void)countDownUpdateView{
    self.countDown --;
    if (self.countDown <= 0) {
        [self stopCountDown];
        self.countdownBtn.userInteractionEnabled = YES;
        [self.countdownBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.countdownBtn setTitleColor:KKColor_FD445F forState:UIControlStateNormal];
        return;
    }
    self.countdownBtn.userInteractionEnabled = NO;
    [self.countdownBtn setTitle:[NSString stringWithFormat:@"已发送 %lds",(long)self.countDown] forState:UIControlStateNormal];
    [self.countdownBtn setTitleColor:KKColor_BBBBBB forState:UIControlStateNormal];
    if (self.whenUpdateBlock) {
        self.whenUpdateBlock(self.countDown);
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.countdownBtn.frame = self.bounds;
}
- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
@end
