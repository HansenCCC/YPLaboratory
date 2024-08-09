//
//  YPPageRouterModule+Update.h
//  YPLaboratory
//
//  Created by Hansen on 2023/6/5.
//

#import "YPPageRouterModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPPageRouterModule (Update)

+ (void)yp_reloadCurrentCell:(UIView *)cell;

+ (void)yp_reloadCurrentModuleControl;

@end

NS_ASSUME_NONNULL_END
