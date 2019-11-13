//
//  KKExamListViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/13.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKExamListViewController.h"
#import "KKExamSearchViewController.h"

@interface KKExamListViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKExamListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"英语专业考试";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)reloadDatas{
    //比较消耗内存，建议异步处理
    [self showLoading];
    dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.datas removeAllObjects];
        NSArray *items = @[@"1交际.json",@"2阅读.json",@"3词汇.json",@"4完型.json",@"5翻译.json",@"6作文.json"];
        for (NSString *item in items) {
            KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
            element.info = [NSArray arrayWithStringByExamJson:item];
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
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKExamSearchViewController *vc = [[KKExamSearchViewController alloc] init];
    vc.examStrings = cellModel.info;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

@implementation NSArray (Exam)
+ (NSArray <NSString *>*)arrayWithStringByExamJson:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *utf8String = data.UTF8String;
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    //
    NSMutableString *_mstring = [[NSMutableString alloc] initWithString:utf8String];
    NSRange range = [_mstring rangeOfString:@"\n"];
    while (range.location != NSNotFound) {
        NSString *substring = [_mstring substringWithRange:NSMakeRange(0, range.location)];
        if (![strings containsObject:substring]&&substring.length > 0) {
            [strings addObject:substring];
        }
        [_mstring deleteCharactersInRange:NSMakeRange(0, range.location + range.length)];
        range = [_mstring rangeOfString:@"\n"];
    }
    return strings;
}
@end
