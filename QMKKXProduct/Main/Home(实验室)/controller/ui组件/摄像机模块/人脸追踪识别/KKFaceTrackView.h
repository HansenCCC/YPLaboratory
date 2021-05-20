//
//  KKFaceTrackView.h
//  QMKKXProduct
//
//  Created by Hansen on 5/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

//单个faceObject 
@interface KKFaceTrackFaceObjectView : UIView

@end

//实现人脸追踪低耗展示view
@interface KKFaceTrackView : UIView
@property (copy, nonatomic) NSArray <AVMetadataFaceObject *>* faceObjects;//相机会返回人脸位置
@property (weak, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;//弱引用视频输出展示layer，系统自带

@end

