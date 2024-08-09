//
//  YPWorldProxy.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class YPWorldViewModel;

@interface YPWorldProxy : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithViewModel:(YPWorldViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
