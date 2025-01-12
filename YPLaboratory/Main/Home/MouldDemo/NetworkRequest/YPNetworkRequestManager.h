//
//  YPNetworkRequestManager.h
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    YPRequestMethodGET,
    YPRequestMethodPOST,
    YPRequestMethodPUT,
    YPRequestMethodDELETE,
    YPRequestMethodOPTIONS,
    YPRequestMethodHEAD,
} YPRequestMethod;

@interface YPNetworkRequestManager : NSObject

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, assign) YPRequestMethod method;
@property (nonatomic, readonly) NSString *methodString;
@property (nonatomic, strong) NSString *headers;
@property (nonatomic, readonly) NSDictionary *headersDictionary;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, readonly) NSDictionary *bodyDictionary;

+ (instancetype)shareInstance;

- (NSArray <NSString*> *)methods;

@end

NS_ASSUME_NONNULL_END
