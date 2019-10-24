//
//  KKOtherHeader.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#ifndef KKOtherHeader_h
#define KKOtherHeader_h


#undef    AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}


#define CMScreenW    [UIScreen mainScreen].bounds.size.width
#define CMScreenH    [UIScreen mainScreen].bounds.size.height
#define CMSizeRatio  [UIScreen mainScreen].bounds.size.width/375.0
#define WeakSelf     __weak typeof(self) weakSelf = self;

#define Weak(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define Strong(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#define IsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)//ipad
#define IsPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)//iphone

#define iPhone5 ([UIScreen mainScreen].bounds.size.width == 320)
#define iPhone4s ([UIScreen mainScreen].bounds.size.height == 480)
#define IS_IPHONE_6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define is_iPhoneX [UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define TabbarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) // 适配iPhone x 底栏

/// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}

#define SafeAreaTopHeight ((CMScreenH == 812.0||CMScreenH == 896.0) ?88:64)

#define SafeAreaBottomHeight ((CMScreenH == 812.0||CMScreenH == 896.0) ? 34 : 0)

#define Code_Success 0

//字体适配
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]
#define AdaptedBoldFontSize(R)  [UIFont boldSystemFontOfSize:AdaptedWidth(R)]


//375 * 667   414 * 736
//pad 384 * 512 这里是为了手机版跑在平板上不变形(竖屏)
#define kScreenWidthRatio  (CMScreenW / 375.0)
#define kScreenHeightRatio (CMScreenH / 667.0)

#define AdaptedWidth(x)  ceilf((x) * (IsPad?kPadScreenWidthRatio:kScreenWidthRatio))
#define AdaptedHeight(x) ceilf((x) * (IsPad?kPadScreenHeightRatio:kScreenHeightRatio))

//这是正经的平板适配(横屏)
//1000 * 750
#define kPadScreenWidthRatio  (CMScreenW / 1024.0)
#define kPadScreenHeightRatio (CMScreenH / 756)
#define AdaptedPadWidth(x) ceilf((x) * kPadScreenWidthRatio)
#define AdaptedPadHeight(x) ceilf((x) * kPadScreenHeightRatio)

// iPad导航栏尺寸
#define kPadNavSize CGSizeMake(CMScreenW-AdaptedPadWidth(90), AdaptedPadWidth(60))

#define kOnePixel (1.0f / [UIScreen mainScreen].scale)

#define UIImageWithName(imageName)  [UIImage imageNamed:imageName]

//布局适配
#define kLeft  AdaptedWidth(12.f)
#define kTop  AdaptedWidth(15.f)
#define kCellHeight  AdaptedWidth(44.f)
#define kCellMaxHeight  AdaptedWidth(999.f)
#define kToolBarHeight  AdaptedWidth(44.f)
#define kPickViewHeight  AdaptedWidth(216.f)

//config 默认游戏id
#define kQuantityMax  6 //数量输入框最大输入数量
#define kDefaultBoxMax  20 //输入框默认最大输入数量
#define kPhoneWXQQBoxMax  30 //输入框手机、微信、qq最大输入数量
#define kDefaultGoodsDetailMax  200 //商品详情默认最大输入
#define KDefaultPageSize 20//默认一页20个
#define KDefaultMargin  10//默认间隔
#define KUIProgressHUDAfterDelayTimer 2.0//提示框默认显示多少秒消失

#endif /* KKOtherHeader_h */
