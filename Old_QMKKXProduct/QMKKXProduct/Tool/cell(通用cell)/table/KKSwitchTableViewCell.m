//
//  KKSwitchTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 11/23/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKSwitchTableViewCell.h"

@implementation KKSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self updateSubviews];
}
- (void)updateSubviews{
    KKLabelModel *cellModel = self.cellModel;
    self.titleLabel.text = cellModel.title?:@"";
    self.switchView.on = (cellModel.value.intValue) == 1;
}
- (IBAction)whenChangedValue:(UISwitch *)sender {
    if (self.whenChangeState) {
        self.whenChangeState(sender.on,self);
    }
}
@end
