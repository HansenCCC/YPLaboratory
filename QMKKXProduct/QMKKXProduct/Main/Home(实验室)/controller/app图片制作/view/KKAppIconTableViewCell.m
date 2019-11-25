//
//  KKAppIconTableViewCell.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/12.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKAppIconTableViewCell.h"
#import "KKAppIconLabelModel.h"

@implementation KKAppIconTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textField.font = AdaptedFontSize(14.f);
    self.textField.userInteractionEnabled = NO;
}

- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self updateSubviews];
}
- (void)updateSubviews{
    KKAppIconLabelModel *cellModel = (KKAppIconLabelModel *)self.cellModel;
    self.textField.text = cellModel.filePath?:@"";
    self.textField.placeholder = cellModel.placeholder?:@"";
    //
    UIImage *image = cellModel.iconImage;
    [self.iconImageView setImage:image];
}
@end
