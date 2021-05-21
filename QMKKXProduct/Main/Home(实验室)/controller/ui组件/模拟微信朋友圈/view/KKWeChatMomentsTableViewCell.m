//
//  KKWeChatMomentsTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 1/16/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatMomentsTableViewCell.h"
#import "KKWeChatCommentTableViewCell.h"

@interface KKWeChatMomentsTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@end

@implementation KKWeChatMomentsTableViewCell
DEF_SINGLETON(KKWeChatMomentsTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
        //取消选中效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setupSubviews{
    //40dp * 40 dp
    self.iconButton = [[UIButton alloc] init];
    self.iconButton.clipsToBounds = YES;
    [self.contentView addSubview:self.iconButton];
    //
    self.nameLabel = [UILabel labelWithFont:AdaptedBoldFontSize(15.f) textColor:KKColor_626787];
    [self.contentView addSubview:self.nameLabel];
    //
    self.contentLabel = [UILabel labelWithFont:AdaptedFontSize(15.f) textColor:KKColor_1A1A1A];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    //
    self.timeLabel = [UILabel labelWithFont:AdaptedFontSize(12.f) textColor:KKColor_AFAFAF];
    [self.contentView addSubview:self.timeLabel];
    //
    self.commentButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.commentButton];
    //
    self.likesView = [[KKWeChatMomentsLikesView alloc] init];
    self.likesView.backgroundColor = KKColor_F6F6F6;
    [self.contentView addSubview:self.likesView];
    //
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = KKColor_FFFFFF;
    self.collectionView.scrollEnabled = NO;
    [self.contentView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKImageViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKImageViewCollectionViewCell"];
    //
    self.cutLineMarkView = [[UIView alloc] init];
    self.cutLineMarkView.backgroundColor = KKColor_E5E5E5;
    [self.contentView addSubview:self.cutLineMarkView];
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = KKColor_F6F6F6;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[KKWeChatCommentTableViewCell class] forCellReuseIdentifier:@"KKWeChatCommentTableViewCell"];
    [self.contentView addSubview:self.tableView];
    //
    self.markView = [[UIView alloc] init];
    self.markView.backgroundColor = KKColor_E5E5E5;
    [self.contentView addSubview:self.markView];
}
- (void)setCellModel:(KKWeChatMomentsModel *)cellModel{
    _cellModel = cellModel;
    [self.iconButton kk_setImageWithURL:cellModel.iconUrl];
    self.nameLabel.text = cellModel.nickname?:@"";
    self.contentLabel.text = cellModel.contentValue?:@"";
    self.timeLabel.text = cellModel.timestampDate?:@"";
    self.likesView.likes = cellModel.likes;
    BOOL cutFlag = YES;
    if (cellModel.likes.count > 0&&cellModel.comments.count > 0) {
        cutFlag = NO;
    }
    self.cutLineMarkView.hidden = cutFlag;
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
    if (self.cellModel.images.count == 0) {
        //零张时
        fcv.origin.y = CGRectGetMaxY(f3);
        fcv.size.height = AdaptedWidth(0);
    }else if (self.cellModel.images.count == 1) {
        //一张时
        self.flowLayout.itemSize = CGSizeMake((collecitonWidth - 2 * spaceWidth)/3.f, (collecitonWidth - 2 * spaceWidth)/3.f);
        fcv.size.height = collecitonWidth/3.f * (1 + (self.cellModel.images.count - 1)/3);
    }else if (self.cellModel.images.count == 2) {
        //两张时
        self.flowLayout.itemSize = CGSizeMake((collecitonWidth - spaceWidth)/2, (collecitonWidth - spaceWidth)/2);
        fcv.size.height = collecitonWidth/3.f;
    }else if(self.cellModel.images.count > 2){
        //大于两张时
        self.flowLayout.itemSize = CGSizeMake((collecitonWidth - 2 * spaceWidth)/3.f, (collecitonWidth - 2 * spaceWidth)/3.f);
        fcv.size.height = collecitonWidth/3.f * (1 + (self.cellModel.images.count - 1)/3);
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
    for (KKWeChatMomentsCommentModel *cellModel in self.cellModel.comments) {
        KKWeChatCommentTableViewCell *cell = [KKWeChatCommentTableViewCell sharedInstance];
        cell.bounds = f8;
        cell.cellModel = cellModel;
        CGSize size = [cell sizeThatFits:CGSizeMake(cell.bounds.size.width, 0)];
        height += size.height;
    }
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
    self.commentButton.backgroundColor = [UIColor grayColor];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKImageViewCollectionViewCell" forIndexPath:indexPath];
    NSString *imageUrl = self.cellModel.images[indexPath.row];
    [cell.imageView kk_setImageWithUrl:imageUrl];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellModel.images.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.cellModel.images.count; i ++) {
        NSString *image = self.cellModel.images[i];
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
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKWeChatMomentsCommentModel *cellModel = self.cellModel.comments[indexPath.row];
    KKWeChatCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KKWeChatCommentTableViewCell"];
    cell.cellModel = cellModel;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellModel.comments.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKWeChatMomentsCommentModel *cellModel = self.cellModel.comments[indexPath.row];
    KKWeChatCommentTableViewCell *cell = [KKWeChatCommentTableViewCell sharedInstance];
    cell.bounds = tableView.bounds;
    cell.cellModel = cellModel;
    CGSize size = [cell sizeThatFits:CGSizeMake(cell.bounds.size.width, 0)];
    CGFloat height = size.height;
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //to do
}
@end
