//
//  UIImageView+KExtension.h
//  KExtension
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+KExtension.h"
#import <SDWebImage/SDWebImageManager.h>
@interface UIImageView (KExtension)
/**
 设置image
 
 @param urlString 图片url
 @param placeholderImage 占位图
 @param completedBlock 回调
 */
- (void)kk_setImageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage
                 completed:(SDExternalCompletionBlock)completedBlock;
- (void)kk_setImageWithUrl:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;
- (void)kk_setImageWithUrl:(NSString *)urlString;
@end
