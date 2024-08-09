//
//  YPModuleTableViewModel.m
//  YPLaboratory
//
//  Created by Hansen on 2023/5/21.
//

#import "YPModuleTableViewModel.h"
#import "YPPageRouter.h"

@interface YPModuleTableViewModel ()

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation YPModuleTableViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.pageSize = 10;
        self.pageIndex = 1;
        self.dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)startLoadData {
    self.pageIndex = 1;
    [self startLoadingData:_pageIndex];
}

- (void)loadMoreData {
    self.pageIndex ++;
    [self startLoadingData:_pageIndex];
}

- (void)startLoadingData:(NSInteger)pageIndex {
    BOOL hasMore = NO;
    NSArray *dataList = [[YPRouterManager shareInstance] getRoutersByModel:self.model];
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:dataList];
    if ([self.delegate respondsToSelector:@selector(didEndLoadData:)]) {
        [self.delegate didEndLoadData:hasMore];
    }
}

@end
