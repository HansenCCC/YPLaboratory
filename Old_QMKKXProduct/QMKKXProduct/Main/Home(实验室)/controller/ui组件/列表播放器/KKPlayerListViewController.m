//
//  KKPlayerListViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 5/26/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKPlayerListViewController.h"
#import "KKPlayerTableViewCell.h"

@interface KKPlayerListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <KKLabelModel *>*datas;

@end

@implementation KKPlayerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"列表播放器";
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
}
- (void)setupSubvuews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //
    self.tableView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[KKPlayerTableViewCell class] forCellReuseIdentifier:@"KKPlayerTableViewCell"];
}
- (void)updateDatas{
    [self.datas removeAllObjects];
    NSArray *videos = @[@"https://img.qumeng666.com/1590398734.269067",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590399408.463029",
                        @"https://img.qumeng666.com/1590399442.681522",
                        @"https://img.qumeng666.com/1590399510.690721",
                        @"https://img.qumeng666.com/1590398734.269067",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590399408.463029",
                        @"https://img.qumeng666.com/1590399442.681522",
                        @"https://img.qumeng666.com/1590399510.690721",
                        @"https://img.qumeng666.com/1590398734.269067",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590399408.463029",
                        @"https://img.qumeng666.com/1590399442.681522",
                        @"https://img.qumeng666.com/1590399510.690721",
                        @"https://img.qumeng666.com/1590398734.269067",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590399408.463029",
                        @"https://img.qumeng666.com/1590399442.681522",
                        @"https://img.qumeng666.com/1590399510.690721",
                        @"https://img.qumeng666.com/1590398734.269067",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590399408.463029",
                        @"https://img.qumeng666.com/1590399442.681522",
                        @"https://img.qumeng666.com/1590399510.690721",
                        @"https://img.qumeng666.com/1590398734.269067",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590399408.463029",
                        @"https://img.qumeng666.com/1590399442.681522",
                        @"https://img.qumeng666.com/1590399510.690721",
                        @"https://img.qumeng666.com/1590398734.269067",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590398820.492414",
                        @"https://img.qumeng666.com/1590399408.463029",
                        @"https://img.qumeng666.com/1590399442.681522",
                        @"https://img.qumeng666.com/1590399510.690721",
    ];
    //to do
    for (NSString *value in videos) {
        KKLabelModel *model = [[KKLabelModel alloc] initWithTitle:value value:value];
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
    NSString *identifier = [NSString stringWithFormat:@"KKPlayerTableViewCell%ld",indexPath.row];
    [tableView registerClass:[KKPlayerTableViewCell class] forCellReuseIdentifier:identifier];
    KKPlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.cellModel = cellModel;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}
//滚动超出暂停播放
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //to do
}
#pragma mark - action
@end
