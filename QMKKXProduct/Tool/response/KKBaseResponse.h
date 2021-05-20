//
//  KKBaseResponse.h
//  FanRabbit
//  基本返回参数
//  Created by 程恒盛 on 2019/5/29.
//  Copyright © 2019 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 响应格式：
 response:{
 "status":"success",
 "message":"ok",
 "data":""
 }
 */
@interface KKBaseResponse : NSObject
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) NSInteger code;
@property (strong, nonatomic) id data;

- (instancetype)initWithData:(id)data;

@end


