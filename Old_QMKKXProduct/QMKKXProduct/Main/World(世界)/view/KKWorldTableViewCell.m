//
//  KKWorldTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKWorldTableViewCell.h"

@interface KKWorldTableViewCell ()

@end

@implementation KKWorldTableViewCell
DEF_SINGLETON(KKWorldTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}
- (void)setupSubViews{
    //to do
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
}
- (void)setWorldModel:(KKFindPostedResponseModel *)worldModel{
    _worldModel = worldModel;
    //
    KKPostedIssueRequestModel *valueModel = worldModel.value;
    self.contentLabel.text = valueModel.content?:@"";
    NSDate *date = [NSDate dateWithString:worldModel.createTime?:@"" dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [NSDate kk_transformCurrentTime:date]?:@"";
    self.likesView.likes = @[];
    BOOL cutFlag = YES;
    self.cutLineMarkView.hidden = cutFlag;
    self.nameLabel.text = [NSString stringWithFormat:@"iOS实验室【%@】",worldModel.postedId?:@"--"];
    NSString *iconImage = [NSString stringWithFormat:@"kk_icon_%.2d",worldModel.postedId.intValue%12];
    [self.iconButton setImage:UIImageWithName(iconImage) forState:UIControlStateNormal];
    [self.commentButton setImage:UIImageWithName(@"kk_icon_points") forState:UIControlStateNormal];
    self.commentButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self layoutSubviews];
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(10.f);
    f1.origin.y = AdaptedWidth(15.f);
    f1.size = CGSizeMake(AdaptedWidth(40.f), AdaptedWidth(40.f));
    self.iconButton.layer.cornerRadius = AdaptedWidth(3.f);
    self.iconButton.frame = f1;
    //
    CGRect f2 = bounds;
    f2.origin.x = CGRectGetMaxX(f1) + AdaptedWidth(10.f);
    f2.origin.y = f1.origin.y;
    f2.size = [self.nameLabel sizeThatFits:CGSizeZero];
    f2.size.width = bounds.size.width - f2.origin.x - AdaptedWidth(10.f);
    self.nameLabel.frame = f2;
    //
    CGRect f3 = bounds;
    f3.origin.x = f2.origin.x;
    f3.origin.y = CGRectGetMaxY(f2) + AdaptedWidth(10.f);
    f3.size = [self.contentLabel sizeThatFits:CGSizeMake(bounds.size.width - f3.origin.x - AdaptedWidth(12.f), 0)];
    self.contentLabel.frame = f3;
    //
    CGRect fcv = bounds;
    fcv.origin.x = f3.origin.x;
    fcv.origin.y = CGRectGetMaxY(f3) + AdaptedWidth(10.f);
    CGFloat spaceWidth = AdaptedWidth(5.f);//cell中间距离
    CGFloat collecitonWidth = bounds.size.width - fcv.origin.x - AdaptedWidth(65.f);//collectionView宽度
    self.flowLayout.minimumLineSpacing = spaceWidth;
    self.flowLayout.minimumInteritemSpacing = spaceWidth;
    fcv.size = CGSizeMake(collecitonWidth, self.collectionView.contentSize.height);
    if (self.worldModel.value.imgUrls.count == 0) {
        //零张时
        fcv.origin.y = CGRectGetMaxY(f3);
        fcv.size.height = AdaptedWidth(0);
    }else if (self.worldModel.value.imgUrls.count == 1) {
        //一张时
        self.flowLayout.itemSize = CGSizeMake((collecitonWidth - 2 * spaceWidth)/3.f, (collecitonWidth - 2 * spaceWidth)/3.f);
        fcv.size.height = collecitonWidth/3.f * (1 + (self.worldModel.value.imgUrls.count - 1)/3);
    }else if (self.worldModel.value.imgUrls.count == 2) {
        //两张时
        self.flowLayout.itemSize = CGSizeMake((collecitonWidth - spaceWidth)/2, (collecitonWidth - spaceWidth)/2);
        fcv.size.height = collecitonWidth/2.f;
    }else if(self.worldModel.value.imgUrls.count > 2){
        //大于两张时
        self.flowLayout.itemSize = CGSizeMake((collecitonWidth - 2 * spaceWidth)/3.f, (collecitonWidth - 2 * spaceWidth)/3.f);
        fcv.size.height = collecitonWidth/3.f * (1 + (self.worldModel.value.imgUrls.count - 1)/3);
    }
    self.collectionView.frame = fcv;
    //
    CGRect f4 = bounds;
    f4.origin.x = f3.origin.x;
    f4.origin.y = CGRectGetMaxY(fcv) + AdaptedWidth(12.f);
    f4.size = [self.timeLabel sizeThatFits:CGSizeZero];
    self.timeLabel.frame = f4;
    //30 * 18
    CGRect f5 = bounds;
    f5.origin.y = CGRectGetMaxY(fcv) + AdaptedWidth(12.f);
    f5.size = CGSizeMake(AdaptedWidth(30.f), AdaptedWidth(18.f));
    f5.origin.x = bounds.size.width - f5.size.width - AdaptedWidth(12.f);
    self.commentButton.frame = f5;
    //
    CGRect f6 = bounds;
    f6.origin.x = f4.origin.x;
    f6.origin.y = CGRectGetMaxY(f4) + AdaptedWidth(12.f);
    f6.size.width = bounds.size.width - f6.origin.x - AdaptedWidth(12.f);
    f6.size.height = [self.likesView sizeThatFits:CGSizeMake(f6.size.width, 0)].height;
    self.likesView.frame = f6;
    //
    CGRect f7 = bounds;
    f7.size.height = AdaptedWidth(0.5f);
    f7.origin.y = CGRectGetMaxY(f6);
    f7.origin.x = f6.origin.x;
    f7.size.width = f6.size.width;
    self.cutLineMarkView.frame = f7;
    //
    CGRect f8 = bounds;
    f8.origin.y = CGRectGetMaxY(f7);
    f8.origin.x = f7.origin.x;
    f8.size.width = f7.size.width;
    CGFloat height = 0.f;
    f8.size.height = height;
    if (self.cellModel.comments.count > 0) {
        f8.size.height += AdaptedWidth(6.f);
    }
    self.tableView.frame = f8;
    //
    CGRect fMax = bounds;
    fMax.size.height = AdaptedWidth(0.5f);
    fMax.origin.y = bounds.size.height - fMax.size.height;
    self.markView.frame = fMax;
    //to do
    self.iconButton.backgroundColor = [UIColor grayColor];
    self.commentButton.backgroundColor = KKColor_F0F0F0;
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKImageViewCollectionViewCell" forIndexPath:indexPath];
    NSString *imageUrl = self.worldModel.value.imgUrls[indexPath.row];
    [cell.imageView kk_setImageWithUrl:imageUrl];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.worldModel.value.imgUrls.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.worldModel.value.imgUrls.count; i ++) {
        NSString *image = self.worldModel.value.imgUrls[i];
        KKImageBrowserModel *model = [[KKImageBrowserModel alloc] initWithUrl:image.toURL type:KKImageBrowserImageType];
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:index];
        model.toView = cell;
        [datas addObject:model];
    }
    KKImageBrowser *view = [[KKImageBrowser alloc] init];
    view.images = datas;
    view.index = indexPath.row;
    [view show];
}
@end
