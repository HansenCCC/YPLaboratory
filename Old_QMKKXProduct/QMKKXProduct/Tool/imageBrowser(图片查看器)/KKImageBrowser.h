//
//  KKImageBrowser.h
//  QMKKXProduct
//
//  Created by Hansen on 6/17/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//
//  运用技术方便
//  1、试图animateWithDuration动画
//  2、试图transform变化
//  3、手势部分
//

#import <UIKit/UIKit.h>
#import "KKImageBrowserCell.h"

@interface KKImageBrowser : UIView
@property (nonatomic, strong) NSArray <KKImageBrowserModel *> *images;
@property (nonatomic, assign) NSInteger index;//当前下标，下标不能大于image.count

//展示
- (void)show;

@end

