//
//  YPWaterfallFlowCollectionViewCell.h
//  YPLaboratory
//
//  Created by Hansen on 2024/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPWaterfallFlowCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YPPageRouter *cellModel;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
