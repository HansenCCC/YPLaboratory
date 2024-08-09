//
//  KKCustomAlertViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 2/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKCustomAlertViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"

@interface KKCustomAlertViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKCustomAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"自定义弹框(alert)";
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
    NSArray *items = @[@"普通提示框",
    @"普通提示框(带标题)",
    @"普通提示框(一个按钮)",
    @"普通提示框(点击空白不隐藏)",
    @"普通输入框(一个)",
    @"获取经纬度弹框",
    @"内嵌HTML弹框",
    ];
    for (NSString *item in items) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
        [self.datas addObject:element];
    }
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
    //to do
    KKLabelModel *cellModel = self.datas[indexPath.row];
    NSString *title = cellModel.title;
    if ([title rangeOfString:@"普通提示框"].location != NSNotFound) {
        NSString *leftTitle = @"左边";
        NSString *rightTitle = @"右边";
        BOOL isOnlyOneButton = YES;
        BOOL isShowCloseButton = YES;
        BOOL canTouchBeginMove = YES;
        //to do
        if ([title isEqualToString:@"普通提示框"]) {
            isOnlyOneButton = NO;
        }else if ([title isEqualToString:@"普通提示框(带标题)"]){
            isOnlyOneButton = NO;
        }else if ([title isEqualToString:@"普通提示框(一个按钮)"]){
        }else if ([title isEqualToString:@"普通提示框(点击空白不隐藏)"]){
            isOnlyOneButton = NO;
            canTouchBeginMove = NO;
        }
        title = @"注意！";
        NSString *detail = @"iOS技术分享（APP图标制作、仿微信朋友圈、仿微信图片查看器、防新浪@人、仿支付宝密码弹框、仿发圈、标签、js交互+wk、加载网页、自适应cell高度、TableView嵌入播放器防卡顿、定制好看弹框、选择地址、选择时间、选择颜色、导航自定义控制、轮播图、二维码扫描、人脸追踪、自定义相机、身份证拍照、ios播放器、AVPlayer封装、下拉选项弹框、贪吃蛇、跑马灯、TableView自适应高度、原生图片下载缓存、文件夹操作、数据库操作、三方登录、分享、支付、Apple安装协议、App之间传值、鸣谢支持）";
        //to do
        [KKAlertViewController showCustomWithTitle:title textDetail:detail leftTitle:leftTitle rightTitle:rightTitle isOnlyOneButton:isOnlyOneButton isShowCloseButton:isShowCloseButton canTouchBeginMove:canTouchBeginMove complete:^(KKAlertViewController *controler, NSInteger index) {
            [controler dismissViewControllerCompletion:nil];
        }];
    }else if([title rangeOfString:@"普通输入框"].location != NSNotFound){
        //
        WeakSelf
        [KKTextBoxAlert showCustomWithTitle:title textDetail:nil leftTitle:nil rightTitle:@"提交" placeholder:@"这是一个占位符~" isOnlyOneButton:YES isShowCloseButton:NO canTouchBeginMove:YES complete:^(KKAlertViewController *controler, NSInteger index) {
            KKTextBoxAlert *vc = (KKTextBoxAlert *)controler;
            [vc.view endEditing:YES];
            if (vc.textView.text.length == 0) {
                [vc showError:@"输入内容不能为空！"];
            }else{
                [controler dismissViewControllerCompletion:nil];
                [weakSelf showLoading];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf hideLoading];
                    [weakSelf showSuccessWithMsg:@"提交成功！"];
                });
            }
        }];
    }else if([title rangeOfString:@"获取经纬度弹框"].location != NSNotFound){
        [KKMapAlert showMapComplete:^(KKAlertViewController *controler, NSInteger index) {
            [controler dismissViewControllerCompletion:nil];
        }];
    }else if([title rangeOfString:@"内嵌HTML弹框"].location != NSNotFound){
        NSString *url = @"https://github.com/HansenCCC";
        NSURLRequest *request = [NSURLRequest requestWithURL:url.toURL];
        [KKHtmlBoxAlert showCustomWithTitle:title textDetail:nil leftTitle:nil rightTitle:@"关闭" request:request isOnlyOneButton:YES isShowCloseButton:NO canTouchBeginMove:YES complete:^(KKAlertViewController *controler, NSInteger index) {
            [controler dismissViewControllerCompletion:nil];
        }];
    }
}
#pragma mark - aciton
@end
