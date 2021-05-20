//
//  KKAppIconImageView.h
//  lwlab
//  appicon bata 画板
//  Created by 程恒盛 on 2018/4/24.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKAppIconImageView : UIView
@property (readonly, nonatomic) UIImageView *appIconView;
@property (readonly, nonatomic) UILabel *bataLabel;
//
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong) UIColor *textBackgroundColor;


//init
- (id)initWithImage:(UIImage *)image text:(NSString *)text;
+ (UIImage *)imageWithImage:(UIImage *)image text:(NSString *)text textColor:(UIColor *)textColor textBackgroundColor:(UIColor *)textBackgroundColor;
@end
