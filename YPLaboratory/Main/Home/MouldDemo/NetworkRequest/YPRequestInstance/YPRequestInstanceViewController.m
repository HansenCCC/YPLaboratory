//
//  YPRequestInstanceViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/13.
//

#import "YPRequestInstanceViewController.h"
#import "YPRequestInstanceViewModel.h"
#import "YPRequestInstanceProxy.h"
#import "YPRequestInstanceTableViewCell.h"
#import "Masonry.h"
#import "YpApiRequestDao.h"

@interface YPRequestInstanceViewController () <YPRequestInstanceViewModelDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YPRequestInstanceViewModel *viewModel;
@property (nonatomic, strong) YPRequestInstanceProxy *proxy;

@end

@implementation YPRequestInstanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger count = [[YpApiRequestDao get] selectYpApiRequestCount:@"isEnable=1"];
    self.title = [NSString stringWithFormat:@"历史记录 [%d]".yp_localizedString, count];
    
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

#pragma mark - YPRequestInstanceViewModelDelegate

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
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
            [YPRequestInstanceTableViewCell class],
        ];
        [classs enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerClass:obj forCellReuseIdentifier:NSStringFromClass(obj)];
        }];
        
        NSArray *headersClasss = @[];
        [headersClasss enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerClass:obj forHeaderFooterViewReuseIdentifier:NSStringFromClass(obj)];
        }];
        
        _tableView = tableView;
    }
    return _tableView;
}

- (YPRequestInstanceProxy *)proxy {
    if (!_proxy) {
        _proxy = [[YPRequestInstanceProxy alloc] initWithViewModel:self.viewModel];
    }
    return _proxy;
}

- (YPRequestInstanceViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YPRequestInstanceViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

@end
