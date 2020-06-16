//
//  KKWeChatPayModel.h
//  QMKKXProduct
//
//  Created by Hansen on 6/15/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKWeChatPayModel : NSObject
@property (strong, nonatomic) NSString *appid;
@property (strong, nonatomic) NSString *noncestr;
@property (strong, nonatomic) NSString *package;
@property (strong, nonatomic) NSString *partnerid;
@property (strong, nonatomic) NSString *prepayid;
@property (strong, nonatomic) NSString *sign;
@property (strong, nonatomic) NSString *timestamp;

@end

