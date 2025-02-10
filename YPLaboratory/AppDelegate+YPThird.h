//
//  AppDelegate+YPThird.h
//  YPChildStudy
//
//  Created by Hansen on 2023/1/1.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (YPThird)

// bugly
- (void)buglyInitConfigure;

// database
- (void)setupDatabase;

// internal purchase payment
- (void)checkInternalPurchasePayment;

// notification
- (void)addObserverNotification;

// tapdb
- (void)initTrackSDK;

@end

NS_ASSUME_NONNULL_END
