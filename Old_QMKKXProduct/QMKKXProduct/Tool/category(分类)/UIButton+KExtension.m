//
//  UIButton+KExtension.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "UIButton+KExtension.h"

@implementation UIButton (KExtension)

+ (instancetype)buttonWithFont:(UIFont *)font textColor:(UIColor *)textColor forState:(UIControlState)state{
    UIButton *button = [[UIButton alloc] init];
    if (textColor) {
        [button setTitleColor:textColor forState:state];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    return button;
}
- (void)kk_setImageWithURL:(NSString *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock{
    [self sd_setImageWithURL:url.toURL forState:state placeholderImage:placeholderImage completed:completedBlock];
}
- (void)kk_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage{
    [self kk_setImageWithURL:url forState:UIControlStateNormal placeholderImage:placeholderImage completed:nil];
}
- (void)kk_setImageWithURL:(NSString *)url{
    [self kk_setImageWithURL:url forState:UIControlStateNormal placeholderImage:nil completed:nil];
}
- (void)kk_setBackgroundImageWithURL:(NSString *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock{
    [self sd_setBackgroundImageWithURL:url.toURL forState:state placeholderImage:placeholderImage completed:completedBlock];
}
- (void)kk_setBackgroundImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage{
    [self kk_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:placeholderImage completed:nil];
}
- (void)kk_setBackgroundImageWithURL:(NSString *)url{
    [self kk_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:nil completed:nil];
}
@end
