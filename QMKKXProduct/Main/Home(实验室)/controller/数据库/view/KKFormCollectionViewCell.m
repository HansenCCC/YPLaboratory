//
//  KKFormCollectionViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 2/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKFormCollectionViewCell.h"

@interface KKFormCollectionViewCell ()

@end

@implementation KKFormCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.font = AdaptedFontSize(15.f);
    self.titleLabel.textColor = KKColor_000000;
    self.titleLabel.numberOfLines = 0;
    //
    self.textView.font = AdaptedFontSize(15.f);
    self.textView.textColor = KKColor_000000;
}

@end
