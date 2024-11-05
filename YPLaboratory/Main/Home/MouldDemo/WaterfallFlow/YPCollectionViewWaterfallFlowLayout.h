//
//  YPCollectionViewWaterfallFlowLayout.h
//  YPLaboratory
//
//  Created by Hansen on 2024/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YPCollectionViewWaterfallFlowLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YPCollectionViewWaterfallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <YPCollectionViewWaterfallFlowLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource> delegate;
@property (nonatomic, assign) NSInteger numberOfColumns;

@end


NS_ASSUME_NONNULL_END
