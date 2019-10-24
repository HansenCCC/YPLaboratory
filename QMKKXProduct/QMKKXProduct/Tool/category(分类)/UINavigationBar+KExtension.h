//
//  UINavigationBar+KExtension.h
//  KExtension
//
//  Created by Herson on 17/2/8.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (KExtension)

/**
 导航背景View，修改导航栏颜色
 */
@property(nonatomic, readonly) UIView *barBackground;//背景View

/**
 设置UINavigationBar是否通明
 
 @param transparency 是否通明
 */
- (void)setNavigationBarTransparency:(BOOL)transparency;
@end
