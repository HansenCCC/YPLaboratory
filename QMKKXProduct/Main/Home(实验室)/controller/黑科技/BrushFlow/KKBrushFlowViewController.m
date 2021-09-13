//
//  KKBrushFlowViewController.m
//  QMKKXProduct
//
//  Created by shinemo on 2021/9/10.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKBrushFlowViewController.h"
#import "KKBrushFlowToolViewController.h"

@interface KKBrushFlowViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <KKLabelModel *>*datas;

@property (nonatomic, strong) KKLabelModel *linkAddressModel;
@property (nonatomic, strong) KKLabelModel *refreshCountModel;
@property (nonatomic, strong) KKLabelModel *stateModel;//状态显示
@property (nonatomic, strong) KKLabelModel *searchModel;//开始搜索
@property (nonatomic, assign) NSInteger requestCount;//请求次数

@end

@implementation KKBrushFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"刷流量";
    self.view.backgroundColor = KKColor_FFFFFF;
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
    //右边导航刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(whenRightClickAction:)];
}

- (void)whenRightClickAction:(id)sender{
    //TODO
}

- (void)setupSubvuews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //
    self.tableView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKButtonTableViewCell"];
}

- (void)updateDatas{
    [self.datas removeAllObjects];
    [self loadDatasForLocalSqlite];
    //
    [self.datas addObject:self.linkAddressModel];
    [self.datas addObject:self.refreshCountModel];
    [self.datas addObject:self.stateModel];
    [self.datas addObject:self.searchModel];
    //
    [self.tableView reloadData];
}

- (void)loadDatasForLocalSqlite{
    self.linkAddressModel.value = @"https://www.jianshu.com/p/8db5c1bea72c";
    self.refreshCountModel.value = @"200";
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    Class cellClass = cellModel.cellClass;
    KKLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    cell.cellModel = cellModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedWidth(45.f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //TODO
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if ([cellModel isEqual:self.searchModel]) {
        int maxCount = self.refreshCountModel.value.intValue;
        if (self.linkAddressModel.value.length == 0) {
            [self showError:@"请输入目标地址"];
            return;
        } else if(self.refreshCountModel.value.intValue == 0){
            [self showError:@"请输入刷量次数"];
            return;
        }
        self.refreshCountModel.value = @(maxCount).stringValue;
        self.stateModel.title = @"正在刷量中...";
        [self.tableView reloadData];
        self.requestCount = 0;
        [self startRefreshFlow];
    }
}

#pragma mark - getters
- (KKLabelModel *)linkAddressModel{
    if (!_linkAddressModel) {
        _linkAddressModel = [[KKLabelModel alloc] initWithTitle:@"链接地址" value:@""];
        _linkAddressModel.cellClass = [KKLabelTableViewCell class];
        _linkAddressModel.isCanEdit = YES;
        _linkAddressModel.placeholder = @"请输入链接地址";
        _linkAddressModel.isShowStar = YES;
        _linkAddressModel.isShowLine = YES;
    }
    return _linkAddressModel;
}

- (KKLabelModel *)refreshCountModel{
    if (!_refreshCountModel) {
        _refreshCountModel = [[KKLabelModel alloc] initWithTitle:@"刷新次数" value:@""];
        _refreshCountModel.cellClass = [KKLabelTableViewCell class];
        _refreshCountModel.placeholder = @"请大致需要刷新的次数";
        _refreshCountModel.isCanEdit = YES;
        _refreshCountModel.isShowStar = YES;
        _refreshCountModel.isShowLine = YES;
    }
    return _refreshCountModel;
}

- (KKLabelModel *)searchModel{
    if (!_searchModel) {
        _searchModel = [[KKLabelModel alloc] initWithTitle:@"开 始" value:@""];
        _searchModel.cellClass = [KKButtonTableViewCell class];
    }
    return _searchModel;
}

- (KKLabelModel *)stateModel{
    if (!_stateModel) {
        _stateModel = [[KKLabelModel alloc] initWithTitle:@"点击👇🏻，将会开始网页流量次数" value:@""];
        _stateModel.cellClass = [KKButtonTableViewCell class];
    }
    return _stateModel;
}

#pragma mark - action
- (void)startRefreshFlow{
    KKBrushFlowToolViewController *vc = [[KKBrushFlowToolViewController alloc] init];
    vc.urlString = self.linkAddressModel.value?:@"--";
    WeakSelf
    vc.whenRequestComplete = ^(NSInteger requestCount) {
        weakSelf.requestCount += requestCount;
        if (weakSelf.requestCount >= weakSelf.refreshCountModel.value.intValue) {
            weakSelf.stateModel.title = [NSString stringWithFormat:@"已经完成刷量(%ld/%d)",(long)weakSelf.requestCount,weakSelf.refreshCountModel.value.intValue];
        } else {
            weakSelf.stateModel.title = [NSString stringWithFormat:@"当前进度(%ld/%d)",(long)weakSelf.requestCount,weakSelf.refreshCountModel.value.intValue];
            [weakSelf startRefreshFlow];
        }
        [weakSelf.tableView reloadData];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

@end
