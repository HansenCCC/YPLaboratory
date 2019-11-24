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
#import "KKExamListViewController.h"//英语专业考试
#import "KKSDWebViewController.h"//网络图片下载
#import "KKUIUnitViewController.h"//ui组件
#import "KKAppInstallViewController.h"//Apple安装协议
#import "KKNavigationConfigViewController.h"//导航栏设置

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
    s1m1.info = [KKLabStudioViewController class];
    KKLabelModel *s1m2 = [[KKLabelModel alloc] initWithTitle:@"App图标制作" value:nil];
    s1m2.info = [KKAppIconMakerViewController class];
    KKLabelModel *s1m3 = [[KKLabelModel alloc] initWithTitle:@"英语专业考试" value:nil];
    s1m3.info = [KKExamListViewController class];
    KKLabelModel *s1m4 = [[KKLabelModel alloc] initWithTitle:@"网络图片下载" value:nil];
    s1m4.info = [KKSDWebViewController class];
    KKLabelModel *s1m5 = [[KKLabelModel alloc] initWithTitle:@"API网络层" value:nil];
    s1m5.info = [KKBaseViewController class];
    s1m5.isEnabled = NO;
    KKLabelModel *s1m6 = [[KKLabelModel alloc] initWithTitle:@"UI组件" value:nil];
    s1m6.info = [KKUIUnitViewController class];
    KKLabelModel *s1m7 = [[KKLabelModel alloc] initWithTitle:@"C语言绘图(Core Graphics)" value:nil];
    s1m7.isEnabled = NO;
    s1m7.info = [KKBaseViewController class];
    KKLabelModel *s1m8 = [[KKLabelModel alloc] initWithTitle:@"OC语言绘图(UIBezierPath)" value:nil];
    s1m8.isEnabled = NO;
    s1m8.info = [KKBaseViewController class];
    KKLabelModel *s1m9 = [[KKLabelModel alloc] initWithTitle:@"K线应用" value:nil];
    s1m9.isEnabled = NO;
    s1m9.info = [KKBaseViewController class];
    KKLabelModel *s1m10 = [[KKLabelModel alloc] initWithTitle:@"Apple安装协议&App打开和交互" value:nil];
    s1m10.info = [KKAppInstallViewController class];
    KKLabelModel *s1m11 = [[KKLabelModel alloc] initWithTitle:@"Xcode自定义文件模板" value:nil];
    s1m11.isEnabled = NO;
    KKLabelModel *s1m12 = [[KKLabelModel alloc] initWithTitle:@"导航栏配置" value:nil];
    s1m12.info = [KKNavigationConfigViewController class];
    KKLabelModel *s1m13 = [[KKLabelModel alloc] initWithTitle:@"文件管理" value:nil];
    s1m13.isEnabled = NO;
    KKLabelModel *s1m14 = [[KKLabelModel alloc] initWithTitle:@"学习资料和资源(h5地址)" value:nil];
    s1m14.isEnabled = NO;
    [self.datas addObjectsFromArray:@[s1m1,s1m6,s1m2,s1m12,s1m4,s1m13,s1m5,s1m7,s1m8,s1m9,s1m10,s1m11,s1m3,s1m14]];
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
    KKLabelModel *cellModel = self.datas[indexPath.row];
    Class vcClass = cellModel.info;
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
