//
//  KKMapAlert.h
//  KKLAFProduct
//
//  Created by Hansen on 8/25/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKAlertViewController.h"
#import "KKEventAnnotationView.h"

@interface KKMapAlert : KKAlertViewController
@property (strong, nonatomic) MAPointAnnotation *centerAnnotation;//中心点坐标

/// 展示地图
/// @param whenCompleteBlock 回调
+ (instancetype)showMapComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

@end

