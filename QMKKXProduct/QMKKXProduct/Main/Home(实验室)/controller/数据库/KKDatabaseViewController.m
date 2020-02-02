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
    [self.tableView registerClass:[KKAdaptiveTableViewCell class] forCellReuseIdentifier:@"KKAdaptiveTableViewCell"];
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
                NSString *fileName = [filePath lastPathComponent];
                KKDatabase *database = [KKDatabase databaseWithPath:filePath];
                KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:fileName value:nil];
                NSDictionary *reslut = [fileManager attributesOfItemAtPath:filePath error:nil];
                element.info = reslut;
                element.value = filePath;
                element.placeholder = @(database.tableCount).stringValue;
                [dbFiles addObject:element];
            }
        }
    }
    //构造cell
    [self.datas addObjectsFromArray:dbFiles];
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
    //to do
}
//赋值cell
- (void)setupAdaptiveCell:(KKAdaptiveTableViewCell *)cell cellModel:(KKLabelModel *)cellModel{
    //to do
    NSDictionary *reslut = cellModel.info;
    double byte = 1000.0;
    long fileSize = reslut.fileSize/byte;
    double fileSizeTmp;
    NSString *tip;
    if (fileSize > byte * byte) {
        tip = @"GB";
        fileSizeTmp = fileSize/(byte * byte);
    }else if(fileSize > byte){
        tip = @"MB";
        fileSizeTmp = fileSize/(byte);
    }else{
        tip = @"KB";
        fileSizeTmp = fileSize;
    }
    NSString *title = [cellModel.title addString:@"\n\n"];
    NSString *fileSizeString = [NSString stringWithFormat:@"文件大小: %.2f %@\n",fileSizeTmp,tip];
    NSString *tableNumber = [NSString stringWithFormat:@"表单数量: %@\n",cellModel.placeholder];
    NSString *createDate = [NSString stringWithFormat:@"创建时间: %@\n",reslut[NSFileCreationDate]];
    NSString *updateDate = [NSString stringWithFormat:@"修改时间: %@\n",reslut[NSFileModificationDate]];
    NSString *filePath = [NSString stringWithFormat:@"文件路径: %@",cellModel.value];
    NSString *format = [NSString stringWithFormat:@"%@%@%@%@%@",fileSizeString,tableNumber,createDate,updateDate,filePath];
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
@end
