//
//  KKDatebaseFormViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 2/3/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKDatebaseFormViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKFormTableViewCell.h"

@interface KKDatebaseFormViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) CGPoint contentOffset;

@end

@implementation KKDatebaseFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.model.title;
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKFormTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKFormTableViewCell"];
    //右边导航刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(whenRightClickAction:)];
}
//刷新数据列表
- (void)whenRightClickAction:(id)sender{
    KKDatabase *database = [KKDatabase databaseWithPath:self.model.value];
    [database insertTableWithTableName:self.model.title contents:@{@"phone":@"1",
                                                      @"score":@"数学",
                                                      @"column2":@"2",
                                                      @"column1":@"1",
                                                      @"column3":@"3",
                                                      @"column4":@"7",
    }];
    [self reloadDatas];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    KKDatabase *database = [KKDatabase databaseWithPath:self.model.value];
    //内容
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    //遍历表单所有字段
    NSArray *allkeys = [database getFieldsWithTableName:self.model.title];
    [datas addObject:allkeys];
    //构造cell
    NSArray *items = [database selectTableWithTableName:self.model.title];
    //获取表单内容
    for (NSDictionary *item in items) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (NSString *key in allkeys) {
            NSString *value = [item objectForKey:key];
            [items addObject:value?:@""];
        }
        [datas addObject:items];
    }
    for (id value in datas) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:@"" value:nil];
        element.info = value;
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
    KKFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKFormTableViewCell"];
    cell.cellModel = cellModel;
    cell.contentOffset = self.contentOffset;
    WeakSelf
    cell.whenScrollViewDidScroll = ^(UIScrollView *scrollView) {
        NSArray *cells = [weakSelf.tableView visibleCells];
        for (KKFormTableViewCell *tc in cells) {
            tc.contentOffset = scrollView.contentOffset;
        }
        weakSelf.contentOffset = scrollView.contentOffset;
    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedWidth(44.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //to do
}
#pragma mark - aciton
@end
