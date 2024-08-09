//
//  UIViewController+Router.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Router)

/// 统一处理 push 逻辑
/// - Parameter pageRouter: pageRouter
/// - Parameter cell: cell
- (void)pushToControllerWithRouter:(YPPageRouter *)pageRouter cell:(UIView *)cell;

@end

NS_ASSUME_NONNULL_END
