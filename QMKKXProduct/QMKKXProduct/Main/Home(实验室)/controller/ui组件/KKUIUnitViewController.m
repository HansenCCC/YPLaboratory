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
#import "KKLabelsViewController.h"//标签
#import "KKWKWebViewViewController.h"//网站(WKWebView)
#import "KKPlayerListViewController.h"//列表播放器

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
    KKLabelModel *s6 = [[KKLabelModel alloc] initWithTitle:@"K线应用(搁置没时间)" value:nil];
    s6.isEnabled = NO;
    KKLabelModel *s7 = [[KKLabelModel alloc] initWithTitle:@"轮播图(基于KKCarouselView)" value:nil];
    s7.info = [KKCarouselViewController class];
    KKLabelModel *s8 = [[KKLabelModel alloc] initWithTitle:@"摄像机模块(基于KKAVCaptureBaseSessionView)" value:nil];
    s8.info = [KKVideoCameraViewController class];
    KKLabelModel *s9 = [[KKLabelModel alloc] initWithTitle:@"模拟新浪@人" value:nil];
    s9.info = [KKSinaAiteViewController class];
    KKLabelModel *s10 = [[KKLabelModel alloc] initWithTitle:@"模拟微信朋友圈" value:nil];
    s10.info = [KKWeChatMomentsViewController class];
    KKLabelModel *s11 = [[KKLabelModel alloc] initWithTitle:@"iOS播放视频" value:nil];
    s11.info = [KKVideoPlayViewController class];
    KKLabelModel *s12 = [[KKLabelModel alloc] initWithTitle:@"自定义弹框(alert)" value:nil];
    s12.info = [KKCustomAlertViewController class];
    KKLabelModel *s13 = [[KKLabelModel alloc] initWithTitle:@"角标和红点" value:nil];
    s13.info = [KKBadgeViewController class];
    KKLabelModel *s14 = [[KKLabelModel alloc] initWithTitle:@"C语言绘图(基于Core Graphics)" value:nil];
    s14.isEnabled = NO;
    s14.info = [KKBaseViewController class];
    KKLabelModel *s15 = [[KKLabelModel alloc] initWithTitle:@"OC语言绘图(基于UIBezierPath)" value:nil];
    s15.isEnabled = NO;
    s15.info = [KKBaseViewController class];
    KKLabelModel *s16 = [[KKLabelModel alloc] initWithTitle:@"标签" value:nil];
    s16.info = [KKLabelsViewController class];
    KKLabelModel *s17 = [[KKLabelModel alloc] initWithTitle:@"网站(基于WKWebView)" value:nil];
    s17.info = [KKWKWebViewViewController class];
    KKLabelModel *s18 = [[KKLabelModel alloc] initWithTitle:@"列表播放器(基于AVPlayer，防卡顿处理)" value:nil];
    s18.info = [KKPlayerListViewController class];
    [self.datas addObjectsFromArray:@[s14,s15,c4,c5,c1,s12,c2,c3,s7,s6,s8,s11,s9,s10,s13,s16,s17,s18]];
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
