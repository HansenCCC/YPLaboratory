//
//  KKThirdFunctionTableViewCell.h
//  QMKKXProduct
//
//  Created by Hansen on 6/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKThirdFunctionTableViewCell : UITableViewCell
@property (strong, nonatomic) KKLabelModel *cellModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (copy, nonatomic) void (^whenActionClick)(NSInteger index);

@end

