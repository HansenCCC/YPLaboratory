//
//  KKInputToolBar.m
//  CHHomeDec
//
//  Created by 程恒盛 on 2019/3/27.
//  Copyright © 2019 Herson. All rights reserved.
//

#import "KKInputToolBar.h"

@implementation KKInputToolBar
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = KKColor_DDE7F0;
        //
        self.cancelBtn = [self setupButton:@"取消"];
        self.cancelBtn.tag = 0;
        [self addSubview:self.cancelBtn];
        //
        self.sureBtn = [self setupButton:@"确定"];
        self.sureBtn.tag = 1;
        [self addSubview:self.sureBtn];
    }
    return self;
}
- (KKUIFlowLayoutButton *)setupButton:(NSString *)title{
    KKUIFlowLayoutButton *btn = [[KKUIFlowLayoutButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = AdaptedFontSize(16.f);
    [btn setTitleColor:KKColor_000000 forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)clickButton:(UIButton *)sender{
    if (self.whenClickBlock) {
        self.whenClickBlock(sender.tag);
    }
}
- (CGSize)sizeThatFits:(CGSize)size{
    size = [super sizeThatFits:size];
    size.height = kToolBarHeight;
    return size;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.size = [self.cancelBtn sizeThatFitsToMaxSize:CGSizeZero];
    f1.size.height = bounds.size.height;
    f1.size.width = f1.size.width + AdaptedWidth(10.f);
    f1.origin.x = kLeft;
    f1.origin.y = (bounds.size.height - f1.size.height)/2;
    self.cancelBtn.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size = [self.sureBtn sizeThatFitsToMaxSize:CGSizeZero];
    f2.size.height = bounds.size.height;
    f2.size.width = f2.size.width + AdaptedWidth(10.f);
    f2.origin.x = bounds.size.width - kLeft - f1.size.width;
    f2.origin.y = (bounds.size.height - f2.size.height)/2;
    self.sureBtn.frame = f2;
}
@end
