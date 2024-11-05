//
//  YPCollectionViewWaterfallFlowLayout.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/5.
//

#import "YPCollectionViewWaterfallFlowLayout.h"

@interface YPCollectionViewWaterfallFlowLayout ()

@property (nonatomic, strong) NSMutableArray *columnHeights;
@property (nonatomic, strong) NSMutableArray *itemAttributes;

@end

@implementation YPCollectionViewWaterfallFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        NSInteger numberOfColumns = 2; // 一行两个
        if (YP_IS_IPAD) {
            numberOfColumns = 3;
        }
        self.numberOfColumns = numberOfColumns;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.columnHeights = [NSMutableArray array];
    self.itemAttributes = [NSMutableArray array];
    
    NSInteger numberOfColumns = self.numberOfColumns;
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    CGFloat columnWidth = (collectionViewWidth - contentInset.left + contentInset.right - self.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns;
    CGFloat minimumLineSpacing = self.minimumLineSpacing;
    
    for (NSInteger column = 0; column < numberOfColumns; column++) {
        [self.columnHeights addObject:@(0)];
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger item = 0; item < itemCount; item++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];
        
        NSInteger shortestColumn = 0;
        CGFloat shortestHeight = [self.columnHeights[0] floatValue];
        
        for (NSInteger column = 1; column < numberOfColumns; column++) {
            CGFloat columnHeight = [self.columnHeights[column] floatValue];
            if (columnHeight < shortestHeight) {
                shortestHeight = columnHeight;
                shortestColumn = column;
            }
        }
        
        CGFloat x = shortestColumn * (columnWidth + self.minimumInteritemSpacing);
        CGFloat y = shortestHeight + minimumLineSpacing;
        
        CGRect frame = CGRectMake(x, y, columnWidth, itemHeight);
        UICollectionViewLayoutAttributes *itemAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        itemAttribute.frame = frame;
        [self.itemAttributes addObject:itemAttribute];
        
        self.columnHeights[shortestColumn] = @(CGRectGetMaxY(frame));
    }
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in self.itemAttributes) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [layoutAttributes addObject:attributes];
        }
    }
    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemAttributes[indexPath.item];
}

- (CGSize)collectionViewContentSize {
    CGFloat contentHeight = [[self.columnHeights valueForKeyPath:@"@max.floatValue"] floatValue];
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), contentHeight);
}


@end
