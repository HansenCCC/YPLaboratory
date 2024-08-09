//
//  KKBlackTechnologyViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 2021/8/30.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKBlackTechnologyViewController.h"
#import "KKLabelModel.h"
#import "KKBrushFlowViewController.h"

@interface KKBlackTechnologyViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <KKLabelModel *>*datum;

@property (strong, nonatomic) KKLabelModel *brushFlowCellModel;

@end

@implementation KKBlackTechnologyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"黑科技";
    [self setupSubviews];
    [self reloadDatum];
}

- (void)setupSubviews{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
}

- (void)reloadDatum{
    [self.datum removeAllObjects];
    //
    [self.datum addObject:self.brushFlowCellModel];
    [self.tableView reloadData];
}

#pragma mark - getters
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    }
    return _tableView;
}

- (NSMutableArray<KKLabelModel *> *)datum{
    if (!_datum) {
        _datum = [[NSMutableArray alloc] init];
    }
    return _datum;
}

- (KKLabelModel *)brushFlowCellModel{
    if (!_brushFlowCellModel) {
        _brushFlowCellModel = [[KKLabelModel alloc] initWithTitle:@"刷流量" value:@""];
        _brushFlowCellModel.info = [KKBrushFlowViewController class];
    }
    return _brushFlowCellModel;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datum[indexPath.row];
    KKLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKLabelTableViewCell"];
    cell.cellModel = cellModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datum.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedWidth(44.f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    KKLabelModel *cellModel = self.datum[indexPath.row];
    Class vcClass = cellModel.info;
    if (vcClass) {
        [self pushViewControllerClass:vcClass animated:YES];
    }
}

//通过vcClass跳转
- (void)pushViewControllerClass:(Class )viewControllerClass animated:(BOOL)animated{
    UIViewController *vc = [[viewControllerClass alloc] init];
    [self.navigationController pushViewController:vc animated:animated];
}

@end
