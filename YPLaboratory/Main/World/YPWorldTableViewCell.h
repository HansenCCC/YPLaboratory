//
//  YPWorldTableViewCell.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/17.
//

#import "YPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class YPWorldModel;

@interface YPWorldTableViewCell : UITableViewCell

@property (nonatomic, strong) YPWorldModel *cellModel;

@end

NS_ASSUME_NONNULL_END
