//
//  KKProgressHUDViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 11/24/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKProgressHUDViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"

@interface KKProgressHUDViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKProgressHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"普通提示框";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(whenRightClickAction:)];
}
//隐藏页面所有ProgressHUD
- (void)whenRightClickAction:(id)sender{
    //to do
    [MBProgressHUD hideHUD];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    NSArray *items = @[@"普通提示框",
                       @"普通提示框(自动隐藏)",
                       @"成功提示框(自动隐藏)",
                       @"失败提示框(自动隐藏)",
                       @"icon提示框(自动隐藏)",
                       @"loading状态(自动隐藏)",
                       @"进度条(圆形饼图)",
                       @"进度条(水平进度条)",
                       @"进度条(圆环)",];
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
    KKLabelModel *cellModel = self.datas[indexPath.row];
    NSString *title = cellModel.title;
    if ([cellModel.title isEqualToString:@"普通提示框"]) {
        [self showCustomIcon:nil message:title isWindow:NO timer:9999];
    }else if ([cellModel.title isEqualToString:@"普通提示框(自动隐藏)"]) {
        [self showCustomIcon:nil message:title isWindow:YES];
    }else if ([cellModel.title isEqualToString:@"成功提示框(自动隐藏)"]) {
        [self showSuccessWithMsg:title];
    }else if ([cellModel.title isEqualToString:@"失败提示框(自动隐藏)"]) {
        [self showError:title];
    }else if ([cellModel.title isEqualToString:@"icon提示框(自动隐藏)"]) {
        NSString *name = [NSString stringWithFormat:@"%dfix",rand()%220];
        [self showCustomIcon:name message:title isWindow:YES];
    }else if ([cellModel.title isEqualToString:@"loading状态(自动隐藏)"]) {
        [self showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(KUIProgressHUDAfterDelayTimer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideLoading];
        });
    }else if ([cellModel.title isEqualToString:@"进度条(圆形饼图)"]) {
        MBProgressHUD *hud = (MBProgressHUD *)[self showCustomIcon:nil message:title isWindow:NO timer:9999];
        hud.mode = MBProgressHUDModeDeterminate;
        [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES handler:^(NSTimer *timer) {
            hud.progress += 0.01;
            if (hud.progress >= 1||hud.superview == nil) {
                [timer invalidate];
                timer = nil;
            }
        }];
    }else if ([cellModel.title isEqualToString:@"进度条(水平进度条)"]) {
        MBProgressHUD *hud = (MBProgressHUD *)[self showCustomIcon:nil message:title isWindow:NO timer:9999];
        hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
        [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES handler:^(NSTimer *timer) {
            hud.progress += 0.02;
            if (hud.progress >= 1||hud.superview == nil) {
                [timer invalidate];
                timer = nil;
            }
        }];
    }else if ([cellModel.title isEqualToString:@"进度条(圆环)"]) {
        MBProgressHUD *hud = (MBProgressHUD *)[self showCustomIcon:nil message:title isWindow:NO timer:9999];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES handler:^(NSTimer *timer) {
            hud.progress += 0.03;
            if (hud.progress >= 1||hud.superview == nil) {
                [timer invalidate];
                timer = nil;
            }
        }];
    }
}
@end
