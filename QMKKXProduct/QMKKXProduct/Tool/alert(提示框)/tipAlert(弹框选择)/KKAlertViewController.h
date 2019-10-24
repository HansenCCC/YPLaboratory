//
//  KKAlertViewController.h
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/4.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKUIBasePresentController.h"
@class KKAlertViewController;

typedef void(^KKAlertViewControllerBlock)(KKAlertViewController *controler ,NSInteger index);

@interface KKAlertViewController : KKUIBasePresentController
@property (strong, nonatomic) NSString *text;//标题
@property (strong, nonatomic) NSString *tipText;//提示文字
@property (strong, nonatomic) NSString *leftTitle;//左标题
@property (strong, nonatomic) NSString *rightTitle;//右标题
//@property (strong, nonatomic) NSString *subTipText;//二级提示文字（红色）目前暂无使用效果
@property (assign, nonatomic) BOOL isOnlyOneButton;//是否是有一个按钮 default NO
@property (assign, nonatomic) BOOL isShowCloseButton;//是否显示关闭按钮 default YES
@property (strong, nonatomic) KKAlertViewControllerBlock whenCompleteBlock;//点击回调

//ui
@property (readonly ,nonatomic) UIButton *leftBtn;//左边按钮
@property (readonly ,nonatomic) UIButton *rightBtn;//右边按钮

/**
 添加试图
 */
- (void)setupSubViews;

/**
 快速初始化一个按钮的提示框
 
 @param title TipText内容
 @param oneText 按钮内容
 @param whenCompleteBlock 点击回调
 @return self
 */
+ (instancetype)onlyOneButtonWithTipText:(NSString *)title oneText:(NSString *)oneText complete:(KKAlertViewControllerBlock )whenCompleteBlock;


/**
 快速初始化两个按钮的提示框
 
 @param title TipText内容
 @param leftTitle 左边按钮内容
 @param rightTitle 右边按钮内容
 @param whenCompleteBlock 点击回调
 @return self
 */
+ (instancetype)allocWithTipText:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle complete:(KKAlertViewControllerBlock )whenCompleteBlock;

@end



@interface KKAlertViewController (ALLALERT)


/**
 显示充值成功效果
 */
+ (KKAlertViewController *)showAlertRechargeSuccessWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;


/**
 切换猫玩游戏账号
 */
+ (KKAlertViewController *)showAlertSwitchAccountWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

/**
 是否退出商品发布
 */
+ (KKAlertViewController *)showAlertBackReleaseWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

/**
 是否要删除该商品信息
 */
+ (KKAlertViewController *)showAlertDeleteGoodsDetailWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

/**
 是否要下架该商品信息
 */
+ (KKAlertViewController *)showAlertShelvesGoodsDetailWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

@end


