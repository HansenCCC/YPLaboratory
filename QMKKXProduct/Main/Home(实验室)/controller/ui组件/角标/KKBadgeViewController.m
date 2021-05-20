//
//  KKBadgeViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 4/28/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKBadgeViewController.h"

@interface KKBadgeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation KKBadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"角标和红点";
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
}
- (void)setupSubvuews{
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)updateDatas{
    [self.datas removeAllObjects];
    //to do
    NSArray *items = @[@"显示未读数",@"显示红点"];
    NSMutableArray *mItems = [[NSMutableArray alloc] init];
    for (NSString *value in items) {
        KKLabelModel *model = [[KKLabelModel alloc] initWithTitle:value value:nil];
        [mItems addObject:model];
    }
    [self.datas addObjectsFromArray:mItems];
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
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
    return AdaptedWidth(45.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    KKLabelTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //角标显示情况下，点击隐藏
    if ([cell traversalAllForClass:[KKBadgeView class]].count > 0) {
        [KKBadgeView hiddenBadgeToView:cell];
    }else{
        if (indexPath.row == 0) {
            [KKBadgeView showBadgeToView:cell.titleLabel badgeInteger:999];
        }else if (indexPath.row == 1){
            [KKBadgeView showBadgeToView:cell.titleLabel];
        }
    }
}
@end
