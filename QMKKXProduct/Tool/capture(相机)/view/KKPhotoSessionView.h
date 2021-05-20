//
//  KKPhotoSessionView.h
//  自定义相机
//  拍照
//  Created by 力王 on 16/11/28.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "KKAVCaptureBaseSessionView.h"

@interface KKPhotoSessionView : KKAVCaptureBaseSessionView <AVCapturePhotoCaptureDelegate>
@property(nonatomic, strong) void (^whenTakePhoto) (UIImage *photo);//完成拍照回调

//拍照
-(void)takePhoto;
@end
