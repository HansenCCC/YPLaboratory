//
//  KKApplePayManner.h
//  MotoVPN3
//
//  Created by Hansen on 4/12/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

typedef void(^KKApplePayMannerProductsResponseBlock)(SKProductsRequest *request ,SKProductsResponse *response, NSError *error);
typedef void(^KKApplePayMannerBuyProductsResponseBlock)(SKPaymentTransaction* transaction, NSError *error);
typedef void(^KKApplePayMannerCheckPaymentBlock)(NSString *checkPath,NSDictionary *payDic,NSError *error);

/*
 内购流程
 
    1、获取可购买商品列表（Apple服务端）
 -> 2、选择商品到服务端创建订单（后端服务）
 -> 3、根据商品信息SKProduct吊起苹果API进行支付
 -> 4、支付成功之后缓存苹果支付凭证（防止APP直接退出造成丢单）
 -> 5、根据支付凭证校验是否支付成功（后端服务）
 -> 6、校验成功之后删除缓存的支付凭证（否者：下次APP进入的时候重新请求校验支付是否成功）
 
 */

//封装Apple服务端接口 支付管理类
@interface KKApplePayManner : NSObject
AS_SINGLETON(KKApplePayManner);
@property (nonatomic, strong) NSArray <SKProduct *>*products;//商品列表

//请求苹果API，获取商品列表  products=商品id
- (void)requestProducts:(NSArray <NSString *>*)productIdentifiers withCompletion:(KKApplePayMannerProductsResponseBlock)completion;
//购买商品，productIdentifier=商品信息
- (void)buyProduct:(SKProduct *)productIdentifier onCompletion:(KKApplePayMannerBuyProductsResponseBlock)completion;

@end

//创建针对支付凭证进行操作的分类
@interface KKApplePayManner (KKCheckInternalPurchasePayment)

//获取当前支付成功 存在本地的receipt
- (NSString *)appStoreReceiptbase64EncodedString;
//校验缓存的内购支付 checkPath(回调需要校验的校验地址)，拿到需要校验的地址，在block与服务进行校验
- (void)checkInternalPurchasePayment:(KKApplePayMannerCheckPaymentBlock)completed;
//缓存支付凭证 return 成功|失败
- (BOOL)savePaymentVoucher:(NSDictionary *)payDic;
//移除支付凭证（根据payDic匹配相同的，并移除） return 成功|失败
- (BOOL)deleteByPaymentVoucher:(NSDictionary *)deletePayDic;

@end



/*
 试用实例
 //获取商品列表
 [self showLoading];
 WeakSelf
 [[KKApplePayManner sharedInstance] requestProducts:@[@"month_30",@"season_90",@"year_360",] withCompletion:^(SKProductsRequest *request, SKProductsResponse *response, NSError *error) {
     [weakSelf hideLoading];
     if (!error) {
         NSLog(@"获取商品列表成功");
     }else{
         NSLog(@"获取商品列表失败\n%@",error.userInfo[NSLocalizedDescriptionKey]);
     }
 }];
 
 //开始支付
 [self showLoading];
 NSArray *products = [KKApplePayManner sharedInstance].products;
 [[KKApplePayManner sharedInstance] buyProduct:products.firstObject onCompletion:^(SKPaymentTransaction *transaction, NSError *error) {
     [weakSelf hideLoading];
     if (!error) {
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
         NSLog(@"购买商品成功");
     }else{
         NSLog(@"购买商品失败\n%@",error.userInfo[NSLocalizedDescriptionKey]);
     }
 }];
 */
