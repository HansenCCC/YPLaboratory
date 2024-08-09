//
//  UITableViewCell+KExtension.m
//  QMKKXProduct
//
//  Created by Hansen on 2/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "UITableViewCell+KExtension.h"

@implementation UITableViewCell (KExtension)
DEF_SINGLETON(UITableViewCell);
+ (void)load{
    //to do
    [UITableViewCell sharedInstance];
}

/// 刷新当前试图
- (void)kk_reloadCurrentTableViewCell{
    UITableView *tableView = (UITableView *)self.superview;
    if ([tableView isKindOfClass:[UITableView class]]) {
        NSIndexPath *indexPath = [tableView indexPathForCell:self];
        if (indexPath) {
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

/// 设置model
/// @param cellModel cellmodel
- (void)kk_extensionCellModel:(id)cellModel{
    //to do
}

/// 通过model获取高度
/// @param cellModel cellmodel
/// @param tableView 父视图
- (CGFloat)kk_extensionCellHeight:(id)cellModel tableView:(UITableView *)tableView{
    //to do
    self.bounds = tableView.bounds;
    [self kk_extensionCellModel:cellModel];
    return AdaptedWidth(44.f);
}

/// 通过class获取单例对象cell
/// @param calss class
+ (UITableViewCell *)kk_extensionSingleCell:(Class )calss{
    SEL sel = NSSelectorFromString(@"sharedInstance");
    if([calss respondsToSelector:sel]){
        //获取方法指正地址
        IMP imp = [calss instanceMethodForSelector:sel];
        //调用方法
        id (*func)(Class, SEL) = (void *)imp;
        id value = func(calss,sel);
        return value;
    }
    return [self sharedInstance];
}
@end
