//
//  KKEmptyDataView.h
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/17.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KKEmptyDataView : UIView
@property (strong, nonatomic) UIImageView *emptyImageView;

//快速init
- (instancetype)initWithImage:(UIImage *)image;

/**
 创建空数据显示view
 */
+ (id)createEmptyDateView;

/**
 创建网络异常view
 */
+ (id)createNetworkFailDateView;
@end


