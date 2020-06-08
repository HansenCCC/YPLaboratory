//
//  KKCommonHomeStyleViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 6/8/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKCommonHomeStyleViewController.h"
#import "KKNeteaseGodViewController.h"//网易大神
#import "KKBeeViewController.h"//Bee

@interface KKCommonHomeStyleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation KKCommonHomeStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"常见的首页样式";
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
}
- (void)setupSubvuews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //
    self.tableView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)updateDatas{
    [self.datas removeAllObjects];
    NSArray *items = @[@"Bee首页样式",
                       @"网易大神首页样式",
                       @"--待补充",
                       @"--待补充",
                       @"--待补充",
    ];
    //to do
    for (NSString *value in items) {
        KKLabelModel *model = [[KKLabelModel alloc] initWithTitle:value value:@""];
        [self.datas addObject:model];
    }
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
    if (indexPath.row == 0) {
        KKBeeViewController *vc = [[KKBeeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1){
        KKNeteaseGodViewController *vc = [[KKNeteaseGodViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 2){
        
    }else if(indexPath.row == 3){
        
    }
}
#pragma mark - action
@end
