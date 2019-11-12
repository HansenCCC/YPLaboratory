//
//  KKLabelTableViewCell.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/12.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKLabelTableViewCell.h"

@interface KKLabelTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraint1;

@end


@implementation KKLabelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textField.textAlignment = NSTextAlignmentRight;
}

- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self updateSubviews];
}
- (void)updateSubviews{
    KKLabelModel *cellModel = self.cellModel;
    self.titleLabel.text = cellModel.title?:@"--";
    self.textField.userInteractionEnabled = cellModel.isCanEdit;
    self.textField.text = cellModel.value?:@"";
    self.textField.placeholder = cellModel.placeholder?:@"";
    if(cellModel.imageName.length > 0){
        //左边存在图片
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightButton.mas_left).offset(-8.f);
        }];
    }else{
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15.f);
        }];
    }
    if (cellModel.imageName.isValidURL) {
//        [self.rightButton kk_setImageWithURL:cellModel.imageName.isValidURL placeholderImage:<#(UIImage *)#>];
    }else{
        [self.rightButton setImage:UIImageWithName(cellModel.imageName) forState:UIControlStateNormal];
    }
}
@end
