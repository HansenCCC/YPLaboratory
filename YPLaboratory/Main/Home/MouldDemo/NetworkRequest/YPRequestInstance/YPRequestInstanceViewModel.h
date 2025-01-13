//
//  YPRequestInstanceViewModel.h
//  YPLaboratory
//
//  Created by Hansen on 2025/1/13.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YPRequestInstanceViewModelDelegate <NSObject>

- (void)didEndLoadData:(BOOL)hasMore;

@end

@interface YPRequestInstanceViewModel : NSObject

@property (nonatomic, weak) id <YPRequestInstanceViewModelDelegate> delegate;
@property (nonatomic, readonly) NSMutableArray *dataList;

- (void)startLoadData;

- (void)loadMoreData;

@end

NS_ASSUME_NONNULL_END
