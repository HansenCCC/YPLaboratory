//
//  UITableViewCell+YPPreviewDemo.h
//  YPLaboratory
//
//  Created by Hansen on 2024/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (YPPreviewDemo)

/// 预览cell
/// @param indexPath indexpath
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

/// 获取预览cell 高度
/// @param indexPath indexpath
+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
