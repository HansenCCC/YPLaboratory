//
//  KKApplePayManner.m
//  MotoVPN3
//
//  Created by Hansen on 4/12/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKApplePayManner.h"

@interface KKApplePayManner ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property (strong, nonatomic) SKProductsRequest *requestProducts;//请求商品列表

@property (copy  , nonatomic) KKApplePayMannerProductsResponseBlock productsResponseBlock;//获取商品列表回调
@property (copy  , nonatomic) KKApplePayMannerBuyProductsResponseBlock buyProductsResponseBlock;//购买商品回调

@end


@implementation KKApplePayManner
DEF_SINGLETON(KKApplePayManner);
- (instancetype)init{
    if (self = [super init]) {
        //监听购买结果
        [self addTransactionObserver];
    }
    return self;
}
//监听内购购买结果
- (void)addTransactionObserver{
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
}
//请求苹果API，获取商品列表  products=商品id
- (void)requestProducts:(NSArray <NSString *>*)productIdentifiers withCompletion:(KKApplePayMannerProductsResponseBlock)completion{
    //配置请求商品ids
    NSSet *set = [[NSSet alloc] initWithArray:productIdentifiers];
    self.requestProducts = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    self.requestProducts.delegate = self;
    self.productsResponseBlock = completion;
    //开始请求
    [self.requestProducts start];
}
//购买商品
- (void)buyProduct:(SKProduct *)productIdentifier onCompletion:(KKApplePayMannerBuyProductsResponseBlock)completion{
    self.buyProductsResponseBlock = completion;
    //开始购买请求
    SKPayment *payment = [SKPayment paymentWithProduct:productIdentifier];
    if ([SKPaymentQueue defaultQueue]&&productIdentifier) {
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }else{
        if (self.buyProductsResponseBlock) {
            NSError *error = [NSError errorWithDomain:@"商品id为空" code:77777 userInfo:nil];
            self.buyProductsResponseBlock(nil,error);
        }
    }
}

#pragma mark - SKPaymentTransactionObserver
//支付状态改变，回调
- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (SKPaymentTransaction *transaction in transactions){
            switch (transaction.transactionState){
                case SKPaymentTransactionStatePurchasing:{
                    //正在将事务添加到服务器队列。（正在购买）
                    [self purchasingTransaction:transaction];
                    break;
                }
                case SKPaymentTransactionStatePurchased:{
                    //事务在队列中，用户已被收费。客户应完成交易。（客户端完成交易）
                    [self purchasedTransaction:transaction];
                    break;
                }
                case SKPaymentTransactionStateFailed:{
                    //事务在添加到服务器队列之前已取消或失败。（用户取消支付或者失败）
                    [self failedTransaction:transaction];
                    break;
                }
                case SKPaymentTransactionStateRestored:
                    //交易已从用户的购买历史记录中还原。客户应完成交易
                    [self restoreTransaction:transaction];
                default:
                    break;
            }
        }
    });
}
//正在将事务添加到服务器队列。（正在购买）
- (void)purchasingTransaction:(SKPaymentTransaction *)transaction{
    
}
//事务在队列中，用户已被收费。客户应完成交易。（客户端完成交易）
- (void)purchasedTransaction:(SKPaymentTransaction *)transaction{
    //标记请求完成
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
    if (self.buyProductsResponseBlock) {
        self.buyProductsResponseBlock(transaction,transaction.error);
    }
}
//事务在添加到服务器队列之前已取消或失败。（用户取消支付或者失败）
- (void)failedTransaction:(SKPaymentTransaction *)transaction{
    //标记请求完成
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
    if (self.buyProductsResponseBlock) {
        self.buyProductsResponseBlock(transaction,transaction.error);
    }
}
//交易已从用户的购买历史记录中还原。客户应完成交易
- (void)restoreTransaction:(SKPaymentTransaction *)transaction{
    //标记请求完成
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
    if (self.buyProductsResponseBlock) {
        self.buyProductsResponseBlock(transaction,transaction.error);
    }
}
#pragma mark - SKProductsRequestDelegate
//获取商品列表回调
- (void)productsRequest:(nonnull SKProductsRequest *)request didReceiveResponse:(nonnull SKProductsResponse *)response {
    dispatch_async(dispatch_get_main_queue(), ^{
        //缓存请求成功的商品信息
        self.products = [response.products copy];
        //清除请求状态
        self.requestProducts.delegate = nil;
        self.requestProducts = nil;
        //
        if(self.productsResponseBlock){
            self.productsResponseBlock(request, response, nil);
        }
    });
}
//获取商品列表失败回调
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
        //缓存请求成功的商品信息
        self.products = @[];
        //清除请求状态
        self.requestProducts.delegate = nil;
        self.requestProducts = nil;
        //请求失败
        if(self.productsResponseBlock){
            self.productsResponseBlock((SKProductsRequest *)request, nil ,error);
        }
    });
}
//dealloc
- (void)dealloc{
    if ([SKPaymentQueue defaultQueue]) {
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    }
}
@end

