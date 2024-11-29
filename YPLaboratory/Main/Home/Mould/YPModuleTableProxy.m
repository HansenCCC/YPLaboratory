//
//  YPModuleTableProxy.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import "YPModuleTableProxy.h"
#import "YPModuleTableViewModel.h"
#import "YPModuleNormalCell.h"
#import "YPPageRouter.h"
#import "UIViewController+Router.h"
#import "UIViewController+Router.h"

@interface YPModuleTableProxy ()

@property (nonatomic, weak) YPModuleTableViewModel *viewModel;

@end

@implementation YPModuleTableProxy

- (instancetype)initWithViewModel:(YPModuleTableViewModel *)viewModel {
    if (self = [self init]) {
        self.viewModel = viewModel;
    }
    return self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPPageRouterModule *module = self.viewModel.dataList[indexPath.section];
    YPPageRouter *cellModel = module.routers[indexPath.row];
    
    NSString *identifier = @"YPModuleBaseCell";
    switch (cellModel.type) {
        case YPPageRouterTypeNormal:
        case YPPageRouterTypeModule: {
            identifier = @"YPModuleNormalCell";
        }
            break;
        case YPPageRouterTypeSwitch: {
            identifier = @"YPModuleSwitchCell";
        }
            break;
        case YPPageRouterTypeButton: {
            identifier = @"YPModuleButtonCell";
        }
            break;
        case YPPageRouterTypeCustom: {
            identifier = NSStringFromClass(cellModel.cellClass);
        }
            break;
        default: {
            identifier = @"YPModuleBaseCell";
        }
            break;
    }
    
    if (!identifier.length) {
        identifier = @"YPModuleNormalCell";
    }
    
    YPModuleBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.cellModel = cellModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YPPageRouterModule *module = self.viewModel.dataList[section];
    return module.routers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPPageRouterModule *module = self.viewModel.dataList[indexPath.section];
    YPPageRouter *cellModel = module.routers[indexPath.row];
    CGFloat height = cellModel.cellHeight;
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[YPShakeManager shareInstance] tapShake];
    YPPageRouterModule *module = self.viewModel.dataList[indexPath.section];
    YPPageRouter *cellModel = module.routers[indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[UIViewController yp_topViewController] pushToControllerWithRouter:cellModel cell:cell];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    YPPageRouterModule *module = self.viewModel.dataList[section];
    return module.headerTitle?:@"";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    YPPageRouterModule *module = self.viewModel.dataList[section];
    return module.footerTitle?:@"";
}

@end
