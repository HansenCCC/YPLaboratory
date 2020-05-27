//
//  KKPlayerTableViewCell.h
//  QMKKXProduct
//
//  Created by Hansen on 5/26/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPlayerTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) KKBeeAVPlayerView *playerView;
@property (strong, nonatomic) KKLabelModel *cellModel;

@end

