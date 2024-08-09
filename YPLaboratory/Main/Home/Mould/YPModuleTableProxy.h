//
//  YPModuleTableProxy.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class YPModuleTableViewModel;

@interface YPModuleTableProxy : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithViewModel:(YPModuleTableViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
