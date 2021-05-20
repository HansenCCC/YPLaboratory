//
//  KKFormCollectionViewCell.h
//  QMKKXProduct
//
//  Created by Hansen on 2/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KKFormCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet KKTextView *textView;

@end

