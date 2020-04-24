//
//  KKBadgeView.h
//  QMKKXProduct
//
//  Created by Hansen on 4/8/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKBadgeView : UILabel
@property (assign, nonatomic) NSInteger badgeInteger;//用数字设置未读数，0表示不显示未读数
@property (strong, nonatomic) NSString *badgeString;//用字符串设置未读数，nil 表示不显示未读数

@end

@interface KKBadgeView (KExtension)

/// 展示未读消息在试图右上角上面
/// @param view 要展示的试图
/// @param badgeInteger 要展示的未读消息数量
+ (KKBadgeView *)showBadgeToView:(UIView *)view badgeInteger:(NSInteger )badgeInteger;

@end
