//
//  YPRequestInstanceTableViewCell.h
//  YPLaboratory
//
//  Created by Hansen on 2025/1/13.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class YPRequestInstanceModel;

@interface YPRequestInstanceTableViewCell : UITableViewCell

@property (nonatomic, strong) YPRequestInstanceModel *cellModel;

+ (instancetype)shareInstance;

- (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
