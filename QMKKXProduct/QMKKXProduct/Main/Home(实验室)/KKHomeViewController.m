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
    KKLabelModel *s1m2 = [[KKLabelModel alloc] initWithTitle:@"App图标制作" value:nil];
    KKLabelModel *s1m3 = [[KKLabelModel alloc] initWithTitle:@"英语专业考试" value:nil];
    KKLabelModel *s1m4 = [[KKLabelModel alloc] initWithTitle:@"网络图片下载" value:nil];
    KKLabelModel *s1m5 = [[KKLabelModel alloc] initWithTitle:@"API网络层" value:nil];
    s1m5.isEnabled = NO;
    KKLabelModel *s1m6 = [[KKLabelModel alloc] initWithTitle:@"UI组件" value:nil];
    KKLabelModel *s1m7 = [[KKLabelModel alloc] initWithTitle:@"C语言绘图(Core Graphics)" value:nil];
    s1m7.isEnabled = NO;
    KKLabelModel *s1m8 = [[KKLabelModel alloc] initWithTitle:@"OC语言绘图(UIBezierPath)" value:nil];
    s1m8.isEnabled = NO;
    KKLabelModel *s1m9 = [[KKLabelModel alloc] initWithTitle:@"K线应用" value:nil];
    s1m9.isEnabled = NO;
    KKLabelModel *s1m10 = [[KKLabelModel alloc] initWithTitle:@"Apple安装协议" value:nil];
    KKLabelModel *s1m11 = [[KKLabelModel alloc] initWithTitle:@"Apple打开其他App协议" value:nil];
    KKLabelModel *s1m12 = [[KKLabelModel alloc] initWithTitle:@"Xcode自定义文件模板" value:nil];
    [self.datas addObjectsFromArray:@[s1m1,s1m2,s1m3,s1m4,s1m5,s1m6,s1m7,s1m8,s1m9,s1m10,s1m11,s1m12]];
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
    }else if([cellModel.title isEqualToString:@"App图标制作"]){
        [self pushAppIconMakerViewController];
    }else if([cellModel.title isEqualToString:@"英语专业考试"]){
        [self pushExamListViewController];
    }else if([cellModel.title isEqualToString:@"网络图片下载"]){
        [self pushSDWebViewController];
    }else if([cellModel.title isEqualToString:@"API网络层"]){
        
    }else if([cellModel.title isEqualToString:@"UI组件"]){
        [self pushUIUnitViewController];
    }else if([cellModel.title isEqualToString:@"C语言绘图(Core Graphics)"]){
        
    }else if([cellModel.title isEqualToString:@"OC语言绘图(UIBezierPath)"]){
        
    }else if([cellModel.title isEqualToString:@"K线应用"]){
        
    }else if([cellModel.title isEqualToString:@"Apple安装协议"]){
        
    }else if([cellModel.title isEqualToString:@"Apple打开其他App协议"]){
        
    }else if([cellModel.title isEqualToString:@"Xcode自定义文件模板"]){
        
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
//跳转英语专业考试
- (void)pushExamListViewController{
    KKExamListViewController *vc = [[KKExamListViewController alloc] init];
    [self pushViewController:vc animated:YES];
}
//网络图片下载
- (void)pushSDWebViewController{
    KKSDWebViewController *vc = [[KKSDWebViewController alloc] init];
    [self pushViewController:vc animated:YES];
}
//ui组件
- (void)pushUIUnitViewController{
    KKUIUnitViewController *vc = [[KKUIUnitViewController alloc] init];
    [self pushViewController:vc animated:YES];
}
@end
