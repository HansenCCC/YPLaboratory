//
//  KKMapAlert.m
//  KKLAFProduct
//
//  Created by Hansen on 8/25/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKMapAlert.h"
#import "KKMapView.h"

@interface KKMapAlert ()<MAMapViewDelegate>
@property (strong, nonatomic) KKMapView *mapView;
@property (assign, nonatomic) BOOL isMoving;//是否已经移动过

@end

@implementation KKMapAlert
- (instancetype)init{
    if (self = [super init]) {
        self.contentWidth = AdaptedWidth(270.f);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //地图初始化
    self.mapView = [[KKMapView alloc] init];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.mapView setShowsUserLocation:YES];
    [self.contentView addSubview:self.mapView];
}
//布局
- (void)displayContentWillLayoutSubviews{
    CGFloat space = AdaptedWidth(10.f);
    CGRect f1 = self.contentView.frame;
    CGRect f2 = self.view.bounds;
    f2.origin.y = CGRectGetMaxY(self.titleLabel.frame) + space;
    f2.origin.x = space;
    f2.size.width = f1.size.width - 2 * f2.origin.x;
    f2.size.height = f2.size.width;
    self.mapView.frame = f2;
    self.displayContentView = self.mapView;
}
/// 展示地图
/// @param whenCompleteBlock 回调
+ (instancetype)showMapComplete:(KKAlertViewControllerBlock )whenCompleteBlock{
    KKMapAlert *alert = (KKMapAlert *)[KKMapAlert showCustomWithTitle:@"标出丢失物品位置" textDetail:nil leftTitle:@"取消" rightTitle:@"确定" isOnlyOneButton:NO isShowCloseButton:NO canTouchBeginMove:NO complete:whenCompleteBlock];
    return alert;
}

#pragma mark - do
//更新当前距离丢失点的距离
- (void)updateCurrentCoordinate{
    [self whenMoveAdressAction];
    
}
//需要移动到当前位置
- (void)whenMoveAdressAction{
    if (self.isMoving&&!CGRectIsNull(self.mapView.frame)) {
        return;
    }
    //地址
    CLLocation *location = self.mapView.userLocation.location;
    CLLocationCoordinate2D coordinate = location.coordinate;
    if (location == nil) {
        return;
    }
    self.isMoving = YES;
    //悬浮中心坐标
    //设置缩放比例 3-20
    [self.mapView setZoomLevel:15 animated:YES];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    //延迟显示标记
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        self.centerAnnotation = [[MAPointAnnotation alloc] init];
        self.centerAnnotation.title = @"经纬度";
        self.centerAnnotation.subtitle = @"标记失物点";
        self.centerAnnotation.coordinate = coordinate;
        CGPoint center = CGPointMake(self.mapView.size.width/2.0f, self.mapView.size.height/2.0f);
        self.centerAnnotation.lockedScreenPoint = center;
        self.centerAnnotation.lockedToScreen = YES;
        [self.mapView addAnnotation:self.centerAnnotation];
    });
}
#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil){
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.pinColor = MAPinAnnotationColorRed;
        annotationView.canShowCallout = NO;
        return annotationView;
    }
    return nil;
}
//位置或者设备方向更新后调用此接口
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    //更新当前距离丢失点的距离
    [self updateCurrentCoordinate];
}
//停止获取地址
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
    //更新当前距离丢失点的距离
    [self updateCurrentCoordinate];
}
#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    //NSLog(@"即将移动");
}
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    //NSLog(@"正在移动");
}
@end
