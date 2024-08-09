//
//  KKWeChatMomentsLikesView.h
//  QMKKXProduct
//  点赞视图
//  Created by Hansen on 1/28/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKWeChatMomentsLikeModel.h"

@interface KKWeChatMomentsLikesView : UIView
@property (strong, nonatomic) NSArray <KKWeChatMomentsLikeModel *> *likes;//喜欢
@property (strong, nonatomic) UILabel *contentLabel;

@end

