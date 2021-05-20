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
    @"普通输入框(两个)",];
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
        NSString *tipText = @"这是内容";
        NSString *leftTitle = @"左边";
        NSString *rightTitle = @"右边";
        BOOL isOnlyOneButton = YES;
        BOOL isShowCloseButton = YES;
        BOOL canTouchBeginMove = YES;
        //to do
        if ([title isEqualToString:@"普通提示框"]) {
            title = @"";
            isOnlyOneButton = NO;
        }else if ([title isEqualToString:@"普通提示框(带标题)"]){
            isOnlyOneButton = NO;
        }else if ([title isEqualToString:@"普通提示框(一个按钮)"]){
            title = @"";
        }else if ([title isEqualToString:@"普通提示框(点击空白不隐藏)"]){
            title = @"";
            isOnlyOneButton = NO;
            canTouchBeginMove = NO;
        }
        //to do
        [KKAlertViewController showCustomWithTitle:title tipText:tipText leftTitle:leftTitle rightTitle:rightTitle isOnlyOneButton:isOnlyOneButton isShowCloseButton:isShowCloseButton canTouchBeginMove:canTouchBeginMove complete:^(KKAlertViewController *controler, NSInteger index) {
            [controler dismissViewControllerCompletion:nil];
        }];
    }else if([title rangeOfString:@"普通输入框"].location != NSNotFound){
        //
        if ([title isEqualToString:@"普通输入框(一个)"]) {
            [KKInputBoxAlert showCustomWithTitle:title bottomTitle:@"确定" topPlaceholder:@"占位符" bottomPlaceholder:@"占位符" isOnlyOneTextField:YES canTouchBeginMove:YES complete:^(KKAlertViewController *controler, NSInteger index) {
                [controler dismissViewControllerCompletion:nil];
            }];
        }else if ([title isEqualToString:@"普通输入框(两个)"]){
            [KKInputBoxAlert showCustomWithTitle:title bottomTitle:@"确定" topPlaceholder:@"占位符" bottomPlaceholder:@"占位符" isOnlyOneTextField:NO canTouchBeginMove:YES complete:^(KKAlertViewController *controler, NSInteger index) {
                [controler dismissViewControllerCompletion:nil];
            }];
        }
    }
}
#pragma mark - aciton
@end
