//
//  KKTableViewCellViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 2/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKTableViewCellViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "UITableViewCell+KPreviewDemo.h"

@interface KKTableViewCellViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKTableViewCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"丰富多彩的cell(基于UITableView)";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    //to do
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cells.json" ofType:nil];
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
#pragma mark - lazy load
- (NSMutableArray<KKLabelModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.title];
    Class class = [cell class];
    if (class) {
        //动态调用类方法
        SEL sel = NSSelectorFromString(@"previewDemoTestCell:indexPath:");
        if ([class respondsToSelector:sel]) {
            IMP imp = [class methodForSelector:sel];
            void (*function)(id, SEL,UITableViewCell *,NSIndexPath *) = (void *)imp;
            function(class,sel,cell,indexPath);
        }
    }else{
        //to do
        return [[UITableViewCell alloc] init];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = AdaptedWidth(44.f);
    KKLabelModel *cellModel = self.datas[indexPath.section];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    KKLabelModel *cellModel = self.datas[section];
    return cellModel.value.intValue;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    KKLabelModel *cellModel = self.datas[section];
    return cellModel.title;
}
#pragma mark - aciton
@end
