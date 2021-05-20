//
//  KKFileCollectionViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 11/25/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKFileCollectionViewCell.h"

@implementation KKFileCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.font = AdaptedFontSize(15.f);
    self.titleLabel.textColor = KKColor_2C2C2C;
    self.detailLabel.font = AdaptedFontSize(12.f);
    self.detailLabel.textColor = KKColor_0000FF;
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self updateSubviews];
}
- (void)updateSubviews{
    KKLabelModel *cellModel = self.cellModel;
    self.titleLabel.text = cellModel.title?:@"";
    self.detailLabel.text = cellModel.value?:@"";
    UIImage *defaultImage = UIImageWithName(@"kk_icon_fileDic");
    if (cellModel.imageName.length > 0) {
        if (cellModel.imageName.isValidURL) {
            [self.imageView kk_setImageWithUrl:cellModel.imageName placeholderImage:kPlaceholder1r1];
        }else{
            [self.imageView setImage:UIImageWithName(cellModel.imageName)];
        }
    }else{
        [self.imageView setImage:defaultImage];
    }
}
@end
