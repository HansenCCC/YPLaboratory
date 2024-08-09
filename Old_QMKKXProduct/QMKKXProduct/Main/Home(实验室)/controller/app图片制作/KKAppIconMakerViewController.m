//
//  KKAppIconMakerViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKAppIconMakerViewController.h"
#import "KKLabelTableViewCell.h"
#import "KKButtonTableViewCell.h"
#import "KKAppIconTableViewCell.h"
#import "KKAppIconLabelModel.h"
#import "KKAppIconImageView.h"
#import "KKAppIconPreviewViewController.h"

@interface KKAppIconMakerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
//cells
@property (strong, nonatomic) KKAppIconLabelModel *appIconModel;//icon
@property (strong, nonatomic) KKLabelModel *appTitleModel;//文字
@property (strong, nonatomic) KKLabelModel *appTitleColorModel;//文字颜色
@property (strong, nonatomic) KKLabelModel *appTitleBackgroundModel;//文字背景
@property (strong, nonatomic) KKLabelModel *appAddButtonModel;//添加bate
@property (strong, nonatomic) KKLabelModel *appMakeButtonModel;//制作图标
@end

@implementation KKAppIconMakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"App图标制作";
    [self setupSubviews];
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKButtonTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKAppIconTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKAppIconTableViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    NSString *iconFilePath = [KKUser shareInstance].userModel.iconFilePath;
    NSString *betaString = [KKUser shareInstance].userModel.betaString?:@"Beta";
    NSString *betaColor = [KKUser shareInstance].userModel.betaColor?:@"whiteColor";
    NSString *betaBackgroundColor = [KKUser shareInstance].userModel.betaBackgroundColor?:@"redColor";
    //构造cell
    KKAppIconLabelModel *s1m1 = [[KKAppIconLabelModel alloc] initWithTitle:@"App图标" value:nil];
    s1m1.placeholder = @"请选择图标文件：最佳1024*1024尺寸";
    s1m1.filePath = iconFilePath;
    KKLabelModel *s1m2 = [[KKLabelModel alloc] initWithTitle:@"Beta文字" value:betaString];
    s1m2.placeholder = @"beta";
    s1m2.isCanEdit = YES;
    KKLabelModel *s1m3 = [[KKLabelModel alloc] initWithTitle:@"Beta文字颜色" value:betaColor];
    s1m3.placeholder = @"color";
    KKLabelModel *s1m4 = [[KKLabelModel alloc] initWithTitle:@"Beta背景颜色" value:betaBackgroundColor];
    s1m4.placeholder = @"color";
    KKLabelModel *s1m5 = [[KKLabelModel alloc] initWithTitle:@"添加Beta" value:nil];
    KKLabelModel *s1m6 = [[KKLabelModel alloc] initWithTitle:@"制作App图标" value:nil];
    [self.datas addObjectsFromArray:@[s1m1,s1m2,s1m3,s1m4,s1m5,s1m6,]];
    //
    self.appIconModel = s1m1;
    self.appTitleModel = s1m2;
    self.appTitleColorModel = s1m3;
    self.appTitleBackgroundModel = s1m4;
    self.appAddButtonModel = s1m5;
    self.appMakeButtonModel = s1m6;
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
    if([cellModel.title isEqualToString:@"App图标"]){
        KKAppIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKAppIconTableViewCell"];
        cell.cellModel = cellModel;
        return cell;
    }else if([cellModel.title isEqualToString:@"添加Beta"]||[cellModel.title isEqualToString:@"制作App图标"]){
        KKButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKButtonTableViewCell"];
        cell.cellModel = cellModel;
        return cell;
    }else{
        KKLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKLabelTableViewCell"];
        cell.cellModel = cellModel;
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0&&indexPath.section == 0){
        return AdaptedWidth(88.f);
    }
    return AdaptedWidth(44.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //结束编辑
    [self.view endEditing:YES];
    //取消选中状态
    WeakSelf
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if ([cellModel.title isEqualToString:@"App图标"]) {
        //选择图片
        [self pushTextFieldAlertController:cellModel];
    }else if([cellModel.title isEqualToString:@"Beta文字"]){
        KKLabelTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        //点击主动开始编辑
        [cell.textField becomeFirstResponder];
    }else if([cellModel.title isEqualToString:@"Beta文字颜色"]){
        NSArray *items = [UIColor commonColors].allKeys;
        NSInteger index = [items indexOfObject:self.appTitleColorModel.value];
        KKColorPickAlert *alert = [[KKColorPickAlert alloc] initWithTitles:items];
        alert.index = index;
        alert.confirmBlock = ^(NSInteger index) {
            weakSelf.appTitleColorModel.value = items[index];
            [weakSelf.tableView reloadData];
            //储存betaColor记录
            [KKUser shareInstance].userModel.betaColor = items[index];
            [[KKUser shareInstance] saveUserModel];
        };
        [self presentViewController:alert animated:NO completion:nil];
    }else if([cellModel.title isEqualToString:@"Beta背景颜色"]){
        NSArray *items = [UIColor commonColors].allKeys;
        NSInteger index = [items indexOfObject:self.appTitleBackgroundModel.value];
        KKColorPickAlert *alert = [[KKColorPickAlert alloc] initWithTitles:items];
        alert.index = index;
        alert.confirmBlock = ^(NSInteger index) {
            weakSelf.appTitleBackgroundModel.value = items[index];
            [weakSelf.tableView reloadData];
            //储存betaColor记录
            [KKUser shareInstance].userModel.betaBackgroundColor = items[index];
            [[KKUser shareInstance] saveUserModel];
        };
        [self presentViewController:alert animated:NO completion:nil];
    }else if([cellModel.title isEqualToString:@"添加Beta"]){
        //图片添加beta
        UIImage *originIconImage = self.appIconModel.originIconImage;
        NSString *title = self.appTitleModel.value;
        UIColor *textColor = [[UIColor commonColors] objectForKey:self.appTitleColorModel.value];
        UIColor *textBackgroundColor = [[UIColor commonColors] objectForKey:self.appTitleBackgroundModel.value];
        UIImage *iconImage = [KKAppIconImageView imageWithImage:originIconImage text:title textColor:textColor textBackgroundColor:textBackgroundColor];
        self.appIconModel.iconImage = iconImage;
        [self.tableView reloadData];
    }else if([cellModel.title isEqualToString:@"制作App图标"]){
        //制作App图标
        [self pushAppIconPreviewViewController];
    }
}

#pragma mark - action
//输入本地图标路径
- (void)pushTextFieldAlertController:(KKLabelModel *)labelModel{
    WeakSelf
    KKAppIconLabelModel *cellModel = (KKAppIconLabelModel *)labelModel;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入图标本地路径" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = cellModel.filePath;
        textField.placeholder = cellModel.placeholder;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        cellModel.filePath = textField.text;
        cellModel.iconImage = nil;
        [weakSelf.tableView reloadData];
        //储存iconFilePath记录
        [KKUser shareInstance].userModel.iconFilePath = textField.text;
        [[KKUser shareInstance] saveUserModel];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//跳转制作图标页面，并预览图
- (void)pushAppIconPreviewViewController{
    UIImage *iconImage = self.appIconModel.iconImage;
    NSString *iconPath = self.appIconModel.filePath?:@"";
    KKAppIconPreviewViewController *vc = [[KKAppIconPreviewViewController alloc] initWithIconImage:iconImage];
    vc.iconPath = iconPath;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
