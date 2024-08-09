//
//  KKFileViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 11/25/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKFileViewController.h"
#import "KKLabelModel.h"
#import "KKLabelTableViewCell.h"
#import "KKFileCollectionViewCell.h"//fileCell

@interface KKFileViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray <KKLabelModel *> *datas;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation KKFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.filePath;
    [self setupSubviews];
    //异步处理消耗内存操作
    [self reloadDatas];
}
- (void)setupSubviews{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"KKFileCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KKFileCollectionViewCell"];
}
- (void)reloadDatas{
    [self.datas removeAllObjects];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = self.filePath;
    NSArray *tempArray = [manager contentsOfDirectoryAtPath:path error:nil];
    tempArray = [tempArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    for (NSString *item in tempArray) {
        NSString *currentPath = [path stringByAppendingPathComponent:item];
        NSDictionary *reslut = [manager attributesOfItemAtPath:currentPath error:nil];
        BOOL isDir;
        [manager fileExistsAtPath:currentPath isDirectory:&isDir];
        NSString *value;
        NSString *imageName;
        if (isDir) {
            //文件夹
            NSArray *tempArray = [manager contentsOfDirectoryAtPath:currentPath error:nil];
            value = [NSString stringWithFormat:@"%@ 个项目",@(tempArray.count).stringValue];
        }else{
            //文件
            double byte = 1000.0;
            long fileSize = reslut.fileSize/byte;
            double fileSizeTmp;
            NSString *tip;
            if (fileSize > byte * byte) {
                tip = @"GB";
                fileSizeTmp = fileSize/(byte * byte);
            }else if(fileSize > byte){
                tip = @"MB";
                fileSizeTmp = fileSize/(byte);
            }else{
                tip = @"KB";
                fileSizeTmp = fileSize;
            }
            value = [NSString stringWithFormat:@"%.2f %@",fileSizeTmp,tip];
            //
            NSString *pathExtension = [currentPath pathExtension];
            if ([[NSString fileZips] containsObject:pathExtension]) {
                //压缩包
                imageName = @"kk_icon_fileZip";
            }else if ([[NSString fileVideo] containsObject:pathExtension]) {
                //视频
                imageName = @"kk_icon_fileVideo";
            }else if ([[NSString fileImages] containsObject:pathExtension]) {
                //图片
                imageName = @"kk_icon_fileImage";
            }else if ([[NSString fileMusics] containsObject:pathExtension]) {
                //音乐
                imageName = @"kk_icon_fileMusic";
            }else if ([[NSString fileArchives] containsObject:pathExtension]) {
                //文档
                imageName = @"kk_icon_fileTxt";
            }else if ([[NSString fileWeb] containsObject:pathExtension]) {
                //文档
                imageName = @"kk_icon_fileWeb";
            }else {
                //未知类型
                imageName = @"kk_icon_fileUnknow";
            }
        }
        KKLabelModel *element = [[KKLabelModel alloc] initWithTitle:item value:value];
        element.info = reslut;
        element.imageName = imageName;
        [self.datas addObject:element];
    }
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat space = AdaptedWidth(10.f);//间隙
    NSInteger count = 4;//一行显示个数
    CGRect bounds = self.view.bounds;
    CGSize itemSize = CGSizeZero;
    itemSize.width = (bounds.size.width - (count + 2) * space)/count;
    itemSize.height = itemSize.width + 60.f;
    self.flowLayout.minimumLineSpacing = space;
    self.flowLayout.minimumInteritemSpacing = space;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    self.flowLayout.itemSize = itemSize;
}
#pragma mark - lazy load
- (NSMutableArray<KKLabelModel *> *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKLabelModel *cellModel = self.datas[indexPath.row];
    KKFileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KKFileCollectionViewCell" forIndexPath:indexPath];
    cell.cellModel = cellModel;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    KKLabelModel *cellModel = self.datas[indexPath.row];
    NSString *filePath = [self.filePath copy];
    NSString *filePathTmp = [filePath stringByAppendingPathComponent:cellModel.title];
    BOOL isDir;
    [manager fileExistsAtPath:filePathTmp isDirectory:&isDir];
    if (isDir) {
        //文件夹
        KKFileViewController *vc = [[KKFileViewController alloc] init];
        vc.filePath = filePathTmp;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //文件
        [KKFileBoxAlert showAlertWithFilePath:filePathTmp complete:^(KKAlertViewController *controler, NSInteger index) {
            [controler dismissViewControllerCompletion:nil];
        }];
    }
}
@end
