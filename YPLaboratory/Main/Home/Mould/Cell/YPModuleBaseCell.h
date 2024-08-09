//
//  YPModuleBaseCell.h
//  YPLaboratory
//
//  Created by Hansen on 2023/6/4.
//

#import <UIKit/UIKit.h>
#import "YPPageRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPModuleBaseCell : UITableViewCell

@property (nonatomic, strong) YPPageRouter *cellModel;

@end

NS_ASSUME_NONNULL_END
