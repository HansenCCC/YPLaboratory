//
//  KKFileCollectionViewCell.h
//  QMKKXProduct
//
//  Created by Hansen on 11/25/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKFileCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) KKLabelModel *cellModel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
