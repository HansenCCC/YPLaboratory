//
//  KKPostViewController.m
//  KKLAFProduct
//
//  Created by Hansen on 4/10/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKPostViewController.h"
#import "KKPostHeaderTableViewCell.h"
#import "KKPostSectionTableViewCell.h"
#import "KKPostFillTableViewCell.h"
#import "KKPostImageListTableViewCell.h"
#import "KKPostFormTableViewCell.h"
#import "KKPostFooterView.h"
#import "KKUploadImageService.h"
#import "KKNetworkPostedService.h"//请求

@interface KKPostViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;
@property (strong, nonatomic) KKPostFooterView *footerView;
@property (strong, nonatomic) KKLabelModel *fillModel;//你想发表什么？
@property (strong, nonatomic) KKLabelModel *imagesModel;//图片选择
@property (strong, nonatomic) KKLabelModel *adressLongitudeAndLatitudeModel;//经纬度详细地址

@end

@implementation KKPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
}
- (void)backItemClick{
    [super backItemClick];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //添加返回按钮
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = KKColor_1A4FB9;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //添加返回按钮
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barTintColor = nil;
}
- (void)setupSubvuews{
    //left
    UIButton *leftButton = [UIButton buttonWithFont:[UIFont systemFontOfSize:15] textColor:KKColor_FFFFFF forState:UIControlStateNormal];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 50.f, 30.f);
    [leftButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //right
    UIButton *rightButton = [UIButton buttonWithFont:[UIFont systemFontOfSize:15] textColor:KKColor_FFFFFF forState:UIControlStateNormal];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    rightButton.layer.cornerRadius = 15.f;
    rightButton.layer.borderColor = KKColor_FFFFFF.CGColor;
    rightButton.layer.borderWidth = 2.f;
    rightButton.frame = CGRectMake(0, 0, 70.f, 30.f);
    [rightButton addTarget:self action:@selector(whenSendClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KKColor_F2F2F7;
    KKPostFooterView *footerView = [[KKPostFooterView alloc] initWithFrame:CGRectMake(0, 0, 0, AdaptedWidth(200.f))];
    WeakSelf
    footerView.whenTapAciton = ^(NSInteger index) {
        NSString *url = [API_H5HOST addString:API_HTML_POST];
        [[KKUser shareInstance] presentWebViewContoller:weakSelf url:url complete:nil];
    };
    self.footerView = footerView;
    self.tableView.tableFooterView = footerView;
    [self.view addSubview:self.tableView];
    //
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[KKPostHeaderTableViewCell class] forCellReuseIdentifier:@"KKPostHeaderTableViewCell"];
    [self.tableView registerClass:[KKPostSectionTableViewCell class] forCellReuseIdentifier:@"KKPostSectionTableViewCell"];
    [self.tableView registerClass:[KKPostFillTableViewCell class] forCellReuseIdentifier:@"KKPostFillTableViewCell"];
    [self.tableView registerClass:[KKPostImageListTableViewCell class] forCellReuseIdentifier:@"KKPostImageListTableViewCell"];
    [self.tableView registerClass:[KKPostFormTableViewCell class] forCellReuseIdentifier:@"KKPostFormTableViewCell"];
}
- (void)updateDatas{
    [self.datas removeAllObjects];
    //
    NSString *value1 = @"发帖需遵守";
    NSString *value2 = @"《iOS实验室发布须知》";
    NSString *value3 = [value1 addString:value2];
    NSRange range = [value3 rangeOfString:value2];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:value3];
    [attributedText addAttribute:NSForegroundColorAttributeName value:KKColor_1A4FB9 range:range];
    self.footerView.attributedText = attributedText;
    //说明
    [self.datas addObject:[self setupSectionModel:@"你想发表什么？"]];
    [self.datas addObject:self.fillModel];
    [self.datas addObject:self.imagesModel];
    //补充
    [self.datas addObject:[self setupSectionModel:@"补充"]];
    [self.datas addObject:self.adressLongitudeAndLatitudeModel];
    //
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if (cellModel.cellClass) {
        NSString *classString = NSStringFromClass(cellModel.cellClass);
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:classString];
        [cell kk_extensionCellModel:cellModel];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",cellModel];
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    Class cellClass = cellModel.cellClass;
    UITableViewCell *cell = [UITableViewCell kk_extensionSingleCell:cellClass];
    CGFloat height = [cell kk_extensionCellHeight:cellModel tableView:tableView];
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    KKLabelModel *cellModel = self.datas[indexPath.row];
    if ([cellModel.title isEqualToString:@"经纬度"]){
        [self pushAdressLongitudeAndLatitudeAlert];
    }
}
#pragma mark - action
//跳转地址经纬度选择
- (void)pushAdressLongitudeAndLatitudeAlert{
    WeakSelf
    [KKMapAlert showMapComplete:^(KKAlertViewController *controler, NSInteger index) {
        KKMapAlert *alert = (KKMapAlert *)controler;
        if (index == 0) {
            [controler dismissViewControllerCompletion:nil];
            return;
        }
        NSLog(@"%f-%f",alert.centerAnnotation.coordinate.latitude,alert.centerAnnotation.coordinate.longitude);
        weakSelf.adressLongitudeAndLatitudeModel.info = @{@"latitude":@(alert.centerAnnotation.coordinate.latitude),@"longitude":@(alert.centerAnnotation.coordinate.longitude)};
        NSDictionary *info = weakSelf.adressLongitudeAndLatitudeModel.info;
        if ([info isKindOfClass:[NSDictionary class]]) {
            NSNumber *longitudeNumber = info[@"longitude"];
            NSNumber *latitudeNumber = info[@"latitude"];
            NSString *longitude = [NSString stringWithFormat:@"%.6f",longitudeNumber.floatValue];
            NSString *latitude = [NSString stringWithFormat:@"%.6f",latitudeNumber.floatValue];
            weakSelf.adressLongitudeAndLatitudeModel.value = [NSString stringWithFormat:@"{%@,%@}",longitude,latitude];
        }
        [weakSelf.tableView reloadData];
        [controler dismissViewControllerCompletion:nil];
    }];
}
#pragma mark - lazy load
- (KKLabelModel *)setupSectionModel:(NSString *)title{
    KKLabelModel *model = [[KKLabelModel alloc] initWithTitle:title value:nil];
    model.cellClass = [KKPostSectionTableViewCell class];
    return model;
}
- (KKLabelModel *)fillModel{
    if (!_fillModel) {
        _fillModel = [[KKLabelModel alloc] init];
        _fillModel.cellClass = [KKPostFillTableViewCell class];
        _fillModel.isShowLine = NO;
        _fillModel.isShowStar = YES;
        _fillModel.isCanEdit = YES;
        _fillModel.placeholder = @"不得发布任何违反有关法律规定之信息";
    }
    return _fillModel;
}
- (KKLabelModel *)imagesModel{
    if (!_imagesModel) {
        _imagesModel = [[KKLabelModel alloc] init];
        _imagesModel.cellClass = [KKPostImageListTableViewCell class];
    }
    return _imagesModel;
}
- (KKLabelModel *)adressLongitudeAndLatitudeModel{
    if (!_adressLongitudeAndLatitudeModel) {
        _adressLongitudeAndLatitudeModel = [[KKLabelModel alloc] init];
        _adressLongitudeAndLatitudeModel.cellClass = [KKPostFormTableViewCell class];
        _adressLongitudeAndLatitudeModel.isShowLine = YES;
        _adressLongitudeAndLatitudeModel.isShowStar = NO;
        _adressLongitudeAndLatitudeModel.isCanEdit = NO;
        _adressLongitudeAndLatitudeModel.title = @"经纬度";
        _adressLongitudeAndLatitudeModel.rightImageName = @"kk_icon_arrowRight";
        _adressLongitudeAndLatitudeModel.rightImageSize = CGSizeMake(AdaptedWidth(25.f), AdaptedWidth(25.f));
        _adressLongitudeAndLatitudeModel.placeholder = @"标出发帖位置";
    }
    return _adressLongitudeAndLatitudeModel;
}
#pragma mark - 发送失物信息
//点击发帖按钮
- (void)whenSendClick{
    //结束试图编辑状态
    [self.view endEditing:YES];
    //to do
    NSString *domain = @"";
    if(self.fillModel.value.length == 0){
        domain = @"请填写内容，再点击发布！";
    }
    if (domain.length > 0) {
        [self showError:domain];
        return;
    }
    NSArray *images = self.imagesModel.info;
    //
    WeakSelf
    [self showLoadingOnWindow];
    [KKUploadImageService uploadWithImages:images complete:^(BOOL success, NSArray<NSString *> *keys) {
        [weakSelf hideLondingOnWindow];
        [weakSelf sendPostedIssueRequest:keys];
    }];
}
- (void)sendPostedIssueRequest:(NSArray <NSString *>*)images{
    WeakSelf
    KKPostedIssueRequestModel *model = [[KKPostedIssueRequestModel alloc] init];
    model.imgUrls = [images copy];//图片集合
    model.content = self.fillModel.value;//详情
    NSDictionary *info = self.adressLongitudeAndLatitudeModel.info;
    if ([info isKindOfClass:[NSDictionary class]]) {
        NSNumber *longitudeNumber = info[@"longitude"];
        NSNumber *latitudeNumber = info[@"latitude"];
        model.apLatitude = latitudeNumber.stringValue;//维度
        model.apLongitude = longitudeNumber.stringValue;//经度
    }
    //other
#if TARGET_IPHONE_SIMULATOR //模拟器
    NSString *device = [NSString stringWithFormat:@"%@",[NSString getCurrentDeviceModel]];
#elif TARGET_OS_IPHONE //真机
    NSString *device = [NSString stringWithFormat:@"%@",[NSString getCurrentDeviceModel]];
#endif
    NSString *sys = [[UIDevice currentDevice] systemVersion];
    NSString *systemName = [[UIDevice currentDevice] systemName];
    NSString *dateString = [[NSDate date] stringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *identification = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    NSString *batteryLevel = @([[UIDevice currentDevice] batteryLevel]).stringValue;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];//获取当前语言
    NSArray *languageInfo = [userDefaults objectForKey:@"AppleLanguages"];
    [model mj_setKeyValues:[KKNetworkBase NetworkDefaultParam]];
    model.device = device;
    model.sys = sys;
    model.systemName = systemName;
    model.dateString = dateString;
    model.identification = identification;
    model.batteryLevel = batteryLevel;
    model.languageInfo = languageInfo;
    model.ipAddresses = [KKUser shareInstance].ipAddresses;
    //
    [self showLoadingOnWindow];
    [KKNetworkPostedService issueWithRequestModel:model success:^(KKBaseResponse *response) {
        [weakSelf hideLondingOnWindow];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNSNotificationCenterNeedUpdateWorld object:nil];
        [weakSelf showSuccessWithMsg:@"发布成功！"];
        [weakSelf backItemClick];
    } failure:^(NSError *error) {
        [weakSelf showError:error.domain];
        [weakSelf hideLondingOnWindow];
    }];
}

@end
