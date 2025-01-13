//
//  YPRequestInstanceViewModel.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/13.
//

#import "YPRequestInstanceViewModel.h"
#import "YPRequestInstanceModel.h"
#import "YpApiRequestDao.h"

@interface YPRequestInstanceViewModel ()

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation YPRequestInstanceViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.pageSize = 20;
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
    BOOL hasMore = YES;
    if (self.pageIndex == 1) {
        [self.dataList removeAllObjects];
    }
    NSString *condition = [NSString stringWithFormat:@"isEnable=1 ORDER BY id DESC LIMIT %ld OFFSET %ld",self.pageSize, (self.pageIndex - 1) * self.pageSize];
    NSArray *dataList = [[YpApiRequestDao get] selectYpApiRequestBySQLCondition:condition];
    if (dataList.count < self.pageSize) {
        hasMore = NO;
    }
    for (YpApiRequest *suModel in dataList) {
        YPRequestInstanceModel *model = [[YPRequestInstanceModel alloc] init];
        model.model = suModel;
        [self.dataList addObject:model];
    }
    if ([self.delegate respondsToSelector:@selector(didEndLoadData:)]) {
        [self.delegate didEndLoadData:hasMore];
    }
}

@end
