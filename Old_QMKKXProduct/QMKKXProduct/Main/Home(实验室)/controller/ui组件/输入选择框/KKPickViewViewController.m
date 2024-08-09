//
//  KKPickViewViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 11/24/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKPickViewViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"

@interface KKPickViewViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KKPickViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"输入选择框";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    //构造cell
    KKLabelModel *c1 = [[KKLabelModel alloc] initWithTitle:@"时分(HH:mm)" value:nil];
    c1.placeholder = @"HH:mm";
    KKLabelModel *c2 = [[KKLabelModel alloc] initWithTitle:@"年月日(yyyy-MM-dd)" value:nil];
    c2.placeholder = @"yyyy-MM-dd";
    KKLabelModel *c3 = [[KKLabelModel alloc] initWithTitle:@"月日时分(MM-dd HH:mm)" value:nil];
    c3.placeholder = @"MM-dd HH:mm";
    KKLabelModel *c4 = [[KKLabelModel alloc] initWithTitle:@"倒计时(HH:mm)" value:nil];
    c4.placeholder = @"HH:mm";
    KKLabelModel *c5 = [[KKLabelModel alloc] initWithTitle:@"字体选择" value:nil];
    c5.placeholder = @"fonts";
    KKLabelModel *c6 = [[KKLabelModel alloc] initWithTitle:@"颜色选择" value:nil];
    c6.placeholder = @"colors";
    KKLabelModel *c7 = [[KKLabelModel alloc] initWithTitle:@"性别选择" value:nil];
    c7.placeholder = @"sex";
    KKLabelModel *c8 = [[KKLabelModel alloc] initWithTitle:@"地址选择" value:nil];
    c8.placeholder = @"address";
    [self.datas addObjectsFromArray:@[c1,c2,c3,c4,c5,c6,c7,c8]];
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    WeakSelf
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if ([cellModel.title isEqualToString:@"时分(HH:mm)"]) {
        NSString *value = cellModel.value;
        NSDate *date = [value dateWithFormat:cellModel.placeholder];
        [self presentDatePicker:date datePickerMode:UIDatePickerModeTime complete:^(NSDate *date) {
            NSString *value = [date stringWithDateFormat:cellModel.placeholder];
            cellModel.value = value;
            [weakSelf.tableView reloadData];
        }];
    }else if ([cellModel.title isEqualToString:@"年月日(yyyy-MM-dd)"]) {
        NSString *value = cellModel.value;
        NSDate *date = [value dateWithFormat:cellModel.placeholder];
        [self presentDatePicker:date datePickerMode:UIDatePickerModeDate complete:^(NSDate *date) {
            NSString *value = [date stringWithDateFormat:cellModel.placeholder];
            cellModel.value = value;
            [weakSelf.tableView reloadData];
        }];
    }else if ([cellModel.title isEqualToString:@"月日时分(MM-dd HH:mm)"]) {
        NSString *value = cellModel.value;
        NSDate *date = [value dateWithFormat:cellModel.placeholder];
        [self presentDatePicker:date datePickerMode:UIDatePickerModeDateAndTime complete:^(NSDate *date) {
            NSString *value = [date stringWithDateFormat:cellModel.placeholder];
            cellModel.value = value;
            [weakSelf.tableView reloadData];
        }];
    }else if ([cellModel.title isEqualToString:@"倒计时(HH:mm)"]) {
        NSString *value = cellModel.value;
        NSDate *date = [value dateWithFormat:cellModel.placeholder];
        [self presentDatePicker:date datePickerMode:UIDatePickerModeCountDownTimer complete:^(NSDate *date) {
            NSString *value = [date stringWithDateFormat:cellModel.placeholder];
            cellModel.value = value;
            [weakSelf.tableView reloadData];
        }];
    }else if ([cellModel.title isEqualToString:@"字体选择"]) {
        NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[UIFont familyNames]];
        NSInteger index = [items indexOfObject:cellModel.value];
        KKPickerAlert *alert = [[KKPickerAlert alloc] initWithTitles:items];
        alert.index = index;
        alert.confirmBlock = ^(NSInteger index) {
            cellModel.value = items[index];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:alert animated:NO completion:nil];
    }else if ([cellModel.title isEqualToString:@"颜色选择"]) {
        NSArray *items = [UIColor commonColors].allKeys;
        NSInteger index = [items indexOfObject:cellModel.value];
        KKColorPickAlert *alert = [[KKColorPickAlert alloc] initWithTitles:items];
        alert.index = index;
        alert.confirmBlock = ^(NSInteger index) {
            cellModel.value = items[index];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:alert animated:NO completion:nil];
    }else if ([cellModel.title isEqualToString:@"性别选择"]) {
        NSMutableArray *items = [[NSMutableArray alloc] initWithArray:@[@"男",@"女",]];
        NSInteger index = [items indexOfObject:cellModel.value];
        KKPickerAlert *alert = [[KKPickerAlert alloc] initWithTitles:items];
        alert.index = index;
        alert.confirmBlock = ^(NSInteger index) {
            cellModel.value = items[index];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:alert animated:NO completion:nil];
    }else if([cellModel.title isEqualToString:@"地址选择"]) {
        NSInteger pIndex = 0;
        NSInteger cIndex = 0;
        NSInteger dIndex = 0;
        if (cellModel.info) {
            NSArray *items = cellModel.info;
            if (items.count >= 3) {
                pIndex = [NSString stringWithFormat:@"%@",items[0]].intValue;
                cIndex = [NSString stringWithFormat:@"%@",items[1]].intValue;
                dIndex = [NSString stringWithFormat:@"%@",items[2]].intValue;
            }
        }
        KKAddressPickAlert *alert = [[KKAddressPickAlert alloc] initWithProvinceIndex:pIndex cityIndex:cIndex districtIndex:dIndex];
        alert.confirmBlock = ^(NSString *province, NSString *city, NSString *area, NSString *pPostalCode, NSString *cPostalCode, NSString *dPostalCode, NSInteger pIndex, NSInteger cIndex, NSInteger dIndex) {
            cellModel.info = @[@(pIndex),@(cIndex),@(dIndex)];
            cellModel.value = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:alert animated:NO completion:nil];
    }
}
- (void)presentDatePicker:(NSDate *)date datePickerMode:(UIDatePickerMode )datePickerMode complete:(KKDatePickerAlertConfirmBlock )complete{
    KKDatePickerAlert *alert = [[KKDatePickerAlert alloc] initWithDate:date];
    alert.datePickerMode = datePickerMode;
    alert.confirmBlock = complete;
    [self presentViewController:alert animated:NO completion:nil];
}
@end
