//
//  UITextField+KExtension.h
//  QMKKXProduct
//
//  Created by Hansen on 1/8/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITextField (KExtension)

/// 获取光标位置
- (NSRange) selectedRange;

/// 设置光标位置
/// @param range 光标位置
- (void) setSelectedRange:(NSRange) range;

@end

