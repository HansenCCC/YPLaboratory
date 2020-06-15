//
//  KKDropdownBoxViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 6/15/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKDropdownBoxViewController.h"

@interface KKDropdownBoxViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <KKLabelModel *>*datas;


@end

@implementation KKDropdownBoxViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"dropdownBox(弹框)";
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
    NSArray *items = @[@"下拉框",
                       @"下拉框",
                       @"下拉框",
                       @"下拉框",
                       @"下拉框",
                       @"下拉框",
                       @"下拉框",
                       @"下拉框",
                       @"下拉框"];
    for (int i = 0;i < items.count; i ++) {
        NSString *item = items[i];
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
        if (i == 0) {
            element.placeholder = @"100*100";
        }else if (i == 1) {
            element.placeholder = @"100*200";
        }else if (i == 2) {
            element.placeholder = @"100*300";
        }else if (i == 3) {
            element.placeholder = @"200*100";
        }else if (i == 4) {
            element.placeholder = @"200*200";
        }else if (i == 5) {
            element.placeholder = @"200*300";
        }else if (i == 6) {
            element.placeholder = @"300*100";
        }else if (i == 7) {
            element.placeholder = @"300*200";
        }else if (i == 8) {
            element.placeholder = @"300*300";
        }
        [self.datas addObject:element];
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *familyNames = [UIFont familyNames];
    KKDropdownBoxView *boxView = [[KKDropdownBoxView alloc] initWithTitles:familyNames withComplete:^(NSInteger index) {
        NSLog(@"%@",familyNames[index]);
    }];
    CGRect rect = cell.bounds;
    long i = indexPath.row;
    if (i == 0) {
        rect.size.width = AdaptedWidth(100.f);
        rect.size.height = AdaptedWidth(100.f);
    }else if (i == 1) {
        rect.size.width = AdaptedWidth(100.f);
        rect.size.height = AdaptedWidth(200.f);
    }else if (i == 2) {
        rect.size.width = AdaptedWidth(100.f);
        rect.size.height = AdaptedWidth(300.f);
    }else if (i == 3) {
        rect.size.width = AdaptedWidth(200.f);
        rect.size.height = AdaptedWidth(100.f);
    }else if (i == 4) {
        rect.size.width = AdaptedWidth(200.f);
        rect.size.height = AdaptedWidth(200.f);
    }else if (i == 5) {
        rect.size.width = AdaptedWidth(200.f);
        rect.size.height = AdaptedWidth(300.f);
    }else if (i == 6) {
        rect.size.width = AdaptedWidth(300.f);
        rect.size.height = AdaptedWidth(100.f);
    }else if (i == 7) {
        rect.size.width = AdaptedWidth(300.f);
        rect.size.height = AdaptedWidth(200.f);
    }else if (i == 8) {
        rect.size.width = AdaptedWidth(300.f);
        rect.size.height = AdaptedWidth(300.f);
    }
    rect.origin.x = cell.bounds.size.width - rect.size.width - AdaptedWidth(8.f);
    rect.origin.y = cell.bounds.size.height;
    [boxView showViewCenter:rect toView:cell];
}
//滚动超出暂停播放
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //to do
}
#pragma mark - action

@end
