//
//  YPBaseViewController.h
//  YPLaboratory
//  定义 base 基类 不建议多次嵌套继承，YPViewController 为 YPUIkit的基类，比较单一
//  Created by Hansen on 2023/5/17.
//

#import <YPUIKit/YPUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPBaseViewController : YPViewController

/// 返回点击事件
- (void)backItemClick;

/// 是否允许侧滑
- (BOOL)allowSideslip;

@end

NS_ASSUME_NONNULL_END
