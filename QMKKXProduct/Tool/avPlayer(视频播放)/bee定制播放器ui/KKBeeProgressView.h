//
//  KKBeeProgressView.h
//  QMKKXProduct
//
//  Created by Hansen on 2/23/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKBeeProgressView : UIView
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIProgressView *progressView;

@property (assign, nonatomic) BOOL isBrightness;//亮度调节Or音量调节
@property (assign, nonatomic) CGFloat progress;

//主动隐藏
- (void)selfHiddenAnimated:(id)sender;
@end

