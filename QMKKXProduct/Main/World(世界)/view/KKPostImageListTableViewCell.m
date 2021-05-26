//
//  KKPostImageListTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 2/12/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKPostImageListTableViewCell.h"

@implementation KKPostImageListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubview];
        //取消选中效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.datas = [[NSMutableArray alloc] init];
        self.maxCells = 9;//default
        self.contentInsets = UIEdgeInsetsMake(AdaptedWidth(15.f), AdaptedWidth(15.f), AdaptedWidth(15.f), AdaptedWidth(15.f));
    }
    return self;
}
- (void)setupSubview{
    //to do
    self.backgroundColor = KKColor_F2F2F7;
    //
    self.secondContentView = [[UIView alloc] init];
    self.secondContentView.backgroundColor = KKColor_FFFFFF;
    [self.contentView addSubview:self.secondContentView];
    //
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = KKColor_FFFFFF;
    self.collectionView.scrollEnabled = NO;
    [self.secondContentView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKImageViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKImageViewCollectionViewCell"];
}
- (void)setCellModel:(KKLabelModel *)cellModel{
    _cellModel = cellModel;
    [self reloadDatas];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    NSArray *selectPhotos = self.cellModel.info;
    if (selectPhotos) {
        [self.datas addObjectsFromArray:selectPhotos];
    }
    //添加添加按钮
    if (selectPhotos.count < self.maxCells) {
        UIImage *image = UIImageWithName(@"kk_icon_addImage");
        [self.datas addObject:image];
    }
    [self.collectionView reloadData];
    [self layoutSubviews];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = AdaptedWidth(15.f);
    f1.size.width = bounds.size.width - f1.origin.x * 2;
    self.secondContentView.frame = f1;
    //
    NSArray *selectPhotos = self.datas;
    //
    CGRect fcv = bounds;
    NSInteger number = 4;//一行显示几个图片
    fcv.origin.x = self.contentInsets.left;
    fcv.origin.y = 0;
    CGFloat spaceWidth = AdaptedWidth(5.f);//cell中间距离
    CGFloat collecitonWidth = f1.size.width - fcv.origin.x - self.contentInsets.right;//collectionView宽度
    self.flowLayout.minimumLineSpacing = spaceWidth;
    self.flowLayout.minimumInteritemSpacing = spaceWidth;
    fcv.size = CGSizeMake(collecitonWidth, self.collectionView.contentSize.height);
    self.flowLayout.itemSize = CGSizeMake((collecitonWidth - (number - 1) * spaceWidth)/number, (collecitonWidth - (number - 1) * spaceWidth)/number);
    fcv.size.height = collecitonWidth/number * (1 + (selectPhotos.count - 1)/number);
    self.collectionView.frame = fcv;
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *selectPhotos = self.datas;
    KKImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKImageViewCollectionViewCell" forIndexPath:indexPath];
    UIImage *image = selectPhotos[indexPath.row];
    [cell.imageView setImage:image];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *selectPhotos = self.datas;
    return selectPhotos.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *selectPhotos = self.cellModel.info;
    UIViewController *top = [self topViewController];
    if (indexPath.row == (self.datas.count - 1)&&selectPhotos.count != self.maxCells) {
        //选择图片
        NSArray *selectPhotos = self.cellModel.info;
        long needNumber = self.maxCells - selectPhotos.count;
        KKImagePickerController *pick = [[KKImagePickerController alloc] initWithMaxImagesCount:needNumber delegate:self];
        [top presentViewController:pick animated:YES completion:nil];
        [top showLoading];
    }else{
        //点击图片详情
        //展示图片
        NSMutableArray *datas = [[NSMutableArray alloc] init];
        for (int i = 0; i < selectPhotos.count; i ++) {
            UIImage *image = selectPhotos[i];
            KKImageBrowserModel *model = [[KKImageBrowserModel alloc] initWithImage:image];
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
}
#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    UIViewController *top = [self topViewController];
    //选择图片
    NSArray *selectPhotos = self.cellModel.info;
    NSMutableArray *images = [[NSMutableArray alloc] initWithArray:selectPhotos];
    //Photos
    [images addObjectsFromArray:photos];
    self.cellModel.info = [images copy];
    [self reloadDatas];
    [top hideLoading];
    //
    if (self.whenNeedUpdateHeight) {
        self.whenNeedUpdateHeight();
    }
    [self kk_reloadCurrentTableViewCell];
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    UIViewController *top = [self topViewController];
    [top hideLoading];
    //
    if (self.whenNeedUpdateHeight) {
        self.whenNeedUpdateHeight();
    }
    [self kk_reloadCurrentTableViewCell];
}
#pragma mark - 自适应高度
DEF_SINGLETON(KKPostImageListTableViewCell);
- (void)kk_extensionCellModel:(id)cellModel{
    [super kk_extensionCellModel:cellModel];
    self.cellModel = cellModel;
    [self reloadDatas];
}
- (CGFloat)kk_extensionCellHeight:(id)cellModel tableView:(UITableView *)tableView{
    [super kk_extensionCellHeight:cellModel tableView:tableView];
    CGFloat height = CGRectGetMaxY(self.collectionView.frame) + AdaptedWidth(5.f);
    return height;
}
@end
