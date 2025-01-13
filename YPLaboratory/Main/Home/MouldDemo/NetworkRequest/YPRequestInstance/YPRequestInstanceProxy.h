//
//  YPRequestInstanceProxy.h
//  YPLaboratory
//
//  Created by Hansen on 2025/1/13.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class YPRequestInstanceViewModel;

@interface YPRequestInstanceProxy : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithViewModel:(YPRequestInstanceViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
