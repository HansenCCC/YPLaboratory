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
#import "KKCarouselViewController.h"//carousel
#import "KKVideoCameraViewController.h"//camera
#import "KKSinaAiteViewController.h"//新浪@人
#import "KKWeChatMomentsViewController.h"//微信朋友圈
#import "KKVideoPlayViewController.h"//视频播放控件
#import "KKTableViewCellViewController.h"//丰富多彩的cell(基于UITableView)
#import "KKCustomAlertViewController.h"//自定义弹框(alert)
#import "KKBadgeViewController.h"//角标

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
    KKLabelModel *c4 = [[KKLabelModel alloc] initWithTitle:@"丰富多彩的cell(基于UITableView)" value:nil];
    c4.info = [KKTableViewCellViewController class];
    KKLabelModel *c5 = [[KKLabelModel alloc] initWithTitle:@"丰富多彩的cell(基于UICollectionView)" value:nil];
    c5.isEnabled = NO;
    KKLabelModel *s1m6 = [[KKLabelModel alloc] initWithTitle:@"K线应用" value:nil];
    s1m6.isEnabled = NO;
    KKLabelModel *s1m7 = [[KKLabelModel alloc] initWithTitle:@"轮播图(基于KKCarouselView)" value:nil];
    s1m7.info = [KKCarouselViewController class];
    KKLabelModel *s1m8 = [[KKLabelModel alloc] initWithTitle:@"摄像机模块" value:nil];
    s1m8.info = [KKVideoCameraViewController class];
    KKLabelModel *s1m9 = [[KKLabelModel alloc] initWithTitle:@"模拟新浪@人" value:nil];
    s1m9.info = [KKSinaAiteViewController class];
    KKLabelModel *s1m10 = [[KKLabelModel alloc] initWithTitle:@"模拟微信朋友圈" value:nil];
    s1m10.info = [KKWeChatMomentsViewController class];
    KKLabelModel *s1m11 = [[KKLabelModel alloc] initWithTitle:@"视频播放控件" value:nil];
    s1m11.info = [KKVideoPlayViewController class];
    KKLabelModel *s1m12 = [[KKLabelModel alloc] initWithTitle:@"自定义弹框(alert)" value:nil];
    s1m12.info = [KKCustomAlertViewController class];
    KKLabelModel *s1m13 = [[KKLabelModel alloc] initWithTitle:@"角标和红点" value:nil];
    s1m13.info = [KKBadgeViewController class];
    [self.datas addObjectsFromArray:@[c4,c5,c1,s1m12,c2,c3,s1m7,s1m6,s1m8,s1m11,s1m9,s1m10,s1m13]];
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
@end
