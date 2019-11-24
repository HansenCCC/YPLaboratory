//
//  KKUIUnitViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/14.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKUIUnitViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKProgressHUDViewController.h"//普通提示框
#import "KKPickViewViewController.h"//选择输入框
#import "KKNavigationConfigViewController.h"//导航栏设置

@interface KKUIUnitViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKUIUnitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"ui组件";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    KKLabelModel *c1 = [[KKLabelModel alloc] initWithTitle:@"普通提示框(基于MBProgressHUD)" value:nil];
    c1.info = [KKProgressHUDViewController class];
    KKLabelModel *c2 = [[KKLabelModel alloc] initWithTitle:@"输入选择框(基于UIPickerView)" value:nil];
    c2.info = [KKPickViewViewController class];
    KKLabelModel *c3 = [[KKLabelModel alloc] initWithTitle:@"导航栏配置(基于UINavigationBar)" value:nil];
    c3.info = [KKNavigationConfigViewController class];
    [self.datas addObjectsFromArray:@[c1,c2,c3,]];
    
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
    return AdaptedWidth(44.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //to do
    [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    KKLabelModel *cellModel = self.datas[indexPath.row];
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
