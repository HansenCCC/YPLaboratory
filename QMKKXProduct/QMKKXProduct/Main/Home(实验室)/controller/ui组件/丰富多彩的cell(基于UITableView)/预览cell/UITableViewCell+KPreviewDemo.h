//
//  UITableViewCell+KPreviewDemo.h
//  QMKKXProduct
//
//  Created by Hansen on 2/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (KPreviewDemo)

/// 预览cell
/// @param indexPath indexpath
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

/// 获取预览cell 高度
/// @param indexPath indexpath
+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath;

@end

