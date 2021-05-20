//
//  KKWKWebViewViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 5/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWKWebViewViewController.h"

@interface KKWKWebViewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation KKWKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datas = [[NSMutableArray alloc] init];
    self.title = @"网站(WKWebView)";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[KKAdaptiveTableViewCell class] forCellReuseIdentifier:@"KKAdaptiveTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    NSArray *items = @[@"加载本地HTML(index.html)",@"加载网络HTML(https://www.baidu.com/)",@"UIWebView(iOS 12.0已弃用)"];
    for (int i = 0;i < items.count; i ++) {
        NSString *item = items[i];
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
        if (i == 2||i == 3) {
            element.isEnabled = NO;
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
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
        KKUIWebViewController *vc = [[KKUIWebViewController alloc] init];
        KKNavigationController *nav = [[KKNavigationController alloc] initWithRootViewController:vc];
        vc.requestURL = url;
        [self presentViewController:nav animated:YES completion:nil];
    }else if(indexPath.row == 1){
        NSString *path = @"http://test.tvimg.cn/moto_html/feedback2.html";
        KKUIWebViewController *vc = [[KKUIWebViewController alloc] init];
        KKNavigationController *nav = [[KKNavigationController alloc] initWithRootViewController:vc];
        vc.requestURL = path.toURL;
        [self presentViewController:nav animated:YES completion:nil];
    }else if(indexPath.row == 2){
        
    }else if(indexPath.row == 3){

    }
}
@end
