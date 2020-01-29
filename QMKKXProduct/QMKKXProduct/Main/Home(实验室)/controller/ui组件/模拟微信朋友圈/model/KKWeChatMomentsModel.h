//
//  KKWeChatMomentsModel.h
//  QMKKXProduct
//
//  Created by Hansen on 1/27/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKWeChatMomentsCommentModel.h"
#import "KKWeChatMomentsLikeModel.h"

@interface KKWeChatMomentsModel : NSObject
@property (strong, nonatomic) NSString *iconUrl;//图片url
@property (strong, nonatomic) NSString *nickname;//名字
@property (strong, nonatomic) NSString *contentValue;//朋友圈内容
@property (strong, nonatomic) NSString *timestampDate;//时间
@property (strong, nonatomic) NSArray <KKWeChatMomentsLikeModel *> *likes;//喜欢
@property (strong, nonatomic) NSArray <KKWeChatMomentsCommentModel *> *comments;//评论
@property (strong, nonatomic) NSArray <NSString *>*images;//图片样式
@end

