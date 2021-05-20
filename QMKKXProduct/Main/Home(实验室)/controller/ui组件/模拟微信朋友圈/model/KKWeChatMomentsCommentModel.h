//
//  KKWeChatMomentsCommentModel.h
//  QMKKXProduct
//
//  Created by Hansen on 1/28/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKWeChatMomentsCommentModel : NSObject
@property (strong, nonatomic) NSString *userId;//id
@property (strong, nonatomic) NSString *userName;//昵称
@property (strong, nonatomic) NSString *content;//内容
@property (strong, nonatomic) KKWeChatMomentsCommentModel *replyModel;//回复model
- (instancetype)initWithId:(NSString *)userId userName:(NSString *)userName content:(NSString *)content;
@end

