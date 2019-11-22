//
//  KKSwitchTableViewCell.h
//  QMKKXProduct
//  开关
//  Created by Hansen on 11/23/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLabelModel.h"

@interface KKSwitchTableViewCell : UITableViewCell
@property (strong, nonatomic) KKLabelModel *cellModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchView;
@property (copy, nonatomic) void (^whenChangeState)(BOOL isOn, KKSwitchTableViewCell *copyCell);

@end

