//
//  YPSettingManager.h
//  YPPrompts
//
//  Created by Hansen on 2023/4/20.
//

#import <Foundation/Foundation.h>
#import "YPLaboratoryDevice.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPSettingManager : NSObject

@property (nonatomic, readonly) YPLaboratoryDevice *device;
@property (nonatomic, readonly) BOOL canPopupUpdate;// 可以弹出更新框 （满足初始化完成）

@property (nonatomic, strong) NSString *serverVersion;// 服务版本 由接口返回
@property (nonatomic, assign) BOOL forceUpdate;// 是否强更 由接口返回
@property (nonatomic, strong) NSString *advertisement;// 广告内容json 由接口返回
@property (nonatomic, strong) NSString *extend;// 版本更新扩展 由接口返回

@property (nonatomic, readonly) NSString *personalHomepage;// https://github.com/HansenCCC

+ (instancetype)sharedInstance;

- (void)showComment;

- (void)showAppstore;

@end

NS_ASSUME_NONNULL_END
