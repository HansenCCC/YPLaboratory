//
//  KKDatabaseViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 1/29/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKDatabaseViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"

@interface KKDatabaseViewController ()
@property (strong, nonatomic) KKDatabase *datebase;
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;


@end

@implementation KKDatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"数据库(基于FMDB)";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)db{
//    //4.数据库中创建表（可创建多张）
//    NSString *sql = @"create table if not exists t_student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL)";
//    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
//    BOOL result = [db executeUpdate:sql];
//    if (result) {
//        NSLog(@"create table success");
//    }
//    [db close];
}
- (void)setupSubviews{
    //数据库
    self.datebase = [[KKDatabase alloc] init];
    //ui
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //遍历项目目录所有文件，查找db文件
    NSString *homePath = NSHomeDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dicEnumerator = [fileManager enumeratorAtPath:homePath];
    BOOL isDir = NO;
    BOOL isExist = NO;
    NSMutableArray *dbFiles = [[NSMutableArray alloc] init];
    for (NSString *path in dicEnumerator.allObjects) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",homePath,path];
        isExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
        if (isDir) {
            //目录路径
        }else {
            //文件路径
            NSString *pathExtension = [filePath pathExtension];
            if ([[NSString fileDatabase] containsObject:pathExtension]) {
                //database
                [dbFiles addObject:[filePath lastPathComponent]];
            }
        }
    }
    //构造cell
    NSArray *items = [dbFiles copy];
    for (NSString *item in items) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
        element.value = @"大大";
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
    //to do
}
@end
