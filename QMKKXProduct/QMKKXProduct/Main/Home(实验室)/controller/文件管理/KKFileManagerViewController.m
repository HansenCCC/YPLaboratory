//
//  KKFileManagerViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 11/25/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKFileManagerViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKFileViewController.h"

@interface KKFileManagerViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKFileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"文件管理";
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
    KKLabelModel *c1 = [[KKLabelModel alloc] initWithTitle:@"仅限模拟器获取Mac资源文件" value:nil];
    c1.value = @"/";
    KKLabelModel *c2 = [[KKLabelModel alloc] initWithTitle:@"Mac Desktop文件" value:nil];
    c2.value = @"/Users/Hansen/Desktop/";
    KKLabelModel *c3 = [[KKLabelModel alloc] initWithTitle:@"NSHomeDirectory()文件" value:nil];
    c3.value = NSHomeDirectory();
    KKLabelModel *c4 = [[KKLabelModel alloc] initWithTitle:@"Mac Downloads文件" value:nil];
    c4.value = @"/Users/Hansen/Downloads/";
    [self.datas addObjectsFromArray:@[c1,c2,c4,c3,]];
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
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKFileViewController *vc = [[KKFileViewController alloc] init];
    vc.filePath = cellModel.value;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
