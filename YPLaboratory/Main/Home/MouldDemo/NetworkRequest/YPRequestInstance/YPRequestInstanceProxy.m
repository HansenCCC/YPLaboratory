//
//  YPRequestInstanceProxy.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/13.
//

#import "YPRequestInstanceProxy.h"
#import "YPRequestInstanceViewModel.h"
#import "YPRequestInstanceTableViewCell.h"
#import "YPRequestInstanceModel.h"
#import "YpApiRequestDao.h"

@interface YPRequestInstanceProxy ()

@property (nonatomic, weak) YPRequestInstanceViewModel *viewModel;

@end

@implementation YPRequestInstanceProxy

- (instancetype)initWithViewModel:(YPRequestInstanceViewModel *)viewModel {
    if (self = [self init]) {
        self.viewModel = viewModel;
    }
    return self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPRequestInstanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPRequestInstanceTableViewCell"];
    YPRequestInstanceModel *cellModel = self.viewModel.dataList[indexPath.row];
    cell.cellModel = cellModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPRequestInstanceModel *cellModel = self.viewModel.dataList[indexPath.row];
    [YPRequestInstanceTableViewCell shareInstance].bounds = [UIScreen mainScreen].bounds;
    [YPRequestInstanceTableViewCell shareInstance].cellModel = cellModel;
    CGFloat height = [YPRequestInstanceTableViewCell shareInstance].cellHeight;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[YPShakeManager shareInstance] mediumShake];
    YPRequestInstanceModel *cellModel = self.viewModel.dataList[indexPath.row];
    cellModel.isShow = !cellModel.isShow;
    YPRequestInstanceTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell yp_reloadCurrentTableViewCell];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPRequestInstanceModel *cellModel = self.viewModel.dataList[indexPath.row];
    __weak typeof(self) weakSelf = self;
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除".yp_localizedString handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [[YPShakeManager shareInstance] mediumShake];
        if (completionHandler) {
            completionHandler(YES);
        }
        cellModel.model.isEnable = NO;
        [[YpApiRequestDao get] updateYpApiRequestByPrimaryKey:cellModel.model.id aYpApiRequest:cellModel.model];
        [weakSelf.viewModel.dataList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    deleteAction.backgroundColor = [UIColor yp_colorWithHexString:@"#fa5051"];
    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    return configuration;
}

@end
