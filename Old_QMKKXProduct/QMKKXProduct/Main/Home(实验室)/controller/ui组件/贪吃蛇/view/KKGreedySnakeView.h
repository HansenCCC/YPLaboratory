//
//  KKGreedySnakeView.h
//  QMKKXProduct
//
//  Created by Hansen on 6/29/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKGreedySnakeCell.h"

@interface KKGreedySnakeView : UIView
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *datas;

@end

