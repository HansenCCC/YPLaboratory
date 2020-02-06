//
//  KKDatabaseDetailViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 2/3/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKDatabaseDetailViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKDatebaseFormViewController.h"

@interface KKDatabaseDetailViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKDatabaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
    self.title = self.model.title;
}
//刷新数据列表
- (void)whenRightClickAction:(id)sender{
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[KKAdaptiveTableViewCell class] forCellReuseIdentifier:@"KKAdaptiveTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    //右边导航刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(whenRightClickAction:)];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    KKDatabase *database = [KKDatabase databaseWithPath:self.model.value];
    NSArray *items = database.tableSqliteMasters;
    for (NSDictionary *item in items) {
        NSString *name = item[@"name"];
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:name value:nil];
        element.info = item;
        element.value = self.model.value;
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
    KKAdaptiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKAdaptiveTableViewCell"];
    [self setupAdaptiveCell:cell cellModel:cellModel];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKAdaptiveTableViewCell *cell = [KKAdaptiveTableViewCell sharedInstance];
    [self setupAdaptiveCell:cell cellModel:cellModel];
    cell.bounds = tableView.bounds;
    CGSize size = [cell sizeThatFits:CGSizeMake(cell.bounds.size.width, 0)];
    CGFloat height = size.height;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKDatebaseFormViewController *vc = [[KKDatebaseFormViewController alloc] init];
    vc.model = cellModel;
    [self.navigationController pushViewController:vc animated:YES];
}
//赋值cell
- (void)setupAdaptiveCell:(KKAdaptiveTableViewCell *)cell cellModel:(KKLabelModel *)cellModel{
    NSDictionary *dict = cellModel.info;
    /*
     sql表单详情
     //name = 1;
     //rootpage = 3;
     //sql = 4;
     //"tbl_name" = 2;
     //type = 0;
     */
    NSString *title = [dict[@"name"] addString:@"\n\n"];
    NSString *rootpage = [NSString stringWithFormat:@"rootpage: %@\n",dict[@"rootpage"]];
    NSString *sql = [NSString stringWithFormat:@"sql: %@\n",dict[@"sql"]];
    NSString *tbl_name = [NSString stringWithFormat:@"tbl_name: %@\n",dict[@"tbl_name"]];
    NSString *type = [NSString stringWithFormat:@"type: %@",dict[@"type"]];
    NSString *format = [NSString stringWithFormat:@"%@%@%@%@",rootpage,sql,tbl_name,type];
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:KKColor_626787,NSFontAttributeName:AdaptedBoldFontSize(15)}];
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = AdaptedWidth(5.f);
    NSAttributedString *formatAttributed = [[NSAttributedString alloc] initWithString:format attributes:@{NSForegroundColorAttributeName:KKColor_1A1A1A,NSFontAttributeName:AdaptedFontSize(14),NSParagraphStyleAttributeName:paragraphStyle}];
    [attributed appendAttributedString:formatAttributed];
    //内容label
    cell.contentLabel.attributedText = attributed;
    UIEdgeInsets insets = cell.contentInsets;
    insets.left = AdaptedWidth(15.f);
    insets.right = AdaptedWidth(8.f);
    insets.top = AdaptedWidth(8.f);
    insets.bottom= AdaptedWidth(8.f);
    cell.contentInsets = insets;
}
#pragma mark - aciton
@end
