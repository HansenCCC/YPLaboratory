//
//  KKWeChatImageListTableViewCell.m
//  QMKKXProduct
//
//  Created by Hansen on 2/12/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKWeChatImageListTableViewCell.h"

@implementation KKWeChatImageListTableViewCell
DEF_SINGLETON(KKWeChatImageListTableViewCell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubview];
        //取消选中效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.datas = [[NSMutableArray alloc] init];
        self.maxCells = 9;//default
    }
    return self;
}
- (void)setupSubview{
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
    NSArray *selectPhotos = self.datas;
    //
    CGRect fcv = bounds;
    fcv.origin.x = self.contentInsets.left;
    fcv.origin.y = 0;
    CGFloat spaceWidth = AdaptedWidth(5.f);//cell中间距离
    CGFloat collecitonWidth = bounds.size.width - fcv.origin.x - AdaptedWidth(55.f);//collectionView宽度
    self.flowLayout.minimumLineSpacing = spaceWidth;
    self.flowLayout.minimumInteritemSpacing = spaceWidth;
    fcv.size = CGSizeMake(collecitonWidth, self.collectionView.contentSize.height);
    self.flowLayout.itemSize = CGSizeMake((collecitonWidth - 2 * spaceWidth)/3.f, (collecitonWidth - 2 * spaceWidth)/3.f);
    fcv.size.height = collecitonWidth/3.f * (1 + (selectPhotos.count - 1)/3);
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
        [top showError:@"敬请期待！"];
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
}
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    UIViewController *top = [self topViewController];
    [top hideLoading];
    //
    if (self.whenNeedUpdateHeight) {
        self.whenNeedUpdateHeight();
    }
}
@end
