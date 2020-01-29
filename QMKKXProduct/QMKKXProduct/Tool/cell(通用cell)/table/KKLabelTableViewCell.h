//
//  KKLabelTableViewCell.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/12.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLabelModel.h"

@interface KKLabelTableViewCell : UITableViewCell
@property (strong, nonatomic) KKLabelModel *cellModel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet KKTextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

