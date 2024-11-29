//
//  UIViewController+Router.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import "UIViewController+Router.h"
#import "YPModuleTableViewController.h"
#import "YPHTTPVerifyPaymentRequest.h"

@implementation UIViewController (Router)

- (void)pushToControllerWithRouter:(YPPageRouter *)pageRouter cell:(UIView *)cell {
    YPPageRouter *cellModel = pageRouter;
    if (pageRouter.didSelectedCallback) {
        pageRouter.didSelectedCallback(pageRouter, cell);
        return;
    }
    switch (cellModel.type) {
        case YPPageRouterTypeNormal:
        case YPPageRouterTypeTableCell:
        case YPPageRouterTypeSwitch:
        case YPPageRouterTypeCopy: {
            
        }
            break;
        case YPPageRouterTypeButton:
        case YPPageRouterTypeTable:
        case YPPageRouterTypeCollection: {
            // 是一个列表  table | collection
            YPModuleTableViewController *vc = [[YPModuleTableViewController alloc] init];
            vc.model = pageRouter;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case YPPageRouterTypePush: {
            // 需要Push新的页面 extend=类试图的字符串
            Class vcClass = NSClassFromString(cellModel.extend);
            YPBaseViewController *vc = [[vcClass alloc] init];
            if ([vc isKindOfClass:[YPBaseViewController class]]) {
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = cellModel.title;
                [[UIViewController yp_topViewController].navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case YPPageRouterTypeAppCheckUpdate: {
            // app检查更新
            [[YPSettingManager sharedInstance] showAppstore];
        }
            break;
        case YPPageRouterTypeAppComment: {
            // app评论
            [[YPSettingManager sharedInstance] showComment];
        }
            break;
        case YPPageRouterTypeAppInternalPurchase: {
            // 应用内购 extend=productId
            NSString *productId = cellModel.extend?:@"";
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
        }
            break;
        case YPPageRouterTypeCollectionCell: {
            // 子视图，需要指定展示cell（collection）
        }
            break;
            
        default:
            break;
    }
}

@end
