//
//  YPDiverseViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/4.
//

#import "YPDiverseViewController.h"

@interface YPDiverseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YPDiverseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startLoadData];
    [self setupSubviews];
}

- (void)startLoadData {
    self.dataList = @[];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cells.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *utf8String = data.UTF8String;
    NSArray *items = [KKLabelModel mj_objectArrayWithKeyValuesArray:utf8String.jsonArray];
    [self.datas addObjectsFromArray:items];
    for (KKLabelModel *label in self.datas) {
        NSString *cell = label.title;
        //判断cell是否存在xib文件
        //⚠️xib最终会变成nib文件⚠️
        NSString*nibPath = [[NSBundle mainBundle] pathForResource:cell ofType:@"nib"];
        if (nibPath.length > 0) {
            UINib *nib = [UINib nibWithNibName:cell bundle:[NSBundle mainBundle]];
            [self.tableView registerNib:nib forCellReuseIdentifier:cell];
        }else{
            [self.tableView registerClass:NSClassFromString(cell) forCellReuseIdentifier:cell];
        }
    }
    //构造cell
    [self.tableView reloadData];
}

- (void)setupSubviews {
    
}

#pragma mark - getters | setters

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        NSArray *classs = @[
            [UITableViewCell class],
        ];
        [classs enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerClass:obj forCellReuseIdentifier:NSStringFromClass(obj)];
        }];
        NSArray *headersClasss = @[
        ];
        [headersClasss enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tableView registerClass:obj forHeaderFooterViewReuseIdentifier:NSStringFromClass(obj)];
        }];
        _tableView = tableView;
    }
    return _tableView;
}

@end
