//
//  KKFormTableViewCell.h
//  QMKKXProduct
//
//  Created by Hansen on 2/4/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKFormTableViewCell : UITableViewCell
@property (strong, nonatomic) KKLabelModel *cellModel;
@property (assign, nonatomic) CGPoint contentOffset;
@property (copy  , nonatomic) void (^whenScrollViewDidScroll)(UIScrollView *scrollView);

@end
