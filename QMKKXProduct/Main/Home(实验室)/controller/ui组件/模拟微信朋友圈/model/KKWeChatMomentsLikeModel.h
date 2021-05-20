//
//  KKWeChatMomentsLikeModel.h
//  QMKKXProduct
//
//  Created by Hansen on 1/28/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKWeChatMomentsLikeModel : NSObject
@property (strong, nonatomic) NSString *userId;//id
@property (strong, nonatomic) NSString *userName;//昵称
- (instancetype)initWithId:(NSString *)userId userName:(NSString *)userName;
@end

