//
//  KKQRCodeSessionView.h
//  自定义相机
//  二维码扫描&人脸识别
//  Created by 力王 on 16/11/21.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "KKAVCaptureBaseSessionView.h"

typedef enum : NSUInteger {
    KKMetadataObjectTypeQR = 0,//二维码
    KKMetadataObjectTypeFace,//人脸
} KKMetadataObjectType;

@protocol KKQRCodeSessionViewDelegate <NSObject>
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection;//识别成功回调
@end

@interface KKQRCodeSessionView : KKAVCaptureBaseSessionView<AVCaptureMetadataOutputObjectsDelegate>
//扫描类型(默认人脸识别类型)
@property(nonatomic, assign) KKMetadataObjectType type;
//扫描成功后回调此方法
@property(nonatomic, strong) void (^whenFinish) (AVMetadataObject *codeObject);
//delegate
@property(nonatomic, strong) id<KKQRCodeSessionViewDelegate> delegate;
@end
