//
//  YPCustomHTTPRequest.h
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPHTTPRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPCustomHTTPRequest : YPHTTPRequest

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *methodString;
@property (nonatomic, strong) NSDictionary *headers;
@property (nonatomic, strong) NSDictionary *body;

+ (NSDictionary *)defaultHeaders;

@end

NS_ASSUME_NONNULL_END
