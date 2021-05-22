//
//  KKAlertViewController.h
//  FanRabbit
//
//  Created by 程恒盛 on 2019/6/4.
//  Copyright © 2019 iOS. All rights reserved.
//

#import "KKUIBasePresentController.h"
@class KKAlertViewController;

/*
 内容板块自动变化
    |￣￣￣￣￣￣￣￣￣￣￣￣￣|
    |        标题          |
    |                     |
    |       内容板块        |
    |                     |
    |                     |
    |   左边按钮   右边按钮  |
    |                     |
    ￣￣￣￣￣￣￣￣￣￣￣￣￣￣
 */

typedef void(^KKAlertViewControllerBlock)(KKAlertViewController *controler ,NSInteger index);

@interface KKAlertViewController : KKUIBasePresentController
@property (strong ,nonatomic) UIView *displayContentView;//内容板
@property (strong, nonatomic) NSString *headTitle;//标题
@property (strong, nonatomic) NSString *textDetail;//内容
@property (strong, nonatomic) NSString *leftTitle;//左标题
@property (strong, nonatomic) NSString *rightTitle;//右标题
//@property (strong, nonatomic) NSString *subTipText;//二级提示文字（红色）目前暂无使用效果
@property (assign, nonatomic) BOOL isOnlyOneButton;//是否是有一个按钮 default NO
@property (assign, nonatomic) BOOL isShowCloseButton;//是否显示关闭按钮 default YES
@property (assign, nonatomic) CGFloat contentWidth;//content宽度 default 220
@property (strong, nonatomic) KKAlertViewControllerBlock whenCompleteBlock;//点击回调

//ui
@property (readonly ,nonatomic) UIButton *leftBtn;//左边按钮
@property (readonly ,nonatomic) UIButton *rightBtn;//右边按钮
@property (readonly ,nonatomic) UILabel *titleLabel;
@property (readonly ,nonatomic) UILabel *textLabel;
@property (readonly ,nonatomic) UIView *markView;

/**
 添加试图
 */
- (void)setupSubViews;

/**
内容板块布局
*/
- (void)displayContentWillLayoutSubviews;

@end



@interface KKAlertViewController (ALLALERT)

/// 自定义提示框
/// @param headTitle 标题
/// @param textDetail  内容
/// @param leftTitle 左边标题
/// @param rightTitle 右边标题
/// @param isOnlyOneButton 是否是有一个按钮 default NO
/// @param isShowCloseButton 是否显示关闭按钮 default YES
/// @param canTouchBeginMove 是否点击空白消失 default YES
/// @param whenCompleteBlock 成功回调
+ (KKAlertViewController *)showCustomWithTitle:(NSString *)headTitle
                                       textDetail:(NSString *)textDetail
                                       leftTitle:(NSString *)leftTitle
                                       rightTitle:(NSString *)rightTitle
                                    isOnlyOneButton:(BOOL )isOnlyOneButton
                                    isShowCloseButton:(BOOL )isShowCloseButton
                                    canTouchBeginMove:(BOOL )canTouchBeginMove
                                      complete:(KKAlertViewControllerBlock )whenCompleteBlock;

/// 快速初始化一个按钮的提示框
/// @param title 标题
/// @param textDetail TipText内容
/// @param oneText 按钮内容
/// @param whenCompleteBlock 点击回调
+ (instancetype)allocWithTitle:(NSString *)title textDetail:(NSString *)textDetail oneText:(NSString *)oneText complete:(KKAlertViewControllerBlock )whenCompleteBlock;


/// 快速初始化两个按钮的提示框
/// @param title 标题
/// @param textDetail TipText内容
/// @param leftTitle 左边按钮内容
/// @param rightTitle 右边按钮内容
/// @param whenCompleteBlock 点击回调
+ (instancetype)allocWithTitle:(NSString *)title textDetail:(NSString *)textDetail leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle complete:(KKAlertViewControllerBlock )whenCompleteBlock;


#pragma mark - 应用内

/// 是否清空图片换成
/// @param whenCompleteBlock 点击回调
+ (instancetype)showAlertDeleteImagesWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

/// 是否清空图片换成
/// @param whenCompleteBlock 点击回调
+ (instancetype)showAlertDeleteSDWebImagesWithComplete:(KKAlertViewControllerBlock )whenCompleteBlock;

/// 收到应用之间传值
/// @param whenCompleteBlock 点击回调
+ (instancetype)showLabelWithContent:(NSString *)content complete:(KKAlertViewControllerBlock )whenCompleteBlock;

@end


