//
//  KKQRCodeSessionView.m
//  自定义相机
//
//  Created by 力王 on 16/11/21.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "KKQRCodeSessionView.h"
#import <AVFoundation/AVFoundation.h>

@interface KKQRCodeSessionView ()
@property(nonatomic, strong) AVCaptureMetadataOutput *qrcCodeOutput;

@end

@implementation KKQRCodeSessionView
-(instancetype)init{
    if (self = [super init]) {
        //判断是否支持相机
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            return self;
        }
        [self.qrcCodeOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        if ([self.session canAddOutput:self.qrcCodeOutput]){
            [self.session addOutput:self.qrcCodeOutput];
        }
        self.type = KKMetadataObjectTypeQR;
    }
    return self;
}
-(void)setType:(KKMetadataObjectType)type{
    _type = type;
    //防止在模拟器下挂掉
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        return;
    }
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return;
    }
    if (type == KKMetadataObjectTypeQR){
        [self.qrcCodeOutput setMetadataObjectTypes:@[
                                                     AVMetadataObjectTypeQRCode,
                                                     AVMetadataObjectTypeEAN13Code,
                                                     AVMetadataObjectTypeEAN8Code,
                                                     AVMetadataObjectTypeCode128Code
                                                     ]];
    }else{
        [self.qrcCodeOutput setMetadataObjectTypes:@[AVMetadataObjectTypeFace]];
    }
}
-(AVCaptureOutput *)output{
    return self.qrcCodeOutput;
}
-(AVCaptureMetadataOutput *)qrcCodeOutput{
    if (!_qrcCodeOutput) {
        _qrcCodeOutput = [[AVCaptureMetadataOutput alloc] init];
    }
    return _qrcCodeOutput;
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{//扫描结果回调
    if (self.type == KKMetadataObjectTypeQR) {
        if ([metadataObjects count] >0){
            //停止扫描
            [self stopRunning];
            AVMetadataObject * metadataObject = [metadataObjects objectAtIndex:0];
            if (self.whenFinish){
                self.whenFinish(metadataObject);
            }
        }
    }else if(self.type == KKMetadataObjectTypeFace){
        if ([self.delegate respondsToSelector:@selector(captureOutput:didOutputMetadataObjects:fromConnection:)]){
            [self.delegate captureOutput:captureOutput didOutputMetadataObjects:metadataObjects fromConnection:connection];
        }
            
    }
}
@end
