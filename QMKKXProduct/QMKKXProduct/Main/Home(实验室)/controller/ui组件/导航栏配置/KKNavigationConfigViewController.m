//
//  KKNavigationConfigViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 11/23/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKNavigationConfigViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"

@interface KKNavigationConfigViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) KKLabelModel *translucentModel;//是否半透明
@property (strong, nonatomic) KKLabelModel *tintColorModel;//tint颜色
@property (strong, nonatomic) KKLabelModel *barTintColorModel;//背景颜色
@property (strong, nonatomic) KKLabelModel *bottomLineModel;//底部线条
@property (strong, nonatomic) KKLabelModel *transparentModel;//是否透明
@property (strong, nonatomic) KKLabelModel *backgroundColorModel;//当前视图背景颜色
@property (strong, nonatomic) KKLabelModel *titleColorModel;//导航title颜色
@property (strong, nonatomic) KKLabelModel *titleFontNumberModel;//导航title字体大小
@property (strong, nonatomic) KKLabelModel *boldModel;//是否加粗

@end

@implementation KKNavigationConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"导航栏配置";
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)backItemClick{
    //重置导航
    [self whenRightClickAction:nil];
    [super backItemClick];
}
- (void)setupSubviews{
    self.view.backgroundColor = [UIColor redColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKSwitchTableViewCell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(whenRightClickAction:)];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    UINavigationController *nav = [[UINavigationController alloc] init];
    BOOL translucent = nav.navigationBar.translucent;//是否半透明
    BOOL bottomLine = YES;//是否显示底部线条
    BOOL transparent = NO;//是否透明
    NSString *backgroundColorValue = @"";
    UIColor *tintColor = nav.navigationBar.tintColor;//导航items颜色
    UIColor *barTintColor = nav.navigationBar.barTintColor;//导航背景颜色
    NSNumber *titleFontNumber = @(15);//导航title字体大小
    BOOL bold = YES;//是否加粗
    //
    NSDictionary *commonColorsDic = [UIColor commonColors];
    NSArray *keys = [commonColorsDic allKeys];
    NSString *tintColorValue = @"";
    NSString *barTintColorValue = @"";
    NSString *titleColorValue = @"blackColor";//默认黑色
    for(NSString *key in keys){
        UIColor *value = commonColorsDic[key];
        if([value isEqual:tintColor]){
            tintColorValue = key;
        }else if([value isEqual:barTintColor]){
            barTintColorValue = key;
        }
    }
    //构造cell
    KKLabelModel *c1 = [[KKLabelModel alloc] initWithTitle:@"导航是否半透明" value:@(translucent).stringValue];
    c1.info = [KKSwitchTableViewCell class];
    KKLabelModel *c2 = [[KKLabelModel alloc] initWithTitle:@"导航items颜色" value:tintColorValue];
    c2.placeholder = @"color";
    KKLabelModel *c3 = [[KKLabelModel alloc] initWithTitle:@"导航背景颜色" value:barTintColorValue];
    c3.placeholder = @"color";
    KKLabelModel *c4 = [[KKLabelModel alloc] initWithTitle:@"导航是否显示底部线条" value:@(bottomLine).stringValue];
    c4.info = [KKSwitchTableViewCell class];
    KKLabelModel *c5 = [[KKLabelModel alloc] initWithTitle:@"导航是否全透明" value:@(transparent).stringValue];
    c5.info = [KKSwitchTableViewCell class];
    KKLabelModel *c6 = [[KKLabelModel alloc] initWithTitle:@"当前控制器背景颜色" value:backgroundColorValue];
    c6.placeholder = @"color";
    KKLabelModel *c7 = [[KKLabelModel alloc] initWithTitle:@"导航字体颜色" value:titleColorValue];
    c7.placeholder = @"color";
    KKLabelModel *c8 = [[KKLabelModel alloc] initWithTitle:@"导航字体大小" value:titleFontNumber.stringValue];
    KKLabelModel *c9 = [[KKLabelModel alloc] initWithTitle:@"导航字体是否加粗" value:@(bold).stringValue];
    c9.info = [KKSwitchTableViewCell class];
    
    [self.datas addObjectsFromArray:@[c6,c1,c5,c2,c3,c4,c7,c8,c9]];
    self.translucentModel = c1;//是否半透明
    self.tintColorModel = c2;//tint颜色
    self.barTintColorModel = c3;//背景颜色
    self.bottomLineModel = c4;//底部线条
    self.transparentModel = c5;//透明
    self.backgroundColorModel = c6;//当前控制器背景颜色
    self.titleColorModel = c7;//导航字体颜色
    self.titleFontNumberModel = c8;//导航字体大小
    self.boldModel = c9;//导航字体是否加粗
    //
    [self updateSetConfig];
    [self.tableView reloadData];
}
//更新导航配置
- (void)updateSetConfig{
    UINavigationController *nav = [[UINavigationController alloc] init];
    BOOL translucent = self.translucentModel.value.boolValue;//是否半透明
    BOOL bottomLine = self.bottomLineModel.value.boolValue;//是否显示底部线条
    BOOL transparent = self.transparentModel.value.boolValue;//是否透明
    NSDictionary *commonColorsDic = [UIColor commonColors];
    UIColor *tintColor = commonColorsDic[self.tintColorModel.value];//导航items颜色
    UIColor *barTintColor = commonColorsDic[self.barTintColorModel.value];//导航背景颜色
    UIColor *backgroundColor = commonColorsDic[self.backgroundColorModel.value];//当前控制器背景颜色
    UIColor *titleColor = commonColorsDic[self.titleColorModel.value];//导航字体颜色
    NSNumber *titleFontNumber = self.titleFontNumberModel.value.numberOfInteger;//导航title字体大小
    BOOL bold = self.boldModel.value.boolValue;//是否加粗
    //导航字体
    UIFont *font = bold?AdaptedBoldFontSize(titleFontNumber.floatValue):AdaptedFontSize(titleFontNumber.floatValue);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,
    NSFontAttributeName:font}];
    //背景颜色
    self.view.backgroundColor = backgroundColor;
    if (transparent) {
        //完全透明
        [self.navigationController.navigationBar setNavigationBarTransparency:YES];
    }else{
        //不透明
        [self.navigationController.navigationBar setNavigationBarTransparency:NO];
    }
    //是否半透明
    self.navigationController.navigationBar.translucent = translucent;
    //导航items颜色
    if (tintColor) {
        self.navigationController.navigationBar.tintColor = tintColor;
    }else{
        self.navigationController.navigationBar.tintColor = nav.navigationBar.tintColor;
    }
    //导航背景颜色
    if (barTintColor) {
        self.navigationController.navigationBar.barTintColor = barTintColor;
    }else{
        self.navigationController.navigationBar.barTintColor = nav.navigationBar.barTintColor;
    }
    if (bottomLine) {
        //显示条线
        UIImage *shadowImage = nav.navigationBar.shadowImage;
        [self.navigationController.navigationBar  setShadowImage:shadowImage];
    }else{
        //不显示条线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}
//重置导航状态
- (void)whenRightClickAction:(id)sender{
    [self reloadDatas];
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
    Class vcClass = cellModel.info;
    if (vcClass == [KKSwitchTableViewCell class]) {
        KKSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKSwitchTableViewCell"];
        cell.cellModel = cellModel;
        WeakSelf
        cell.whenChangeState = ^(BOOL isOn, KKSwitchTableViewCell *copyCell) {
            //to do
            copyCell.cellModel.value = @(isOn).stringValue;
            [weakSelf updateSetConfig];
            [weakSelf.tableView reloadData];
        };
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
    return AdaptedWidth(44.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    //取消选中状态
    WeakSelf
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if ([cellModel.title rangeOfString:@"颜色"].location != NSNotFound) {
        //选择导航items颜色
        NSArray *items = [UIColor commonColors].allKeys;
        NSInteger index = [items indexOfObject:cellModel.value];
        KKColorPickAlert *alert = [[KKColorPickAlert alloc] initWithTitles:items];
        alert.index = index;
        alert.confirmBlock = ^(NSInteger index) {
            cellModel.value = items[index];
            [weakSelf updateSetConfig];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:alert animated:NO completion:nil];
    }else if([cellModel.title rangeOfString:@"字体"].location != NSNotFound){
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; i++) {
            [items addObject:@(i).stringValue];
        }
        NSInteger index = [items indexOfObject:cellModel.value];
        KKPickerAlert *alert = [[KKPickerAlert alloc] initWithTitles:items];
        alert.index = index;
        alert.confirmBlock = ^(NSInteger index) {
            cellModel.value = items[index];
            [weakSelf updateSetConfig];
            [weakSelf.tableView reloadData];
        };
        [self presentViewController:alert animated:NO completion:nil];
    }
}
@end
