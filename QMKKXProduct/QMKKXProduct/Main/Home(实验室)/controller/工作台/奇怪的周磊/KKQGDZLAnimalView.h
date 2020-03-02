//
//  KKQGDZLAnimalView.h
//  QMKKXProduct
//
//  Created by Hansen on 2/26/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKQGDZLAnimalView : UIView
@property (assign, nonatomic) CGFloat xProgress;//进度
@property (assign, nonatomic) CGFloat yProgress;//进度

/// 通过左边进度获取左边高度坐标
/// @param progress 进度
- (CGPoint)xPointForProgress:(CGFloat)progress;

/// 通过右边边进度获取右边高度坐标
/// @param progress 进度
- (CGPoint)yPointForProgress:(CGFloat)progress;
@end


