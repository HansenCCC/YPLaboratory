//
//  KKHomeViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKHomeViewController.h"
#import "KKAppIconMakerViewController.h"//App图标制作
#import "KKLabelModel.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = cellModel.title?:@"--";
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
}
@end
