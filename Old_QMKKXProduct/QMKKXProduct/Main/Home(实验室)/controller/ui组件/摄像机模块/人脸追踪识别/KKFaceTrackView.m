//
//  KKFaceTrackView.m
//  QMKKXProduct
//
//  Created by Hansen on 5/6/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKFaceTrackView.h"


@implementation KKFaceTrackFaceObjectView
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.borderWidth = AdaptedWidth(1.5f);
    self.layer.borderColor = [UIColor yellowColor].CGColor;
}
@end

@interface KKFaceTrackView ()
@property (strong, nonatomic) NSMutableArray <UIView *>*views;
@property (strong, nonatomic) UIView *contentView;

@end

@implementation KKFaceTrackView
- (instancetype)init{
    if (self = [super init]) {
        self.views = [[NSMutableArray alloc] init];
        self.contentView = [[UIView alloc] init];
        [self addSubview:self.contentView];
        self.userInteractionEnabled = NO;
    }
    return self;
}
- (void)setFaceObjects:(NSArray<AVMetadataFaceObject *> *)faceObjects{
    _faceObjects = faceObjects;
    [self needsUpdateFacesView];
}
- (void)needsUpdateFacesView{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < self.faceObjects.count; i++) {
        AVMetadataFaceObject *faceObject = self.faceObjects[i];
        AVMetadataFaceObject *transformFaceObject = (AVMetadataFaceObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:faceObject];
        UIView *subview;
        if (self.views.count < i) {
            subview = self.views[i];
        }else{
            subview = [[KKFaceTrackFaceObjectView alloc] init];
            [self.views addObject:subview];
        }
        [self.contentView addSubview:subview];
        subview.frame = transformFaceObject.bounds;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    self.contentView.frame = bounds;
}
@end
