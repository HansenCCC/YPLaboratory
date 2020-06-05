//
//  KKThirdFunctionViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 6/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKThirdFunctionViewController.h"
#import "KKThirdFunctionTableViewCell.h"//cell

//微信SDK
#import "WXApi.h"

//支付宝SDK
#import <AlipaySDK/AlipaySDK.h>

@interface KKThirdFunctionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation KKThirdFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第三方分享&登陆&支付";
    self.datas = [[NSMutableArray alloc] init];
    [self setupSubvuews];
    [self updateDatas];
}
- (void)setupSubvuews{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //
    self.tableView.backgroundColor = KKColor_FFFFFF;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKThirdFunctionTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKThirdFunctionTableViewCell"];
}
- (void)updateDatas{
    [self.datas removeAllObjects];
    //to do
    NSArray *items = @[@"微信",@"QQ",@"新浪",@"支付宝",];
    for (NSString *value in items) {
        KKLabelModel *cellModel = [[KKLabelModel alloc] initWithTitle:value value:nil];
        [self.datas addObject:cellModel];
    }
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
    KKThirdFunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKThirdFunctionTableViewCell"];
    cell.cellModel = cellModel;
    WeakSelf
    cell.whenActionClick = ^(NSInteger index) {
        if (indexPath.row == 0) {
            if (index == 0) {
                [weakSelf wechatThirdLogin];
            }else if(index ==  1){
                
            }else if(index == 2){
                
            }
        }else if (indexPath.row == 1) {
            if (index == 0) {
                
            }else if(index ==  1){
                
            }else if(index == 2){
                
            }
        }else if (indexPath.row == 2) {
            if (index == 0) {
                
            }else if(index ==  1){
                
            }else if(index == 2){
                
            }
        }else if (indexPath.row == 3) {
            if (index == 0) {
                [self aliThirdLogin];
            }else if(index ==  1){
                [self aliThirdShare];
            }else if(index == 2){
                [self aliThirdPay];
            }
        }
    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedWidth(45.f);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        [self mainQueueTableView:tableView didSelectRowAtIndexPath:indexPath];
    });
}
- (void)mainQueueTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    
}
#pragma mark - 微信
- (void)wechatThirdLogin{
    [WXApi registerApp:@"" universalLink:@""];
//    [WXApi registerApp:@"wxfb1ca05fe8aa2dd2"];
//    //构造SendAuthReq结构体
//    SendAuthReq *req = [[SendAuthReq alloc]init];
//    req.scope = @"snsapi_userinfo";
//    req.state = @"QMKKXProduct";
//    //第三方向微信终端发送一个SendAuthReq消息结构
//    [WXApi sendReq:req];
}
#pragma mark - QQ


#pragma mark - 微博


#pragma mark - 支付宝
- (void)aliThirdLogin{
    //apiname=com.alipay.account.auth&app_id=2016921659043620254&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=2088294695624536&product_id=APP_FAST_LOGIN&scope=kuaijie&target_id=2014324xxxx&sign=H14sOpDw5J96o7fyM9Mdr2a62fX7TtZFacYZijRW1TL9lMR2FfjaMQfSF55RvIoNamHFiejDAIDo4Igbp0FJNLlubhidElERz6%2BogPrBoO6X%2FdA5%2Fj6kQHYiZHcuD9AAgtjhQnRQA2M%3D&sign_type=RSA
    //支付宝寻物启事appid=2021001145615178
    NSString *infoStr = @"apiname=com.alipay.account.auth&app_id=2016921659043620254&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=2088294695624536&product_id=APP_FAST_LOGIN&scope=kuaijie&target_id=2014324xxxx&sign=H14sOpDw5J96o7fyM9Mdr2a62fX7TtZFacYZijRW1TL9lMR2FfjaMQfSF55RvIoNamHFiejDAIDo4Igbp0FJNLlubhidElERz6%2BogPrBoO6X%2FdA5%2Fj6kQHYiZHcuD9AAgtjhQnRQA2M%3D&sign_type=RSA";//infoStr 后台返回，当前信息网络找的
    [[AlipaySDK defaultService] auth_V2WithInfo:infoStr fromScheme:@"chsqmkkx" callback:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
    }];
}
- (void)aliThirdShare{
    [self showError:@"支付宝支付、分享、登录功能搁置\n支付包注册APP失败，原因需要营业执照。"];
}
- (void)aliThirdPay{
    //apiname=com.alipay.account.auth&app_id=2016921659043620254&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=2088294695624536&product_id=APP_FAST_LOGIN&scope=kuaijie&target_id=2014324xxxx&sign=H14sOpDw5J96o7fyM9Mdr2a62fX7TtZFacYZijRW1TL9lMR2FfjaMQfSF55RvIoNamHFiejDAIDo4Igbp0FJNLlubhidElERz6%2BogPrBoO6X%2FdA5%2Fj6kQHYiZHcuD9AAgtjhQnRQA2M%3D&sign_type=RSA
    //支付宝寻物启事appid=2021001145615178
    NSString *infoStr = @"apiname=com.alipay.account.auth&app_id=2016921659043620254&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=2088294695624536&product_id=APP_FAST_LOGIN&scope=kuaijie&target_id=2014324xxxx&sign=H14sOpDw5J96o7fyM9Mdr2a62fX7TtZFacYZijRW1TL9lMR2FfjaMQfSF55RvIoNamHFiejDAIDo4Igbp0FJNLlubhidElERz6%2BogPrBoO6X%2FdA5%2Fj6kQHYiZHcuD9AAgtjhQnRQA2M%3D&sign_type=RSA";//infoStr 后台返回，当前信息网络找的
    [[AlipaySDK defaultService] payOrder:infoStr fromScheme:@"chsqmkkx" callback:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
    }];
}

@end
