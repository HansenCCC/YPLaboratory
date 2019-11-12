//
//  KKHomeViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKHomeViewController.h"
#import "KKLabStudioViewController.h"//工作台
#import "KKAppIconMakerViewController.h"//App图标制作
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"

@interface KKHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    KKLabelModel *s1m1 = [[KKLabelModel alloc] initWithTitle:@"工作台" value:nil];
    KKLabelModel *s1m2 = [[KKLabelModel alloc] initWithTitle:@"App制作图标" value:nil];
    KKLabelModel *s1m3 = [[KKLabelModel alloc] initWithTitle:@"英语专业考试" value:nil];
    KKLabelModel *s1m4 = [[KKLabelModel alloc] initWithTitle:@"网络图片下载" value:nil];
    KKLabelModel *s1m5 = [[KKLabelModel alloc] initWithTitle:@"API网络层" value:nil];
    KKLabelModel *s1m6 = [[KKLabelModel alloc] initWithTitle:@"快速开发定制试图" value:nil];
    [self.datas addObjectsFromArray:@[s1m1,s1m2,s1m3,s1m4,s1m5,s1m6,]];
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
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if ([cellModel.title isEqualToString:@"工作台"]) {
        [self pushLabStudioViewController];
    }else if([cellModel.title isEqualToString:@"App制作图标"]){
        [self pushAppIconMakerViewController];
    }else if([cellModel.title isEqualToString:@"英语专业考试"]){
        
    }else if([cellModel.title isEqualToString:@"网络图片下载"]){
        
    }else if([cellModel.title isEqualToString:@"API网络层"]){
        
    }else if([cellModel.title isEqualToString:@"快速开发定制试图"]){
        
    }else if([cellModel.title isEqualToString:@""]){
        
    }else if([cellModel.title isEqualToString:@""]){
        
    }
}
#pragma mark - aciton
//通用跳转方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}
//跳转工作台
- (void)pushLabStudioViewController{
    KKLabStudioViewController *vc = [[KKLabStudioViewController alloc] init];
    [self pushViewController:vc animated:YES];
}
//跳转App制作图标
- (void)pushAppIconMakerViewController{
    KKAppIconMakerViewController *vc = [[KKAppIconMakerViewController alloc] init];
    [self pushViewController:vc animated:YES];
}
@end
