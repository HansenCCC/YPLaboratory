#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import <CoreGraphics/CoreGraphics.h>

@interface YpApiRequest : NSObject <NSCopying>
@property (nonatomic) long id;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *headers;
@property (nonatomic, copy) NSString *body;
@property (nonatomic) BOOL isLoading;
@property (nonatomic, copy) NSString *response;
@property (nonatomic) BOOL success;
@property (nonatomic) BOOL isEnable;
@property (nonatomic, copy) NSString *extend;
@property (nonatomic, copy) NSDate *startDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, copy) NSDate *createdDate;
@property (nonatomic, copy) NSDate *updatedDate;
@property (nonatomic, copy) NSDate *deletedDate;
@end

@interface YpApiRequestDao : NSObject

// basic
+ (instancetype)get;
- (BOOL)openWithPath:(NSString *)path;
- (FMDatabaseQueue *)getQueue;
- (BOOL)insertYpApiRequest:(YpApiRequest *)record aRid:(int64_t *)rid;
- (BOOL)batchInsertYpApiRequest:(NSArray *)records;
- (BOOL)deleteYpApiRequestByPrimaryKey:(int64_t)key;
- (BOOL)deleteYpApiRequestBySQLCondition:(NSString *)condition;
- (BOOL)batchUpdateYpApiRequest:(NSArray *)records;
- (BOOL)updateYpApiRequestByPrimaryKey:(int64_t)key aYpApiRequest:(YpApiRequest *)aYpApiRequest;
- (BOOL)updateYpApiRequestBySQLCondition:(NSString *)condition aYpApiRequest:(YpApiRequest *)aYpApiRequest;
- (YpApiRequest *)selectYpApiRequestByPrimaryKey:(int64_t)key;
- (NSArray *)selectYpApiRequestBySQLCondition:(NSString *)condition;
- (int)selectYpApiRequestCount:(NSString *)condition;

@end
