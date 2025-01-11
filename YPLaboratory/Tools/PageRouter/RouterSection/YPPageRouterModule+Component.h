//
//  YPPageRouterModule+Component.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/25.
//

#import "YPPageRouterModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPPageRouterModule (Component)

/// UI 组件
+ (NSArray *)ComponentRouters;

/// 丰富多彩的cell
+ (NSArray *)ComponentRouters_CollectionCells;

/// 多样的选择框
+ (NSArray *)ComponentRouters_PickerView;

/// 导航栏控制
+ (NSArray *)ComponentRouters_NavigationBar;

/// 普通提示框
+ (NSArray *)ComponentRouters_YPAlertView;

/// 普通加载框
+ (NSArray *)ComponentRouters_YPLoadingView;

/// 自定义弹框
+ (NSArray *)ComponentRouters_YPPopupController;

/// 自定义轮播图
+ (NSArray *)ComponentRouters_YPSwiperView;

/// 摄像机
+ (NSArray *)ComponentRouters_MultifunctionalCamera;

/// 系统字体
+ (NSArray *)ComponentRouters_SystemFonts;

/// 角标
+ (NSArray *)ComponentRouters_Badge;

/// 震动反馈
+ (NSArray *)ComponentRouters_ShakeFeedback;

@end

NS_ASSUME_NONNULL_END
