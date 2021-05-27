//
//  KKTextBoxAlert.m
//  QMKKXProduct
//
//  Created by Hansen on 5/28/21.
//  Copyright © 2021 力王工作室. All rights reserved.
//

#import "KKTextBoxAlert.h"

@interface KKTextBoxAlert ()

@end

@implementation KKTextBoxAlert
- (void)setupSubViews{
    [super setupSubViews];
    //文本编辑
    self.textView = [[KKTextView alloc] init];
    self.textView.font = AdaptedFontSize(15.f);
    self.textView.backgroundColor = KKColor_F0F0F0;
    [self.contentView addSubview:self.textView];
}
- (void)displayContentWillLayoutSubviews{
    [super displayContentWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    //自动布局
    CGRect f1 = self.contentView.bounds;
    //
    CGRect f3 = bounds;
    f3.origin.y = CGRectGetMaxY(self.titleLabel.frame) + AdaptedWidth(10.f);
    f3.origin.x = AdaptedWidth(10.f);
    f3.size.width = f1.size.width - 2 * f3.origin.x;
    f3.size.height = AdaptedWidth(200.f);
    self.textView.frame = f3;
    self.displayContentView = self.textView;
}
/// 自定义提示框
/// @param headTitle 标题
/// @param textDetail  内容
/// @param leftTitle 左边标题
/// @param rightTitle 右边标题
/// @param placeholder 占位符
/// @param isOnlyOneButton 是否是有一个按钮 default NO
/// @param isShowCloseButton 是否显示关闭按钮 default YES
/// @param canTouchBeginMove 是否点击空白消失 default YES
/// @param whenCompleteBlock 成功回调
+ (KKTextBoxAlert *)showCustomWithTitle:(NSString *)headTitle
                                       textDetail:(NSString *)textDetail
                                       leftTitle:(NSString *)leftTitle
                                       rightTitle:(NSString *)rightTitle
                                   placeholder:(NSString *)placeholder
                                    isOnlyOneButton:(BOOL )isOnlyOneButton
                                    isShowCloseButton:(BOOL )isShowCloseButton
                                    canTouchBeginMove:(BOOL )canTouchBeginMove
                                      complete:(KKAlertViewControllerBlock )whenCompleteBlock{
    UIWindow *windows = [UIApplication sharedApplication].delegate.window;
    UIViewController *topVC = windows.topViewController;
    //预防重复弹框
    if ([topVC isKindOfClass:[KKUIBasePresentController class]]) {
        return nil;
    }
    KKTextBoxAlert *vc = [[KKTextBoxAlert alloc] initWithPresentType:KKUIBaseMiddlePresentType];
    vc.headTitle = headTitle;
    vc.textDetail = textDetail;
    vc.leftTitle = leftTitle;
    vc.rightTitle = rightTitle;
    vc.whenCompleteBlock = whenCompleteBlock;
    vc.isOnlyOneButton = isOnlyOneButton;
    vc.isShowCloseButton = isShowCloseButton;
    vc.canTouchBeginMove = canTouchBeginMove;
    vc.textView.placeholder = placeholder;
    [topVC presentViewController:vc animated:YES completion:nil];
    return vc;
}
@end
