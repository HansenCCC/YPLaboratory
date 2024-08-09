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
#import "KKDatebaseFormTableViewCell.h"

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
    [self.tableView registerNib:[UINib nibWithNibName:@"KKDatebaseFormTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKDatebaseFormTableViewCell"];
    //右边导航刷新按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(whenRightClickAction:)];
}
//点击右上角操作
- (void)whenRightClickAction:(id)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    WeakSelf
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"添加字段" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //to do
        [weakSelf addColumn];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"添加数据" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //to do
        [weakSelf addDatabase];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //to do
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}
//添加字段
- (void)addColumn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加字段" message:@"请输入字段名(不能与已有字段名重复)" preferredStyle:UIAlertControllerStyleAlert];
    WeakSelf
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入字段名";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *value = alert.textFields.firstObject.text;
        if (value.length > 0) {
            //添加字段
            KKDatabaseColumnModel *columnModel = [[KKDatabaseColumnModel alloc] init];
            columnModel.name = value;
            KKDatabase *database = [KKDatabase databaseWithPath:weakSelf.model.value];
            BOOL success = [database addColumnWithTableName:weakSelf.model.title columnModel:columnModel];
            if (success) {
                [weakSelf showSuccessWithMsg:@"字段添加成功"];
                [weakSelf reloadDatas];
            }else{
                NSString *error = [database lastErrorMessage];
                [weakSelf showError:[@"字段添加失败" addString:error]];
            }
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //to do
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
//添加数据
- (void)addDatabase{
    //
    KKDatabase *database = [KKDatabase databaseWithPath:self.model.value];
    NSArray *columns = [database getFieldsWithTableName:self.model.title];
    //按照字母排序
    columns = [columns sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加数据" message:@"输入框字段对于的值" preferredStyle:UIAlertControllerStyleAlert];
    WeakSelf
    for (NSString *column in columns) {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = column;
        }];
    }
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (UITextField *textField in alert.textFields) {
            NSString *value = textField.text;
            NSString *key = textField.placeholder;
            if (value.length > 0){
                [dict setObject:value forKey:key];
            }
        }
        BOOL success = [database insertTableWithTableName:self.model.title contents:dict];
        if (success) {
            [weakSelf showSuccessWithMsg:@"数据添加成功"];
            [weakSelf reloadDatas];
        }else{
            NSString *error = [database lastErrorMessage];
            [weakSelf showError:[@"数据添加失败" addString:error]];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //to do
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)whenAcitonDatabase:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    WeakSelf
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"删除内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //to do
        [weakSelf deleteDatabase:indexPath];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"修改内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //to do
        [weakSelf updateDatabase:indexPath];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //to do
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}
//删除数据
- (void)deleteDatabase:(NSIndexPath *)indexPath{
    KKDatabase *database = [KKDatabase databaseWithPath:self.model.value];
    NSArray *items = [database selectTableWithTableName:self.model.title];
    NSObject *object = items[indexPath.row - 1];
    BOOL success = [database deleteTableWithTableName:self.model.title contents:object];
    if (success) {
        [self showSuccessWithMsg:@"内容删除成功"];
        [self reloadDatas];
    }else{
        NSString *error = [database lastErrorMessage];
        [self showError:[@"内容删除失败" addString:error]];
    }
}
//更新数据
- (void)updateDatabase:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    //
    KKDatabase *database = [KKDatabase databaseWithPath:self.model.value];
    NSArray *columns = [database getFieldsWithTableName:self.model.title];
    NSArray *values = cellModel.info;
    //按照字母排序
    columns = [columns sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加数据" message:@"输入框字段对于的值" preferredStyle:UIAlertControllerStyleAlert];
    WeakSelf
    for (int i = 0; i < columns.count; i++) {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = columns[i];
            textField.text = [NSString stringWithFormat:@"%@",values[i]];
        }];
    }
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (UITextField *textField in alert.textFields) {
            NSString *value = textField.text;
            NSString *key = textField.placeholder;
            if (value.length > 0){
                [dict setObject:value forKey:key];
            }
        }
        NSArray *items = [database selectTableWithTableName:weakSelf.model.title];
        NSObject *object = items[indexPath.row - 1];
        BOOL success = [database updateTableWithTableName:weakSelf.model.title contents:object update:dict];
        if (success) {
            [weakSelf showSuccessWithMsg:@"数据修改成功"];
            [weakSelf reloadDatas];
        }else{
            NSString *error = [database lastErrorMessage];
            [weakSelf showError:[@"数据修改失败" addString:error]];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //to do
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    KKDatabase *database = [KKDatabase databaseWithPath:self.model.value];
    //内容
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    //遍历表单所有字段
    NSArray *allkeys = [database getFieldsWithTableName:self.model.title];
    //按照字母排序
    allkeys = [allkeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    [datas addObject:allkeys];
    //构造cell
    NSArray *items = [database selectTableWithTableName:self.model.title];
    //获取表单内容
    for (NSDictionary *item in items) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (NSString *key in allkeys) {
            NSObject *value = [item objectForKey:key];
            if (value == [NSNull null]) {
                [items addObject:@""];
            }else{
                [items addObject:value?:@""];
            }
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
    KKDatebaseFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKDatebaseFormTableViewCell"];
    cell.cellModel = cellModel;
    WeakSelf
    cell.whenScrollViewDidScroll = ^(UIScrollView *scrollView) {
        NSArray *cells = [weakSelf.tableView visibleCells];
        for (KKDatebaseFormTableViewCell *tc in cells) {
            tc.contentOffset = scrollView.contentOffset;
        }
        weakSelf.contentOffset = scrollView.contentOffset;
    };
    cell.whenSelectItemClick = ^(KKDatebaseFormTableViewCell *cell, NSIndexPath *collectionViewCellIndexPath) {
        [weakSelf tableView:tableView didSelectRowAtIndexPath:indexPath];
    };
    cell.contentOffset = self.contentOffset;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedWidth(44.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    if (indexPath.row != 0) {
        [self whenAcitonDatabase:indexPath];
    }
}
#pragma mark - aciton
@end
