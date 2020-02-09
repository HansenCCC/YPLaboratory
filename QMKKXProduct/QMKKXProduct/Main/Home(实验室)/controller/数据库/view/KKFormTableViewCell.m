//
//  KKFormTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 2/4/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKFormTableViewCell.h"
#import "KKFormCollectionViewCell.h"

@interface KKFormTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation KKFormTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubviews];
}
- (void)setupSubviews{
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKFormCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKFormCollectionViewCell"];
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *items = (NSArray *)self.cellModel.info;
    KKFormCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKFormCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = KKColor_RANDOM;
    cell.titleLabel.text = items[indexPath.row]?[NSString stringWithFormat:@"%@",items[indexPath.row]]:@"";
    cell.titleLabel.layer.borderWidth = AdaptedWidth(0.5f);
    cell.titleLabel.layer.borderColor = KKColor_000000.CGColor;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *items = (NSArray *)self.cellModel.info;
    return items.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = collectionView.size;
    size.width = AdaptedWidth(100.f);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.whenSelectItemClick) {
        self.whenSelectItemClick(self, indexPath);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.whenScrollViewDidScroll) {
        self.whenScrollViewDidScroll(scrollView);
    }
}
- (void)setContentOffset:(CGPoint)contentOffset{
    _contentOffset = contentOffset;
    [self.collectionView setContentOffset:contentOffset];
}
@end
