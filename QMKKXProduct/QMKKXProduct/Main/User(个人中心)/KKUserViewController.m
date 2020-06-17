//
//  KKUserViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKUserViewController.h"

@interface KKUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (assign, nonatomic) NSInteger pageNum;
@property (weak,   nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation KKUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //请求列表
    [self setupSubviews];
    [self requestDataSource];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    [self.tableView registerClass:[KKAdaptiveTableViewCell class] forCellReuseIdentifier:@"KKAdaptiveTableViewCell"];
    self.tableView.mj_header = [KKRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData)];
    self.tableView.mj_footer = [KKRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshData)];
}
//下拉刷新
- (void)headerRefreshData{
    self.pageNum = 1;
    [self requestDataSource];
}
//上拉加载
- (void)footerRefreshData{
    self.pageNum ++;
    [self requestDataSource];
}
- (void)requestDataSource{
    [self reloadDatas];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //获取数据库朋友圈信息
    NSString *tableName = [KKUser shareInstance].userActionTable;
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"kk_common.db"];
    KKDatabase *database = [KKDatabase databaseWithPath:dbPath];
    NSArray *list = [database selectTableWithTableName:tableName];
    //构造cell
    for (NSDictionary *dict in list) {
        NSString *value = dict[@"json"];
        if (value.length > 0) {
            KKPeopleAcitonModel *element = [KKPeopleAcitonModel mj_objectWithKeyValues:value];
            //字符转时间
            NSDate *date = [NSDate dateWithString:element.date dateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *name = [NSString stringWithFormat:@"%@ 你跳转到%@",[NSDate kk_transformCurrentTime:date],element.value];
            KKLabelModel *model = [[KKLabelModel alloc] initWithTitle:name value:nil];
            model.info = element;
            [self.datas addObject:model];
        }
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}
#pragma mark - lazy load
- (NSMutableArray<KKLabelModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKLabelTableViewCell"];
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
    //取消选中状态
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKPeopleAcitonModel *reslut = cellModel.info;
    Class vcClass = NSClassFromString(reslut.value);
    if (vcClass) {
        [self pushViewControllerClass:vcClass animated:YES];
    }
}
#pragma mark - aciton
//通用跳转方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}
//通过vcClass跳转
- (void)pushViewControllerClass:(Class )viewControllerClass animated:(BOOL)animated{
    UIViewController *vc = [[viewControllerClass alloc] init];
    [self pushViewController:vc animated:animated];
}
@end
