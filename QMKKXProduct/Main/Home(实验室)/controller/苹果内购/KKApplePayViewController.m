//
//  KKApplePayViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 5/21/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKApplePayViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKAdaptiveTableViewCell.h"

@interface KKApplePayViewController ()
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak  , nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger selectIndex;//选中cell 默认 = 0
@property (weak  , nonatomic) IBOutlet UIButton *payButton;

@end

@implementation KKApplePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"苹果内购";
    self.selectIndex = 0;
    self.payButton.backgroundColor = KKColor_0000FF;
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
    [self requestAppleProducts];//获取商品列表
}
- (void)requestAppleProducts{
    //获取苹果内购商品列
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (KKLabelModel *element in self.datas) {
        [items addObject:element.title];
    }
    /*
     {"isDownloadable":false,"localizedDescription":"这是一个付费的商品（18CNY）","price":18,"downloadable":false,"productIdentifier":"18_goods","localizedTitle":"付费的商品（18CNY）","priceLocale":{"optionNameForSelectableScripts":"文字","ITUCountryCode":86,"_calendarDirection":0,"languageIdentifier":"zh-Hans","numberingSystem":"latn","availableNumberingSystems":["latn"],"optionNameWithColonForSelectableScripts":"文字："}}
     */
    WeakSelf
    [[KKApplePayManner sharedInstance] requestProducts:items withCompletion:^(SKProductsRequest *request, SKProductsResponse *response, NSError *error) {
        if (error||response.products.count == 0) {
            [KKAlertViewController showPayFailWithContent:@"尚未从App Store获取到商品信息，请重试" complete:^(KKAlertViewController *controler, NSInteger index) {
                [controler dismissViewControllerCompletion:nil];
            }];
            return;
        }
        for (SKProduct *product in response.products) {
            for (KKLabelModel *element in weakSelf.datas) {
                if ([element.title isEqualToString:product.productIdentifier]) {
                    element.info = product;
                    element.title = product.localizedTitle;
                }
            }
        }
        [weakSelf.tableView reloadData];
    }];
}
- (void)setupSubviews{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KKLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"KKLabelTableViewCell"];
    [self.tableView registerClass:[KKAdaptiveTableViewCell class] forCellReuseIdentifier:@"KKAdaptiveTableViewCell"];
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom += 70.f;
    self.tableView.contentInset = contentInset;
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    NSArray *items = @[
        @"6_goods",
        @"12_goods",
        @"18_goods",
        @"25_goods",
    ];
    //构造cell
    for (NSString *item in items) {
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:nil];
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
    KKAdaptiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKAdaptiveTableViewCell"];
    [self setupAdaptiveCell:cell cellModel:cellModel];
    if (indexPath.row == self.selectIndex) {
        cell.contentLabel.textColor = KKColor_0000FF;
//        [cell.rightButton setImage:UIImageWithName(@"kk_icon_cny") forState:UIControlStateNormal];
    }else{
        cell.contentLabel.textColor = KKColor_000000;
//        [cell.rightButton setImage:nil forState:UIControlStateNormal];
    }
    return cell;
}
//赋值cell
- (void)setupAdaptiveCell:(KKAdaptiveTableViewCell *)cell cellModel:(KKLabelModel *)cellModel{
    SKProduct *product = cellModel.info;
    NSString *title = [NSString stringWithFormat:@"名称：%@\n\n",cellModel.title];
    NSString *localizedDescription = [NSString stringWithFormat:@"描述：%@\n",product.localizedDescription?:@"--"];
    NSString *price = [NSString stringWithFormat:@"价格: %@\n",product.price?:@"--"];
    NSString *info = [NSString stringWithFormat:@"具体: %@\n",product.mj_JSONString?:@"--"];
    NSString *format = [NSString stringWithFormat:@"%@%@%@",localizedDescription,price,info];
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:AdaptedBoldFontSize(18)}];
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = AdaptedWidth(5.f);
    NSAttributedString *formatAttributed = [[NSAttributedString alloc] initWithString:format attributes:@{NSFontAttributeName:AdaptedFontSize(12),NSParagraphStyleAttributeName:paragraphStyle}];
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
    self.selectIndex = indexPath.row;
    [self.tableView reloadData];
}
#pragma mark - aciton
- (IBAction)whenPayAction:(UIButton *)sender {
    KKLabelModel *cellModel = self.datas[self.selectIndex];
    if (cellModel.info) {
        //开始支付
        WeakSelf
        [self showLoading];
        [[KKApplePayManner sharedInstance] buyProduct:cellModel.info onCompletion:^(SKPaymentTransaction *transaction, NSError *error) {
            [weakSelf hideLoading];
            if (!error) {
                //支付成功
                NSString *receipt = [KKApplePayManner sharedInstance].appStoreReceiptbase64EncodedString?:@"";
                NSString *transactionIdentifier = transaction.transactionIdentifier?:@"";
                NSString *productIdentifier = transaction.payment.productIdentifier;
                NSDictionary *payDic = @{
                    @"receiptData":receipt,
                    @"orderNo":@"0",
                    @"transactionId":transactionIdentifier,
                    @"productId":productIdentifier,
                };
                //先缓存支付凭证
                [[KKApplePayManner sharedInstance] savePaymentVoucher:payDic];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //与苹果校验支付结果（这里最好调后端同学接口校验，校验丢给后端校验）
                    [weakSelf requestSendAppStoreBuyReceipt:payDic];
                });
            }else{
                //支付失败
                NSString *description = [weakSelf descriptionFailWithError:error];
                [weakSelf showError:description];
            }
        }];
    }else{
        [KKAlertViewController showPayFailWithContent:@"尚未从App Store获取到商品信息，请重试" complete:^(KKAlertViewController *controler, NSInteger index) {
            [controler dismissViewControllerCompletion:nil];
        }];
    }
}
//与苹果校验支付结果（这里最好调后端同学接口校验，校验丢给后端校验）
- (void)requestSendAppStoreBuyReceipt:(NSDictionary *)param{
#if QMKKXProductDEV//测试环境
    NSString *checkURL = @"https://sandbox.itunes.apple.com/verifyReceipt";
#elif QMKKXProduct//正式环境
    NSString *checkURL = @"https://buy.itunes.apple.com/verifyReceipt";
#endif
    //timeoutInterval需要长一点
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:checkURL.toURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0f];
    request.HTTPMethod = @"POST";
    NSString *receiptData = param[@"receiptData"];
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}",receiptData];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = payloadData;
    NSURLSession *sessionPost = [NSURLSession sharedSession];
    [self showLoading];
    WeakSelf
    NSURLSessionDataTask *dataTask = [sessionPost dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideLoading];
            if (!error) {
                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if ([result[@"status"] intValue] == 0) {
                    //支付成功 (通常需要校验：bid，product_id，purchase_date，status，in_app)
                    [weakSelf showSuccessWithMsg:@"购买成功！"];
                    [[KKApplePayManner sharedInstance] deleteByPaymentVoucher:param];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [KKAlertViewController showPaySuccessWithComplete:^(KKAlertViewController *controler, NSInteger index) {
                            [controler dismissViewControllerCompletion:nil];
                        }];
                    });
                }else{
                    [weakSelf showSuccessWithMsg:@"购买失败！"];
                }
            }else{
                NSString *msg = [weakSelf matchMessageFailWithError:error];
                [weakSelf showError:msg];
            }
        });
    }];
    [dataTask resume];
}
#pragma mark - 支付错误信息处理
- (NSString *)descriptionFailWithError:(NSError *)error{
    NSString *description = error.userInfo[NSLocalizedDescriptionKey];
    if (description.length == 0) {
        description = @"支付失败！";
    }
    if (error.code == 2) {
        description = @"支付已取消！";
    }else if (error.code == 21000) {
        description = @"App Store不能读取你提供的JSON对象";
    }else if (error.code == 21002) {
        description = @"不支持该地区的apple ID";
    }else if (error.code == 21003) {
        description = @"不支持该地区的apple ID";
    }else if (error.code == 21004) {
        description = @"不支持该地区的apple ID";
    }else if (error.code == 21005) {
        description = @"不支持该地区的apple ID";
    }else if (error.code == 21006) {
        description = @"不支持该地区的apple ID";
    }else if (error.code == 21007) {
        description = @"不支持该地区的apple ID";
    }else if (error.code == 21008) {
        description = @"不支持该地区的apple ID";
    }
    return description;
}
- (NSString *)matchMessageFailWithError:(NSError *)error {
    NSString *message = @"";
    NSInteger status = error.code;
    switch (status) {
        case 0:
            message = @"The receipt as a whole is valid.";
            break;
        case 21000:
            message = @"The App Store could not read the JSON object you provided.";
            break;
        case 21002:
            message = @"The data in the receipt-data property was malformed or missing.";
            break;
        case 21003:
            message = @"The receipt could not be authenticated.";
            break;
        case 21004:
            message = @"The shared secret you provided does not match the shared secret on file for your account.";
            break;
        case 21005:
            message = @"The receipt server is not currently available.";
            break;
        case 21006:
            message = @"This receipt is valid but the subscription has expired. When this status code is returned to your server, the receipt data is also decoded and returned as part of the response. Only returned for iOS 6 style transaction receipts for auto-renewable subscriptions.";
            break;
        case 21007:
            message = @"This receipt is from the test environment, but it was sent to the production environment for verification. Send it to the test environment instead.";
            break;
        case 21008:
            message = @"This receipt is from the production environment, but it was sent to the test environment for verification. Send it to the production environment instead.";
            break;
        case 21010:
            message = @"This receipt could not be authorized. Treat this the same as if a purchase was never made.";
            break;
        default:
            message = error.domain;
            break;
    }
    return message;
}
@end
