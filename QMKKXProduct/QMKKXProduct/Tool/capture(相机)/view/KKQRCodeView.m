//
//  KKQRCodeView.m
//  自定义相机
//
//  Created by 力王 on 16/11/28.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "KKQRCodeView.h"

@interface KKQRCodeView ()
@property(nonatomic, strong) UIView *maskView;//contentView
@property(nonatomic, strong) UIImageView *scanLineView;//绿色色条
@property(nonatomic, strong) UIImageView *scanBGView;

@end

@implementation KKQRCodeView
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        //
        self.maskView  = [[UIView alloc] init];
        self.maskView.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.3];
        [self addSubview:self.maskView];
        //
        self.scanLineView = [[UIImageView alloc] init];
        self.scanLineView.image = UIImageWithName(@"KKCameraScanLine");
        [self addSubview:self.scanLineView];
        //
        self.scanBGView = [[UIImageView alloc] initWithImage:UIImageWithName(@"KKCameraScanscanBg")];
        [self addSubview:self.scanBGView];
        //
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self reloadFrame];
        });
    }
    return self;
}
-(void)reloadFrame{
    CGRect f1 = self.maskViewFrame;
    f1.size.height = self.scanLineView.frame.size.height;
    //
    CGRect f2 = f1;
    f2.origin.y = f1.origin.y + self.maskViewFrame.size.height - f1.size.height;
    //
    WeakSelf
    [UIView animateWithDuration:1.5 animations:^{
        CGFloat orif1 = [[NSString stringWithFormat:@"%.2f",self.scanLineView.frame.origin.y] floatValue];
        CGFloat orif2 = [[NSString stringWithFormat:@"%.2f",self.maskViewFrame.origin.y] floatValue];
        weakSelf.scanLineView.frame = orif1 == orif2?f2:f1;
    } completion:^(BOOL finished) {
        [weakSelf reloadFrame];
    }];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //
    CGRect bounds = self.bounds;
    self.maskView.frame = bounds;
    self.scanBGView.frame = self.maskViewFrame;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //
    CGRect f1 = self.maskViewFrame;
    UIBezierPath *aPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [aPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:f1 cornerRadius:1] bezierPathByReversingPath]];
    //
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = aPath.CGPath;
    self.maskView.layer.mask = maskLayer;
    //
    CGRect f2 = f1;
    CGSize s1 = self.scanLineView.image.size;
    f2.origin.y = (rect.size.height - f1.size.height)/2.0;
    f2.size.height = s1.height/s1.width * f2.size.width;
    self.scanLineView.frame = f2;
}
@end
