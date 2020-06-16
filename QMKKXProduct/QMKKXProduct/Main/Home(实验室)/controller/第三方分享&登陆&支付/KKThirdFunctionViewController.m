//
//  KKThirdFunctionViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 6/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKThirdFunctionViewController.h"
#import "KKThirdFunctionTableViewCell.h"//cell
#import "KKPayManager.h"//支付管理

//微信SDK
#import "WXApi.h"

//支付宝SDK
#import <AlipaySDK/AlipaySDK.h>

/*
 ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
 没有注册公司，各个平台很难注册应用程序，该功能搁置处理
 
 
 //apiname=com.alipay.account.auth&app_id=2016921659043620254&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=2088294695624536&product_id=APP_FAST_LOGIN&scope=kuaijie&target_id=2014324xxxx&sign=H14sOpDw5J96o7fyM9Mdr2a62fX7TtZFacYZijRW1TL9lMR2FfjaMQfSF55RvIoNamHFiejDAIDo4Igbp0FJNLlubhidElERz6%2BogPrBoO6X%2FdA5%2Fj6kQHYiZHcuD9AAgtjhQnRQA2M%3D&sign_type=RSA
 //支付宝寻物启事appid=2021001145615178
 NSString *infoStr = @"apiname=com.alipay.account.auth&app_id=2016921659043620254&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=2088294695624536&product_id=APP_FAST_LOGIN&scope=kuaijie&target_id=2014324xxxx&sign=H14sOpDw5J96o7fyM9Mdr2a62fX7TtZFacYZijRW1TL9lMR2FfjaMQfSF55RvIoNamHFiejDAIDo4Igbp0FJNLlubhidElERz6%2BogPrBoO6X%2FdA5%2Fj6kQHYiZHcuD9AAgtjhQnRQA2M%3D&sign_type=RSA";//infoStr 后台返回，当前信息网络找的
 [[AlipaySDK defaultService] payOrder:infoStr fromScheme:@"chsqmkkx" callback:^(NSDictionary *resultDic) {
     NSLog(@"%@",resultDic);
 }];
 ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
 
 */


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
    [self addObserverNotification];
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
- (void)addObserverNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenReceivedAliPayNotification:) name:kNSNotificationCenterQMKKXAliPay object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenReceivedAliLoginNotification:) name:kNSNotificationCenterQMKKXAliLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenReceivedWeChatPayNotification:) name:kNSNotificationCenterQMKKXWeChatPay object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenReceivedWeChatLoginNotification:) name:kNSNotificationCenterQMKKXWeChatLogin object:nil];
}
//收到支付宝支付回调
- (void)whenReceivedAliPayNotification:(NSNotification *)sender{
    id object = sender.object;
    if ([object isKindOfClass:[NSError class]]) {
        NSError *error = object;
        [self showError:error.domain];
    }else{
        [self showSuccessWithMsg:@"支付宝支付成功！"];
    }
}
//收到支付宝登录回调
- (void)whenReceivedAliLoginNotification:(NSNotification *)sender{
    id object = sender.object;
    if ([object isKindOfClass:[NSError class]]) {
        NSError *error = object;
        [self showError:error.domain];
    }else{
        [self showSuccessWithMsg:@"支付宝登录成功！"];
    }
}
//收到微信支付回调
- (void)whenReceivedWeChatPayNotification:(NSNotification *)sender{
    id object = sender.object;
    if ([object isKindOfClass:[NSError class]]) {
        NSError *error = object;
        [self showError:error.domain];
    }else{
        [self showSuccessWithMsg:@"微信支付成功！"];
    }
}
//收到微信授权登录回调
- (void)whenReceivedWeChatLoginNotification:(NSNotification *)sender{
    id object = sender.object;
    if ([object isKindOfClass:[NSError class]]) {
        NSError *error = object;
        [self showError:error.domain];
    }else if([object isKindOfClass:[NSString class]]){
        NSString *openCode = object;
        [self showSuccessWithMsg:[NSString stringWithFormat:@"微信登录成功！\n获取code=%@",openCode]];
    }
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
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
                [weakSelf wechatThirdShare];
            }else if(index == 2){
                [weakSelf wechatThirdPay];
            }
        }else if (indexPath.row == 1) {
            if (index == 0) {
                [weakSelf qqThirdLogin];
            }else if(index ==  1){
                [weakSelf qqThirdShare];
            }else if(index == 2){
                [weakSelf qqThirdPay];
            }
        }else if (indexPath.row == 2) {
            if (index == 0) {
                [weakSelf sinaThirdLogin];
            }else if(index ==  1){
                [weakSelf sinaThirdShare];
            }else if(index == 2){
                [weakSelf sinaThirdPay];
            }
        }else if (indexPath.row == 3) {
            if (index == 0) {
                [weakSelf aliThirdLogin];
            }else if(index ==  1){
                [weakSelf aliThirdShare];
            }else if(index == 2){
                [weakSelf aliThirdPay];
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
    //微信登录
    //bee_openid = wx0647716e2f53ac8b
    WeakSelf
    [[KKPayManager sharedInstance] weChatOauthComplete:^(BOOL success, id info) {
        if (success) {
            //等待通知回调
        }else{
            [weakSelf showError:@"微信登录失败！"];
        }
    }];
}
- (void)wechatThirdShare{
    //
    KKWeChatShareModel *model = [[KKWeChatShareModel alloc] init];
    model.text = @"这是分享标题";
    model.detail = @"这是分享描述";
    model.webpageUrl = @"https://www.pgyer.com/app/publish";
    WeakSelf
    [[KKPayManager sharedInstance] weChatShareWithModel:model complete:^(BOOL success, id info) {
        if (success) {
            
        }else{
            [weakSelf showError:@"微信分享失败！"];
        }
    }];
}
- (void)wechatThirdPay{
    //微信支付
    WeakSelf
    //appid = wx0647716e2f53ac8b
    NSString *appid = @"wx0647716e2f53ac8b";
    NSString *noncestr = @"a98f623732dc1769f1d86c7a9af47d98";
    NSString *package = @"Sign=WXPay";
    NSString *partnerid = @"10000100";
    NSString *prepayid = @"wx2016020113211441bedffa200696249595";
    NSString *sign = @"9CDF57FCD819DAA18C8846EAFF3B95D7";
    NSString *timestamp = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    KKWeChatPayModel *model = [[KKWeChatPayModel alloc] init];
    model.appid = appid;
    model.noncestr = noncestr;
    model.package = package;
    model.partnerid = partnerid;
    model.prepayid = prepayid;
    model.sign = sign;
    model.timestamp = timestamp;
    [[KKPayManager sharedInstance] weChatPayWithModel:model complete:^(BOOL success, id info) {
        if (success) {
            //等待通知回调
        }else{
            [weakSelf showError:@"微信支付失败！"];
        }
    }];
}
#pragma mark - QQ
- (void)qqThirdLogin{
    //qq登录
    
}
- (void)qqThirdShare{
    //qq分享
    
}
- (void)qqThirdPay{
    //qqpay
    
}
#pragma mark - 微博
- (void)sinaThirdLogin{
    //新浪登录
    
}
- (void)sinaThirdShare{
    //新浪分享
    
}
- (void)sinaThirdPay{
    //新浪pay
    
}
#pragma mark - 支付宝
- (void)aliThirdLogin{
    //支付宝支付
}
- (void)aliThirdShare{
    //支付宝分享
}
- (void)aliThirdPay{
    //支付宝支付
}

@end
