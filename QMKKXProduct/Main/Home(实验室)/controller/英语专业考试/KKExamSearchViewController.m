//
//  KKExamSearchViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/13.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKExamSearchViewController.h"

@interface KKExamSearchViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) NSArray <NSString *>* screenExamStrings;
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation KKExamSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    //
    self.navigationItem.titleView = self.searchBar;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backItemClick)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)setExamStrings:(NSArray<NSString *> *)examStrings{
    _examStrings = examStrings;
    self.screenExamStrings = [examStrings copy];
}
- (void)reloadDatas{
    //比较消耗内存，建议异步处理
    [self showLoading];
    dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.datas removeAllObjects];
        NSArray *items = self.screenExamStrings;
        for (NSString *item in items) {
            KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
            [self.datas addObject:element];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self hideLoading];
        });
    });
}
#pragma mark - lazy load
- (NSMutableArray<KKLabelModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.returnKeyType = UIReturnKeyDone;
        _searchBar.enablesReturnKeyAutomatically = NO;
        [_searchBar becomeFirstResponder];
    }
    return _searchBar;
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
    KKLabelModel *cellModel = self.datas[indexPath.row];
    [self showSuccessWithMsg:cellModel.title];
}
#pragma mark - UISearchBarDelegate
//搜索return
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //结束编辑
    [searchBar resignFirstResponder];
}
//搜索change
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *inputStr = searchText;
    inputStr = [inputStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//去除首位空格
    inputStr = [inputStr stringByReplacingOccurrencesOfString:@" "withString:@""];  //去除中间空格
    inputStr = [inputStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (inputStr.length == 0) {
        self.screenExamStrings = [self.examStrings copy];
    }else{
        NSMutableArray *examStrings = [[NSMutableArray alloc] init];
        for (NSString *string in self.examStrings) {
            if ([string.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
                [examStrings addObject:string];
            }
        }
        self.screenExamStrings = examStrings.copy;
    }
    [self reloadDatas];
}
@end
