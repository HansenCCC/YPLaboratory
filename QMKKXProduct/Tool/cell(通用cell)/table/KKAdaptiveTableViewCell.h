//
//  KKAdaptiveTableViewCell.h
//  QMKKXProduct
//  自适应cell高度
//  Created by Hansen on 2/2/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKAdaptiveTableViewCell : UITableViewCell
@property (assign, nonatomic) UIEdgeInsets contentInsets;//间距
@property (strong, nonatomic) UILabel *contentLabel;
AS_SINGLETON(KKAdaptiveTableViewCell);
@end

