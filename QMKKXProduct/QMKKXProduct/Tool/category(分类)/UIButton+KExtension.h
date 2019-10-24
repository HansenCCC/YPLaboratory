//
//  UIButton+KExtension.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/20.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImageManager.h>

@interface UIButton (KExtension)


/**
 快速创建button
 
 @param font 字体大小
 @param textColor 字体颜色
 @param state 状态
 @return button
 */
+ (instancetype)buttonWithFont:(UIFont *)font textColor:(UIColor *)textColor forState:(UIControlState)state;

/**
 设置image
 
 @param url 图片url
 @param state 状态
 @param placeholderImage 占位图
 @param completedBlock 回调
 */
- (void)kk_setImageWithURL:(NSString *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock;
- (void)kk_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage;
- (void)kk_setImageWithURL:(NSString *)url;

/**
 设置image
 
 @param url 图片url
 @param state 状态
 @param placeholderImage 占位图
 @param completedBlock 回调
 */
- (void)kk_setBackgroundImageWithURL:(NSString *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock;
- (void)kk_setBackgroundImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage;
- (void)kk_setBackgroundImageWithURL:(NSString *)url;
@end

