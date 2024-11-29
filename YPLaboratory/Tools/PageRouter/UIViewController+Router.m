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
    if (pageRouter.didSelectedCallback) {
        pageRouter.didSelectedCallback(pageRouter, cell);
        return;
    }
    // 内置 Table
    if (pageRouter.type == YPPageRouterTypeModule) {
        YPModuleTableViewController *vc = [[YPModuleTableViewController alloc] init];
        vc.model = pageRouter;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

@end
