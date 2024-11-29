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
    NSString *cellPath = [[NSBundle mainBundle] pathForResource:@"Cells.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:cellPath];
    NSError *error = nil;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSArray *items = [YPPageRouter mj_objectArrayWithKeyValuesArray:jsonDic];
    self.dataList = [items copy];
    for (YPPageRouter *cellModel in self.dataList) {
        [self.tableView registerClass:NSClassFromString(cellModel.title) forCellReuseIdentifier:cellModel.title];
    }
    [self.tableView reloadData];
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
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

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPPageRouter *cellModel = self.dataList[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.title];
    Class class = [cell class];
    if (class) {
        /// 动态调用类方法
        SEL sel = NSSelectorFromString(@"previewDemoTestCell:indexPath:");
        if ([class respondsToSelector:sel]) {
            IMP imp = [class methodForSelector:sel];
            void (*function)(id, SEL,UITableViewCell *,NSIndexPath *) = (void *)imp;
            function(class,sel,cell,indexPath);
        }
    } else {
        return [[UITableViewCell alloc] init];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.f;
    YPPageRouter *cellModel = self.dataList[indexPath.section];
    Class class = NSClassFromString(cellModel.title);
    if (class) {
        SEL sel = NSSelectorFromString(@"heightForPreviewDemoTest:");
        if ([class respondsToSelector:sel]) {
            IMP imp = [class methodForSelector:sel];
            CGFloat (*function)(id, SEL,NSIndexPath *) = (void *)imp;
            height = function(class,sel,indexPath);
        }
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YPPageRouter *cellModel = self.dataList[section];
    return cellModel.content.intValue;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YPPageRouter *cellModel = self.dataList[section];
    return cellModel.title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[YPShakeManager shareInstance] tapShake];
}

@end
