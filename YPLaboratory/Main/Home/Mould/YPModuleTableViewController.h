//
//  YPModuleTableViewController.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPModuleTableViewController : YPBaseViewController

@property (nonatomic, strong) YPPageRouter *model;

- (void)startLoadData;

- (NSArray <YPPageRouterModule *>*)dataList;

@end

NS_ASSUME_NONNULL_END
