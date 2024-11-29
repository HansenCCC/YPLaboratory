//
//  YPPageRouterModule+AppleInternalPurchase.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/25.
//

#import "YPPageRouterModule+AppleInternalPurchase.h"
#import "YPHTTPVerifyPaymentRequest.h"

@implementation YPPageRouterModule (AppleInternalPurchase)

// 苹果内购相关
+ (NSArray *)AppleInternalPurchase {
    NSMutableArray *dataList = [[NSMutableArray alloc] init];
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"免费的支持".yp_localizedString;
        element.content = @"感谢评论";
        [dataList addObject:element];
    }
    {
        YPPageRouter *element = [[YPPageRouter alloc] init];
        element.title = @"拉起一元内购支付".yp_localizedString;
        element.content = @"1 CNY";
        element.extend = @"yp_pay_100";
        element.didSelectedCallback = ^(YPPageRouter * _Nonnull router, UIView * _Nonnull cell) {
            NSString *productId = router.extend?:@"";
            [YPLoadingView showLoading:@"获取商品中，请稍等"];
            [[YPPurchaseManager sharedInstance] paymentProductWithProductId:productId extend:@{} completion:^(SKPaymentTransaction * _Nonnull transaction, NSError * _Nonnull error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [YPLoadingView hideLoading];
                    if (!error) {
                        NSDictionary *payDic = [[YPPurchaseManager sharedInstance] scanLocalPaymentsBySKPaymentTransaction:transaction];
                        // 开始检验支付是否成功
                        YPHTTPVerifyPaymentRequest *request = [[YPHTTPVerifyPaymentRequest alloc] init];
                        request.receiptData = payDic[@"receiptData"];
                        [YPLoadingView showLoading:@"检验支付状态，请稍等"];
                        [request startWithSuccessHandler:^(YPHTTPResponse * _Nonnull response) {
                            [YPLoadingView hideLoading];
                            if ([response.responseData[@"status"] intValue] == 0) {
                                // 检验成功，用户已经支付了
                                [[YPPurchaseManager sharedInstance] deleteByPaymentVoucher:payDic];
                                [YPAlertView alertText:@"谢谢您的慷慨。\n祝您工作顺利，生活愉快！" duration:4.f];
                            } else {
                                [YPAlertView alertText:@"校验支付状态失败，请稍后再试！"];
                            }
                        } failureHandler:^(NSError * _Nonnull error) {
                            [YPLoadingView hideLoading];
                            [YPAlertView alertText:[NSString stringWithFormat:@"%@",error.domain]];
                        }];
                    } else {
                        [YPAlertView alertText:[NSString stringWithFormat:@"%@",error.domain]];
                    }
                });
            }];
        };
        [dataList addObject:element];
    }
    YPPageRouterModule *section = [[YPPageRouterModule alloc] initWithRouters:dataList];
    return @[section];
}

@end
