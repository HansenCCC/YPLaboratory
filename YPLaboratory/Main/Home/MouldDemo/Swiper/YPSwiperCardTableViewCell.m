//
//  YPSwiperCardTableViewCell.m
//  YPLaboratory
//
//  Created by Hansen on 2023/6/26.
//

#import "YPSwiperCardTableViewCell.h"

@interface YPSwiperCardCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *boxView;

@end

@implementation YPSwiperCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.boxView = [[UIView alloc] init];
        self.boxView.layer.cornerRadius = 10.f;
        [self addSubview:self.boxView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 10.f;
    f1.size.width = bounds.size.width - 2 * f1.origin.x;
    self.boxView.frame = f1;
}

@end


@interface YPSwiperCardTableViewCell () <YPSwiperViewDelegate>

@property (nonatomic, strong) YPSwiperView *swiperView;

@end

@implementation YPSwiperCardTableViewCell

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
            [YPSwiperCardCollectionViewCell class],
        ];
    }
    return _swiperView;
}

#pragma mark - YPSwiperViewDelegate

- (UICollectionViewCell *)swiperCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YPSwiperCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPSwiperCardCollectionViewCell" forIndexPath:indexPath];
    cell.boxView.backgroundColor = [UIColor yp_randomColor];
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
