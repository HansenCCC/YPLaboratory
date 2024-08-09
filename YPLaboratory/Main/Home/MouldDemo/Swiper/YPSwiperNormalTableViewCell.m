//
//  YPSwiperNormalTableViewCell.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/26.
//

#import "YPSwiperNormalTableViewCell.h"

@interface YPSwiperNormalTableViewCell () <YPSwiperViewDelegate>

@property (nonatomic, strong) YPSwiperView *swiperView;

@end

@implementation YPSwiperNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self.contentView addSubview:self.swiperView];
}

- (void)setCellModel:(YPPageRouter *)cellModel {
    [super setCellModel:cellModel];
    [self.swiperView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    self.swiperView.frame = f1;
}

#pragma mark - getters | setters

- (YPSwiperView *)swiperView {
    if (!_swiperView) {
        _swiperView = [[YPSwiperView alloc] init];
        _swiperView.delegate = self;
        _swiperView.autoplay = YES;
        _swiperView.cellClass = @[
            [UICollectionViewCell class],
        ];
    }
    return _swiperView;
}

#pragma mark - YPSwiperViewDelegate

- (UICollectionViewCell *)swiperCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yp_randomColor];
    return cell;
}

- (NSInteger)swiperCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *extend = self.cellModel.extend;
    if ([extend isKindOfClass:[NSArray class]]) {
        return extend.count;
    }
    return 0;
}

@end
