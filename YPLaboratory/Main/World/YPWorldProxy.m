//
//  YPWorldProxy.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPWorldProxy.h"
#import "YPWorldViewModel.h"
#import "YPWorldTableViewCell.h"
#import "YPWorldModel.h"

@interface YPWorldProxy ()

@property (nonatomic, weak) YPWorldViewModel *viewModel;

@end

@implementation YPWorldProxy

- (instancetype)initWithViewModel:(YPWorldViewModel *)viewModel {
    if (self = [self init]) {
        self.viewModel = viewModel;
    }
    return self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPWorldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPWorldTableViewCell"];
    YPWorldModel *cellModel = self.viewModel.dataList[indexPath.row];
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
