//
//  KKDropdownBoxView.h
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/7/10.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KKDropdownBoxViewBlock)(NSInteger index);
typedef NS_ENUM(NSInteger,KKDropdownBoxViewType){
    KKDropdownBoxViewTypeAuto = 0,//默认自动跳帧位置
    KKDropdownBoxViewTypeTop ,//强制top显示
    KKDropdownBoxViewTypeBottom ,//强制bottom显示
};


@interface KKDropdownBoxView : UIView
@property (assign, nonatomic) KKDropdownBoxViewType type;
@property (strong, nonatomic) NSArray <NSString *>*titles;

/**
 标准初始化

 @param titles 标题
 @param complete 回调
 @return objc
 */
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles withComplete:(KKDropdownBoxViewBlock) complete;


/// 展示view的下拉框
/// @param rect 展示的位置和展示大小
/// @param view 要被展示的view
- (void)showViewCenter:(CGRect)rect toView:(UIView *)view;

@end

