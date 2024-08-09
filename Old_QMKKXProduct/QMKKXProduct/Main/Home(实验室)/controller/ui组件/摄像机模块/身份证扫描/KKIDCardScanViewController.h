//
//  KKIDCardScanViewController.h
//  QMKKXProduct
//  定制身份证拍照相机
//  Created by 程恒盛 on 2019/7/1.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKPhotoSessionView.h"
#import "KKIDCardScanBackgroundView.h"

@interface KKIDCardScanViewController : KKBaseViewController
@property (nonatomic, strong) KKPhotoSessionView *sessionView;
@property (nonatomic, assign) CGRect effectiveRect;//截取的尺寸
@property (nonatomic, assign) BOOL shouldWriteToSavedPhotos;//是否写入本地 default NO
@property (nonatomic, strong) void (^whenFinsh)(UIImage *);//拍照回调
@end

