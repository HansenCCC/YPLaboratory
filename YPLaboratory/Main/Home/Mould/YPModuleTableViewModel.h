//
//  YPModuleTableViewModel.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YPModuleTableViewModelDelegate <NSObject>

- (void)didEndLoadData:(BOOL)hasMore;

@end

@interface YPModuleTableViewModel : NSObject

@property (nonatomic, strong) YPPageRouter *model;
@property (nonatomic, weak) id <YPModuleTableViewModelDelegate> delegate;
@property (nonatomic, readonly) NSMutableArray *dataList;

- (void)startLoadData;

- (void)loadMoreData;

@end

NS_ASSUME_NONNULL_END
