//
//  KKImageViewCollectionViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 1/29/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKImageViewCollectionViewCell.h"

@implementation KKImageViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
