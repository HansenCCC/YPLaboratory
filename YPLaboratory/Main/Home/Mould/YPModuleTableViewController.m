//
//  YPModuleTableViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import "YPModuleTableViewController.h"
#import "YPModuleTableViewModel.h"
#import "YPModuleTableProxy.h"
#import "Masonry.h"
#import "YPModuleBaseCell.h"
#import "YPModuleNormalCell.h"
#import "YPModuleSwitchCell.h"
#import "YPModuleButtonCell.h"
#import "YPModuleImageCell.h"
#import "YPSwiperNormalTableViewCell.h"
#import "YPSwiperCardTableViewCell.h"
#import "YPSystemFontsTableViewCell.h"
#import "YPBarcodeAndQRCodeCell.h"

@interface YPModuleTableViewController () <YPModuleTableViewModelDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YPModuleTableViewModel *viewModel;
@property (nonatomic, strong) YPModuleTableProxy *proxy;

@end

@implementation YPModuleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
    [self startLoadData];
}

- (void)startLoadData {
    [self.viewModel startLoadData];
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
}

#pragma mark - YPModuleTableViewModelDelegate

- (void)didEndLoadData:(BOOL)hasMore {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (hasMore) {
        [self.tableView.mj_footer resetNoMoreData];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.tableView reloadData];
}

#pragma mark - getters | setters

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView;
        BOOL useInsetGrouped = self.model.useInsetGrouped;
        if (@available(iOS 13.0, *)) {
            if (useInsetGrouped) {
                tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
            } else {
                tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            }
        } else {
            // Fallback on earlier versions
            tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        }
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.delegate = self.proxy;
        tableView.dataSource = self.proxy;
        __weak typeof(self) weakSelf = self;
        tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [weakSelf.viewModel loadMoreData];
        }];
        NSArray *classs = @[
            [UITableViewCell class],
            [YPModuleBaseCell class],
            [YPModuleNormalCell class],
            [YPModuleSwitchCell class],
            [YPModuleButtonCell class],
            [YPModuleImageCell class],
            [YPSwiperNormalTableViewCell class],
            [YPSwiperCardTableViewCell class],
            [YPSystemFontsTableViewCell class],
            [YPBarcodeAndQRCodeCell class],
        ];
        [classs enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerClass:obj forCellReuseIdentifier:NSStringFromClass(obj)];
        }];
        NSArray *headersClasss = @[
        ];
        [headersClasss enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerClass:obj forHeaderFooterViewReuseIdentifier:NSStringFromClass(obj)];
        }];
        _tableView = tableView;
    }
    return _tableView;
}

- (YPModuleTableProxy *)proxy {
    if (!_proxy) {
        _proxy = [[YPModuleTableProxy alloc] initWithViewModel:self.viewModel];
    }
    return _proxy;
}

- (YPModuleTableViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YPModuleTableViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

- (void)setModel:(YPPageRouter *)model {
    _model = model;
    self.viewModel.model = model;
    self.title = model.title?:@"";
}

@end
