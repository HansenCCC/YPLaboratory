//
//  YPUserProxy.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class YPUserViewModel;

@interface YPUserProxy : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithViewModel:(YPUserViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
