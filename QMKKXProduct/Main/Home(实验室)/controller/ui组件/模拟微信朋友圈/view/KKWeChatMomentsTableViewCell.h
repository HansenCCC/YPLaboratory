//
//  KKWeChatMomentsTableViewCell.h
//  QMKKXProduct
//  朋友圈cell
//  Created by Hansen on 1/16/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKWeChatMomentsModel.h"
#import "KKWeChatMomentsLikesView.h"

@class KKWeChatMomentsTableViewCell;
typedef void(^KKWeChatMomentsTableViewCellBlock)(NSInteger index,KKWeChatMomentsTableViewCell *cacheCell);

@interface KKWeChatMomentsTableViewCell : UITableViewCell
@property (strong, nonatomic) UIButton *iconButton;//icon
@property (strong, nonatomic) UILabel *nameLabel;//昵称
@property (strong, nonatomic) UILabel *contentLabel;//内容
@property (strong, nonatomic) UILabel *timeLabel;//时间
@property (strong, nonatomic) UIButton *commentButton;//icon
@property (strong, nonatomic) UICollectionView *collectionView;//图片集合
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;//flowLayout
@property (strong, nonatomic) KKWeChatMomentsLikesView *likesView;//喜欢
@property (strong, nonatomic) UIView *cutLineMarkView;//切割线条
@property (strong, nonatomic) UITableView *tableView;//评论集合
@property (strong, nonatomic) UIView *markView;//线条
@property (strong, nonatomic) KKWeChatMomentsTableViewCellBlock whenActionBlock;
//to do
@property (strong, nonatomic) KKWeChatMomentsModel *cellModel;
AS_SINGLETON(KKWeChatMomentsTableViewCell);
@end
