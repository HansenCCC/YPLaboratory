//
//  YPLaboratoryDevice.h
//  YPPrompts
//
//  Created by Hansen on 2023/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPLaboratoryDevice : NSObject

@property (nonatomic, readonly) NSString *iPhoneName;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) NSString *appName;
@property (nonatomic, readonly) NSString *build;
@property (nonatomic, readonly) NSString *bundleId;

@end

NS_ASSUME_NONNULL_END
