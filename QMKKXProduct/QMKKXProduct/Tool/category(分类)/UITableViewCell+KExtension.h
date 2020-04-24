//
//  UITableViewCell+KExtension.h
//  QMKKXProduct
//  hansen的动态赋值，自动计算高度
//  Created by Hansen on 2/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (KExtension)
AS_SINGLETON(UITableViewCell);

/// 刷新当前试图
- (void)kk_reloadCurrentTableViewCell;

/// 设置model
/// @param cellModel cellmodel
- (void)kk_extensionCellModel:(id)cellModel;

/// 通过model获取高度
/// @param cellModel cellmodel
/// @param tableView 父视图
- (CGFloat)kk_extensionCellHeight:(id)cellModel tableView:(UITableView *)tableView;

/// 通过class获取单例对象cell
/// @param calss class
+ (UITableViewCell *)kk_extensionSingleCell:(Class )calss;
@end

