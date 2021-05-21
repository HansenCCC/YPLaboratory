//
//  KKWeChatMomentsViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 1/14/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatMomentsViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKWeChatMomentsTableViewCell.h"
#import "KKReleaseWXMomentsViewController.h"

@interface KKWeChatMomentsViewController ()
@property (strong, nonatomic) NSMutableArray <KKWeChatMomentsModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKWeChatMomentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"模拟微信朋友圈";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}
- (void)setupSubviews{
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    //微信朋友圈cell
    [self.tableView registerClass:[KKWeChatMomentsTableViewCell class] forCellReuseIdentifier:@"KKWeChatMomentsTableViewCell"];
    self.tableView.mj_header = [KKRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoadNewData)];
    //右边导航刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(whenRightClickAction:)];
}
- (void)downLoadNewData{
    [self reloadDatas];
}
//发布内容
- (void)whenRightClickAction:(id)sender{
    //to do
    KKReleaseWXMomentsViewController *vc = [[KKReleaseWXMomentsViewController alloc] init];
    KKNavigationController *rootVC = [[KKNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:rootVC animated:YES completion:nil];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //获取数据库朋友圈信息
    NSString *tableName = @"kk_wechat_moments";
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"kk_common.db"];
    KKDatabase *database = [KKDatabase databaseWithPath:dbPath];
    NSArray *list = [database selectTableWithTableName:tableName];
    //构造cell
    for (NSDictionary *dict in list) {
        NSString *value = dict[@"json"];
        if (value.length > 0) {
            KKWeChatMomentsModel *element = [KKWeChatMomentsModel mj_objectWithKeyValues:value];
            [self.datas addObject:element];
        }
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}
#pragma mark - lazy load
- (NSMutableArray<KKWeChatMomentsModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKWeChatMomentsModel *cellModel = self.datas[indexPath.row];
    KKWeChatMomentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKWeChatMomentsTableViewCell"];
    cell.cellModel = cellModel;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKWeChatMomentsModel *cellModel = self.datas[indexPath.row];
    KKWeChatMomentsTableViewCell *cell = [KKWeChatMomentsTableViewCell sharedInstance];
    cell.bounds = tableView.bounds;
    cell.cellModel = cellModel;
    CGFloat height = CGRectGetMaxY(cell.tableView.frame);
    return height + AdaptedWidth(10.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //to do
}
#pragma mark - aciton
@end
