//
//  KKLabelsView.h
//  KKLAFProduct
//
//  Created by Hansen on 3/18/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>

//官方发放的标签label
@interface KKOfficialLabelsModel : NSObject
@property (strong, nonatomic) NSString *labels_id;//label id
@property (strong, nonatomic) NSString *label;//label名称
@property (strong, nonatomic) NSString *color;//label颜色

@end


@interface KKOfficialLabelsCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat maximumInteritemSpacing;//最大距离

@end

@interface KKOfficialLabelsCollecitonViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *titleLabel;
AS_SINGLETON(KKOfficialLabelsCollecitonViewCell);
@end

@interface KKLabelsView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) NSMutableArray <KKOfficialLabelsModel *>*datas;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) KKOfficialLabelsCollectionViewFlowLayout *flowLayout;
@property (copy  , nonatomic) void (^whenAcitonClick)(KKLabelsView *view,NSInteger index);

- (void)reloadDatas;
@end
