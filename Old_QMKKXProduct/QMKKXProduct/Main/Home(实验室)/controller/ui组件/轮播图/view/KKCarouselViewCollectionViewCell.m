//
//  KKCarouselViewCollectionViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 11/26/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKCarouselViewCollectionViewCell.h"

@implementation KKCarouselViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = KKColor_FFFFFF;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
