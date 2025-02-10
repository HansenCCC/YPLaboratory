//
//  YPTrackingManager.h
//  YPPrompts
//
//  Created by Hansen on 2023/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    YPTrackingEventTypeUnknown = 0,
} YPTrackingEventType;

@interface YPTrackingManager : NSObject

@property (nonatomic, readonly) NSString *udid;// 设备唯一标识

+ (instancetype)sharedInstance;

- (void)initTrackSDK;

/// 上传事件埋点
/// - Parameters:
///   - type: 类型
///   - event: 事件
- (void)uploadEvent:(YPTrackingEventType)type event:(NSDictionary *)event;

@end

NS_ASSUME_NONNULL_END
