//
//  UIImageView+KExtension.m
//  KExtension
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "UIImageView+KExtension.h"
#import "UIImage+KExtension.h"
#import "NSString+KExtension.h"

@implementation UIImageView (KExtension)
- (CGSize)sizeThatFitsToMaxSize:(CGSize)size{
    if (self.image) {
        CGSize resize = [self.image sizeWithMaxRelativeSize:size];
        if (resize.width > self.image.size.width) {
            return self.image.size;
        }
        return resize;
    }
    return [super sizeThatFitsToMaxSize:size];
}

/**
 设置image
 
 @param urlString 图片url
 @param placeholderImage 占位图
 @param completedBlock 回调
 */
- (void)kk_setImageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage
                 completed:(SDExternalCompletionBlock)completedBlock{
    [self sd_setImageWithURL:urlString.toURL placeholderImage:placeholderImage completed:completedBlock];
}
- (void)kk_setImageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage{
    [self kk_setImageWithUrl:urlString placeholderImage:placeholderImage completed:nil];
}
- (void)kk_setImageWithUrl:(NSString *)urlString{
    [self kk_setImageWithUrl:urlString placeholderImage:nil completed:nil];
}
@end