//创建针对支付凭证进行操作的分类
@implementation KKApplePayManner (KKCheckInternalPurchasePayment)
//获取当前支付成功 存在本地的receipt
- (NSString *)appStoreReceiptbase64EncodedString{
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *receipt = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return receipt;
}
//获取缓存凭证的地址
- (NSString *)cacheInternalPurchasePaymentPath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path addString:@"/InternalPurchasePayment"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在，不存直接创建
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:nil];
    if(!isDirExist){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}
//校验缓存的内购支付 checkPath(回调需要校验的校验地址)
- (void)checkInternalPurchasePayment:(KKApplePayMannerCheckPaymentBlock)completed{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSString *path = [self cacheInternalPurchasePaymentPath];
    //搜索该目录下的所有文件和目录
    NSArray *filesArray = [fileManager contentsOfDirectoryAtPath:path error:&error];
    if (error == nil) {
        if (filesArray.count == 0) {
            completed(nil,@{},nil);
        }else{
            for (NSString *name in filesArray) {
                if ([name hasSuffix:@".plist"]) {
                    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,name];
                    NSDictionary *payDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
                    if (completed) {
                        completed(filePath,[payDic copy], nil);
                    }
                }
            }
        }
    }else{
        completed(nil,@{},error);
    }
}
//缓存支付凭证
- (BOOL)savePaymentVoucher:(NSDictionary *)payDic{
    NSString *path = [self cacheInternalPurchasePaymentPath];
    NSString *fileName = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970] * 1000];
    NSString *savedPath = [NSString stringWithFormat:@"%@/%@.plist", path,fileName];
    BOOL success = [payDic writeToFile:savedPath atomically:YES];
    return success;
}
//移除支付凭证（根据payDic匹配相同的，并移除）
- (BOOL)deleteByPaymentVoucher:(NSDictionary *)deletePayDic{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSString *path = [self cacheInternalPurchasePaymentPath];
    //搜索该目录下的所有文件和目录
    NSArray *filesArray = [fileManager contentsOfDirectoryAtPath:path error:&error];
    if (error == nil) {
        //遍历支付凭证是否存在凭证列表里面
        for (NSString *name in filesArray) {
            if ([name hasSuffix:@".plist"]) {
                NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,name];
                NSDictionary *payDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
                //不为空处理
                if (payDic == nil) {
                    payDic = @{};
                }
                //存在相同的支付凭证
                if ([payDic isEqualToDictionary:deletePayDic]) {
                    NSError *deleteError = nil;
                    if ([fileManager fileExistsAtPath:filePath]) {
                        //移除支付凭证
                        [fileManager removeItemAtPath:filePath error:&deleteError];
                        if (!deleteError) {
                            //删除成功
                            return YES;
                        }else{
                            //删除失败
                            return NO;
                        }
                    }else{
                        //文件不存在，直接失败
                        return NO;
                    }
                }
            }
        }
        //遍历完成之后，文件已经不存在
        return NO;
    }else{
        return NO;
    }
}

@end
