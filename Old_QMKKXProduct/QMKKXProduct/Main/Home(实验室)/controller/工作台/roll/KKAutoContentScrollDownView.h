//
//  KKAutoContentScrollDownView.h
//  QMKKXProduct
//
//  Created by Hansen on 2021/11/10.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKAutoContentScrollDownView : UIView

@property (nonatomic, strong) NSArray <NSString *> *contents;

//开始滚动
- (void)startTimingRun;

@end

NS_ASSUME_NONNULL_END
