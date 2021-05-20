//
//  KKBeeProgressView.m
//  QMKKXProduct
//
//  Created by Hansen on 2/23/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKBeeProgressView.h"

@implementation KKBeeProgressView
- (instancetype)init{
    if (self = [super init]) {
        [self setupSubviews];
        self.alpha = 0;
        _progress = 0.f;
        self.isBrightness = YES;
        self.userInteractionEnabled = NO;
    }
    return self;
}
- (void)setupSubviews{
    //
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self  addSubview:self.contentView];
    //
    self.leftButton = [[UIButton alloc] init];
    [self.leftButton setImage:UIImageWithName(@"kk_bee_volume") forState:UIControlStateNormal];
    [self.leftButton setImage:UIImageWithName(@"kk_bee_volume") forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    //
    self.rightButton = [[UIButton alloc] init];
    self.rightButton.titleLabel.font = AdaptedFontSize(14.f);
    [self addSubview:self.rightButton];
    //
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.trackTintColor = KKColor_FFFFFF;
    self.progressView.progressTintColor = KKColor_0091FF;
    self.progressView.progress = 0.5;
    [self addSubview:self.progressView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    //
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(22.5f);
    f1.size = CGSizeMake(AdaptedWidth(30.f), AdaptedWidth(30.f));
    f1.origin.y = (bounds.size.height - f1.size.height)/2.0f;
    self.leftButton.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = [self.rightButton sizeThatFits:CGSizeZero];
    f2.origin.y = (bounds.size.height - f2.size.height)/2.0f;
    f2.origin.x = bounds.size.width - f2.size.width - f1.origin.x;
    self.rightButton.frame = f2;
    //
    CGRect f3 = bounds;
    f3.size = [self.progressView sizeThatFits:CGSizeZero];
    f3.origin.x = CGRectGetMaxX(f1) + AdaptedWidth(15.f);
    f3.origin.y = (bounds.size.height - f3.size.height)/2.0f;
    f3.size.width = f2.origin.x - f3.origin.x - AdaptedWidth(15.f);
    self.progressView.frame = f3;
    //
    CGRect f4 = bounds;
    self.contentView.layer.cornerRadius = AdaptedWidth(8.f);
    self.contentView.frame = f4;
}
- (void)setIsBrightness:(BOOL)isBrightness{
    _isBrightness = isBrightness;
    UIImage *image;
    if (isBrightness) {
        image = UIImageWithName(@"kk_bee_brightness");
    }else{
        image = UIImageWithName(@"kk_bee_volume");
    }
    [self.leftButton setImage:image forState:UIControlStateNormal];
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    self.progressView.progress = progress;
    if (progress > 1) {
        progress = 1.f;;
    }else if(progress < 0){
        progress = 0.f;
    }
    NSString *title = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    self.alpha = 1.0f;
    [self layoutIfNeeded];
    [self setNeedsLayout];
    //2.0s自动隐藏
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(selfHiddenAnimated:) withObject:self afterDelay:2.f];
}
- (void)selfHiddenAnimated:(id)sender{
    //2.0s自动隐藏
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //to do
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(selfHiddenAnimated:) object:nil];
    }];
}
@end
