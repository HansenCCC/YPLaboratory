//
//  KKWeChatCommentTableViewCell.h
//  QMKKXProduct
//  评论cell
//  Created by Hansen on 1/29/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKWeChatMomentsCommentModel.h"

@interface KKWeChatCommentTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *contentLabel;
//
@property (strong, nonatomic) KKWeChatMomentsCommentModel *cellModel;
AS_SINGLETON(KKWeChatMomentsCommentModel);
@end

