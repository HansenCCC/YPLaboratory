//
//  KKButtonTableViewCell.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/12.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKButtonTableViewCell.h"

@implementation KKButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleButton.userInteractionEnabled = NO;
    self.titleButton.titleLabel.font = AdaptedBoldFontSize(18.f);
    [self.titleButton setTitleColor:KKColor_0000FF forState:UIControlStateNormal];
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self updateSubviews];
}
- (void)updateSubviews{
    KKLabelModel *cellModel = self.cellModel;
    [self.titleButton setTitle:cellModel.title?:@"" forState:UIControlStateNormal];
}
@end
