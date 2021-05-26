//
//  KKFindPostedRequestModel.h
//  QMKKXProduct
//
//  Created by Hansen on 5/26/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKPostedIssueRequestModel.h"

@interface KKFindPostedRequestModel : NSObject
@property (strong, nonatomic) NSString *pageNum;
@property (strong, nonatomic) NSString *pageSize;

@end

@interface KKFindPostedResponseModel : NSObject
@property (strong, nonatomic) NSString *postedId;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) KKPostedIssueRequestModel *value;

@end

