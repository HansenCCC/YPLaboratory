//
//  KKVideoCameraViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 1/3/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKVideoCameraViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKQRCodeScanViewController.h"
#import "KKIDCardScanViewController.h"
#import "KKFaceTrackViewController.h"
#import "KKCustomCameraViewController.h"

@interface KKVideoCameraViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKVideoCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"摄像机模块";
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
    KKLabelModel *c1 = [[KKLabelModel alloc] initWithTitle:@"二维码扫码" value:nil];
    c1.info = [KKQRCodeScanViewController class];
    KKLabelModel *c2 = [[KKLabelModel alloc] initWithTitle:@"人脸追踪识别" value:nil];
    c2.info = [KKFaceTrackViewController class];
    KKLabelModel *c3 = [[KKLabelModel alloc] initWithTitle:@"自定义相机(没时间待完善)" value:nil];
    c3.info = [KKCustomCameraViewController class];
    KKLabelModel *c4 = [[KKLabelModel alloc] initWithTitle:@"身份证拍照" value:nil];
    c4.info = [KKIDCardScanViewController class];
    [self.datas addObjectsFromArray:@[c1,c2,c3,c4,]];
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
#pragma mark - aciton
@end
