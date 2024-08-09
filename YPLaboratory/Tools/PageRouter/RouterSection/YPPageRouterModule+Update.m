//
//  YPPageRouterModule+Update.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/5.
//

#import "YPPageRouterModule+Update.h"
#import "YPModuleTableViewController.h"

@implementation YPPageRouterModule (Update)

+ (void)yp_reloadCurrentCell:(UIView *)cell {
    if ([cell isKindOfClass:[UITableViewCell class]]) {
        [(UITableViewCell *)cell yp_reloadCurrentTableViewCell];
    } else if ([cell isKindOfClass:[UICollectionViewCell class]]) {
        
    }
}

+ (void)yp_reloadCurrentModuleControl {
    UIViewController *vc = [UIViewController yp_topViewController];
    if ([vc isKindOfClass:[YPModuleTableViewController class]]) {
        [(YPModuleTableViewController *)vc startLoadData];
    }
}

@end
