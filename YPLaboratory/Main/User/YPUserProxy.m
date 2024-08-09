//
//  YPUserProxy.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPUserProxy.h"
#import "YPUserViewModel.h"
#import "YPUserTableViewCell.h"
#import "YPUserModel.h"

@interface YPUserProxy ()

@property (nonatomic, weak) YPUserViewModel *viewModel;

@end

@implementation YPUserProxy

- (instancetype)initWithViewModel:(YPUserViewModel *)viewModel {
    if (self = [self init]) {
        self.viewModel = viewModel;
    }
    return self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPUserTableViewCell"];
    YPUserModel *cellModel = self.viewModel.dataList[indexPath.row];
    cell.cellModel = cellModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.f;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
