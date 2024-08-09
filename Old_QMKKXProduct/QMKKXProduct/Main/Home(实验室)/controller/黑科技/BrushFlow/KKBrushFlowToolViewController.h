//
//  KKBrushFlowToolViewController.h
//  QMKKXProduct
//
//  Created by Hansen on 2021/9/10.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKBrushFlowToolViewController : KKBaseViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) void (^whenRequestComplete)(NSInteger requestCount);

@end

NS_ASSUME_NONNULL_END
