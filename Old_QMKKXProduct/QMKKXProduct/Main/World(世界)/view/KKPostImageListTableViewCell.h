//
//  KKPostImageListTableViewCell.h
//  QMKKXProduct
//
//  Created by Hansen on 2/12/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPostImageListTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate>
//属性
@property (assign, nonatomic) int maxCells;//做多选择多少个 default 9
@property (strong, nonatomic) NSMutableArray <UIImage *>*datas;//cell
@property (strong, nonatomic) KKLabelModel *cellModel;//储存选中图片
//ui
@property (strong, nonatomic) UIView *secondContentView;
@property (assign, nonatomic) UIEdgeInsets contentInsets;//间距
@property (strong, nonatomic) UICollectionView *collectionView;//图片集合
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;//flowLayout
//自动高度
@property (strong, nonatomic) void(^whenNeedUpdateHeight)(void);//当需要更新高度时响应
AS_SINGLETON(KKPostImageListTableViewCell);
@end

