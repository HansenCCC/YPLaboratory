//
//  KKAppIconImageView.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/24.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "KKAppIconImageView.h"

@interface KKAppIconImageView ()
@property (strong, nonatomic) UIImageView *appIconView;
@property (strong, nonatomic) UILabel *bataLabel;
@property (nonatomic, strong) UIView *bateBackgroundView;
@end

@implementation KKAppIconImageView
- (instancetype)init{
    if (self = [super init]) {
        self.appIconView = [[UIImageView alloc] init];
        [self addSubview:self.appIconView];
        
        self.bateBackgroundView = [[UIView alloc] init];
        [self addSubview:self.bateBackgroundView];
        
        self.bataLabel = [[UILabel alloc] init];
        self.bataLabel.numberOfLines = 0;
        self.bataLabel.font = [UIFont systemFontOfSize:100.f];
        self.bataLabel.adjustsFontSizeToFitWidth = YES;
        self.bataLabel.textAlignment = NSTextAlignmentCenter;
        [self.bateBackgroundView addSubview:self.bataLabel];
        
        self.bounds = CGRectMake(0, 0, 512.f, 512.f);
    }
    return self;
}
- (void)setImage:(UIImage *)image{
    _image = image;
    self.appIconView.image = image;
}
- (void)setText:(NSString *)text{
    _text = text;
    self.bataLabel.text = text;
}
- (void)setTextBackgroundColor:(UIColor *)textBackgroundColor{
    _textBackgroundColor = textBackgroundColor;
    self.bateBackgroundView.backgroundColor = textBackgroundColor;
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.bataLabel.textColor = textColor;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.appIconView.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size.height = bounds.size.height/5.0f;
    f2.origin.y = bounds.size.height - f2.size.height;
    self.bateBackgroundView.frame = f2;
//    self.bateBackgroundView.transform = CGAffineTransformRotate(self.bateBackgroundView.transform, -M_PI_4);
    
    //
    CGRect f3 = bounds;
    f3.size.width = f2.size.width - 2*f2.size.height;
    f3.size.height = f2.size.height;
    f3.origin.x = (bounds.size.width - f3.size.width)/2;
    self.bataLabel.frame = f3;
}
- (id)initWithImage:(UIImage *)image text:(NSString *)text{
    if(self=[self init]){
        self.image = image;
        self.text = text;
        [self reloadData];
    }
    return self;
}
- (void)reloadData{
    self.appIconView.image = self.image;
    self.bataLabel.text = self.text;
    [self setNeedsLayout];
}
+ (UIImage *)imageWithImage:(UIImage *)image text:(NSString *)text textColor:(UIColor *)textColor textBackgroundColor:(UIColor *)textBackgroundColor{
    KKAppIconImageView *view = [[KKAppIconImageView alloc] initWithImage:image text:text];
    view.textColor = textColor;
    view.textBackgroundColor = textBackgroundColor;
    UIImage *img = [view screenshotsImageWithScale:1];
    return img;
}
@end
