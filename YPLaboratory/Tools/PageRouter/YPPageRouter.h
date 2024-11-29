//
//  YPPageRouter.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/20.
//

#import <YPUIKit/YPUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    YPPageRouterTypeNormal = 0,
    YPPageRouterTypeButton, /// 简单按钮的 cell
    YPPageRouterTypeSwitch, /// 简单开关的 cell
    YPPageRouterTypeModule, /// 是一个内置列表 table
    YPPageRouterTypeCustom, /// 展示指定 cell
} YPPageRouterType;

@interface YPPageRouter : NSObject

@property (nonatomic, assign) BOOL enable;// default YES
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, strong) id extend;
@property (nonatomic, assign) CGFloat cellHeight;// default 44.f
@property (nonatomic, assign) YPPageRouterType type;
@property (nonatomic, assign) BOOL useInsetGrouped;// 是否使用 InsetGrouped default NO

@property (nonatomic, copy) void (^didSelectedCallback)(YPPageRouter *router, UIView *cell);// 事件cell回调，设置了就有回调

@end

NS_ASSUME_NONNULL_END
