//
//  KKArrowContainerView.h
//  QMKKXProduct
//
//  Created by Hansen on 2021/11/8.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,KKArrowContainerCorner){
    KKArrowContainerCornerTop ,//箭头强制top显示
    KKArrowContainerCornerBottom ,//箭头强制bottom显示
};

@interface KKArrowContainerView : UIView

@property (nonatomic, assign) KKArrowContainerCorner arrowContainerCorner;
@property (nonatomic, assign) CGFloat arrowHeight;//箭头高度 default 10.f
@property (nonatomic, assign) CGFloat fromX; //箭头顶点位置 default 50.f

@end

NS_ASSUME_NONNULL_END
