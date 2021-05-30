//
//  KKWorldViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKWorldViewController.h"
#import "KKPostViewController.h"
#import "KKWeChatMomentsModel.h"
#import "KKWeChatMomentsTableViewCell.h"
#import "KKNetworkPostedService.h"
#import "KKWorldTableViewCell.h"
#import "KKWorldTableViewHeaderFooterView.h"

@interface KKWorldViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray <NSArray <KKFindPostedResponseModel *> *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger pageNum;//页码
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;

@end

@implementation KKWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addNotification];
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubviews];
    //异步处理消耗内存操作
    [self.tableView.mj_header beginRefreshing];
}
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenReceivedAliPayNotification:) name:kNSNotificationCenterNeedUpdateWorld object:nil];
}
- (void)setupSubviews{
    //右边导航刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(whenRightClickAction:)];
    //
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    //微信朋友圈cell
    [self.tableView registerClass:[KKWorldTableViewCell class] forCellReuseIdentifier:@"KKWorldTableViewCell"];
    //
    self.tableView.mj_header = [KKRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData)];
    self.tableView.mj_footer = [KKRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshData)];
    [self.tableView registerClass:[KKWorldTableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"KKWorldTableViewHeaderFooterView"];
    //
    self.topButton.alpha = 0.4;
    self.downButton.alpha = 0.4;
}
//下拉刷新
- (void)headerRefreshData{
    self.pageNum = 1;
    [self requestTableDataSource];
}
//上拉加载
- (void)footerRefreshData{
    self.pageNum ++;
    [self requestTableDataSource];
}
//请求数据
- (void)requestTableDataSource{
    WeakSelf
    KKFindPostedRequestModel *model = [[KKFindPostedRequestModel alloc] init];
    model.pageNum = @(self.pageNum).stringValue;
    model.pageSize = @(KDefaultPageSize).stringValue;
    [weakSelf.tableView hiddenDisplayView];
    [KKNetworkPostedService findPostedListWithRequestModel:model success:^(KKBaseResponse *response) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (model.pageNum.intValue == 1) {
            [weakSelf.datas removeAllObjects];
        }
        NSArray *items = [KKFindPostedResponseModel mj_objectArrayWithKeyValuesArray:response.data];
        NSMutableArray *mItems = [[NSMutableArray alloc] init];
        NSArray *lastObjects = (NSArray *)weakSelf.datas.lastObject;
        KKFindPostedResponseModel *lastModel = lastObjects.lastObject;
        NSMutableArray *dateArray = [[NSMutableArray alloc] init];
        for (KKFindPostedResponseModel *model in items) {
            NSDate *lastDate = [NSDate dateWithString:lastModel.createTime dateFormat:@"YYYY-MM-dd HH:mm:ss"];
            NSDate *date = [NSDate dateWithString:model.createTime dateFormat:@"YYYY-MM-dd HH:mm:ss"];
            lastModel = model;
            if (lastDate == nil) {
                [dateArray addObject:model];
                if (model == items.lastObject) {
                    [mItems addObject:[dateArray copy]];
                }
                continue;
            }
            //判断是否是同一天
            BOOL flag = [lastDate isSameDayWithDate:date];
            if (flag) {
                [dateArray addObject:model];
                if (model == items.lastObject) {
                    [mItems addObject:[dateArray copy]];
                }
            }else{
                [mItems addObject:[dateArray copy]];
                [dateArray removeAllObjects];
                [dateArray addObject:model];
                if (model == items.lastObject) {
                    [mItems addObject:[dateArray copy]];
                }
            }
        }
        if (items.count < model.pageSize.intValue) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [weakSelf.datas addObjectsFromArray:mItems];
        if (weakSelf.datas.count == 0) {
            [weakSelf.tableView showEmptyDataView];
            [weakSelf.tableView.mj_footer resetNoMoreData];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf showError:error.domain];
        [weakSelf.datas removeAllObjects];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView showNetworkFailView];
    }];
}
//发布内容
- (void)whenRightClickAction:(id)sender{
    //to do
    KKPostViewController *vc = [[KKPostViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    KKPostViewController *vc = [[KKPostViewController alloc] init];
//    KKNavigationController *rootVC = [[KKNavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:rootVC animated:YES completion:nil];
}

#pragma mark - lazy load
- (NSMutableArray <NSArray <KKFindPostedResponseModel *> *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKFindPostedResponseModel *cellModel = self.datas[indexPath.section][indexPath.row];
    KKWorldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKWorldTableViewCell"];
    cell.worldModel = cellModel;
    WeakSelf
    cell.whenActionBlock = ^(NSInteger index, KKWeChatMomentsTableViewCell *cacheCell) {
        if (index == 0) {
            NSString *content = [NSString stringWithFormat:@"此贴内容是否违规，或者引起不适？"];
            [weakSelf showFeedbackAlert:content];
        }
    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas[section].count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKFindPostedResponseModel *cellModel = self.datas[indexPath.section][indexPath.row];
    KKWorldTableViewCell *cell = [KKWorldTableViewCell sharedInstance];
    cell.bounds = tableView.bounds;
    cell.worldModel = cellModel;
    CGFloat height = CGRectGetMaxY(cell.tableView.frame);
    return height + AdaptedWidth(10.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //to do
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    KKWorldTableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KKWorldTableViewHeaderFooterView"];
    KKFindPostedResponseModel *cellModel = self.datas[section].firstObject;
    NSDate *date = [NSDate dateWithString:cellModel.createTime dateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [date stringWithDateFormat:@"YYYY年MM月dd日"];
    headView.title = [NSString stringWithFormat:@"公元：%@起",dateString];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptedWidth(25.f);
}
#pragma mark - aciton
- (void)showFeedbackAlert:(NSString *)content{
    WeakSelf
    [KKAlertViewController showCustomWithTitle:@"提示" textDetail:content leftTitle:@"举报" rightTitle:@"取消" isOnlyOneButton:NO isShowCloseButton:NO canTouchBeginMove:YES complete:^(KKAlertViewController *controler, NSInteger index) {
        [controler dismissViewControllerCompletion:nil];
        if(index == 0){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf showFeedbackNextAlert];
            });
        }
    }];
}
- (void)showFeedbackNextAlert{
    //实际没有反馈到服务，服务没有加这个接口，模拟器反馈
    WeakSelf
    [KKTextBoxAlert showCustomWithTitle:@"意见反馈" textDetail:nil leftTitle:nil rightTitle:@"提交" placeholder:@"输入您要反馈的内容" isOnlyOneButton:YES isShowCloseButton:NO canTouchBeginMove:YES complete:^(KKAlertViewController *controler, NSInteger index) {
        KKTextBoxAlert *vc = (KKTextBoxAlert *)controler;
        [vc.view endEditing:YES];
        if (vc.textView.text.length == 0) {
            [vc showError:@"反馈内容不能为空！"];
        }else{
            [controler dismissViewControllerCompletion:nil];
            [weakSelf showLoading];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf hideLoading];
                [weakSelf showSuccessWithMsg:@"反馈成功！感谢您的反馈"];
            });
        }
    }];
}
- (void)whenReceivedAliPayNotification:(id)sender{
    [self.tableView.mj_header beginRefreshing];
}
- (void)whenNeedAddInfo:(id)sender{
    //程序员发声
    KKPostViewController *vc = [[KKPostViewController alloc] init];
    KKNavigationController *nav = [[KKNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)whenNeeTop:(UIButton *)sender {
    [self.tableView scrollToTopWithAnimated:YES];
}
- (IBAction)whenNeedDown:(UIButton *)sender {
    [self.tableView scrollToBottomWithAnimated:YES];
}
@end
