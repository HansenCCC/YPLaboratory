#import "YpApiRequestDao.h"
#import <FMDB/FMDB.h>

#define DATABASE_NAME @"welldown_enc.sqlite"

@implementation YpApiRequest
- (id)copyWithZone:(NSZone *)zone {
    YpApiRequest *copy = (YpApiRequest *)[[[self class] allocWithZone:zone] init];
    copy.id = self.id;
    copy.url = self.url;
    copy.method = self.method;
    copy.headers = self.headers;
    copy.body = self.body;
    copy.isLoading = self.isLoading;
    copy.response = self.response;
    copy.success = self.success;
    copy.isEnable = self.isEnable;
    copy.extend = self.extend;
    copy.startDate = self.startDate;
    copy.endDate = self.endDate;
    copy.createdDate = self.createdDate;
    copy.updatedDate = self.updatedDate;
    copy.deletedDate = self.deletedDate;
    return copy;
}
- (NSString *)description {
    NSMutableString *result = [NSMutableString string];
    [result appendFormat:@"id %@, \r", @(self.id)];
    [result appendFormat:@"url %@, \r", self.url];
    [result appendFormat:@"method %@, \r", self.method];
    [result appendFormat:@"headers %@, \r", self.headers];
    [result appendFormat:@"body %@, \r", self.body];
    [result appendFormat:@"isLoading %@, \r", @(self.isLoading)];
    [result appendFormat:@"response %@, \r", self.response];
    [result appendFormat:@"success %@, \r", @(self.success)];
    [result appendFormat:@"isEnable %@, \r", @(self.isEnable)];
    [result appendFormat:@"extend %@, \r", self.extend];
    [result appendFormat:@"startDate %@, \r", self.startDate];
    [result appendFormat:@"endDate %@, \r", self.endDate];
    [result appendFormat:@"createdDate %@, \r", self.createdDate];
    [result appendFormat:@"updatedDate %@, \r", self.updatedDate];
    [result appendFormat:@"deletedDate %@, \r", self.deletedDate];
    return result;
}
@end

@implementation YpApiRequestDao {
    FMDatabaseQueue*   _dbQueue;
    NSString*          _path;
}

// basic
+ (instancetype)get {
    static YpApiRequestDao *sI;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sI = [[YpApiRequestDao alloc] initPrivate];
    });
    return sI;
}
- (BOOL)openWithPath:(NSString *)path {
    @synchronized(self) {
        if(_dbQueue != nil) {
            if([path isEqual:_path]) return YES;
        }
        _path = path;
        NSString *dbDirectoryPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:path];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:dbDirectoryPath]) {
            [fileManager createDirectoryAtPath:dbDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString* dbPath = [dbDirectoryPath stringByAppendingPathComponent:DATABASE_NAME];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    [self _createTables];
    return YES;
}
- (FMDatabaseQueue *)getQueue {
    return _dbQueue;
}
- (instancetype)init {
    @throw [NSException exceptionWithName:@"Can't init!" reason:@"instance class!" userInfo:nil];
    return nil;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)resetDatebaseDBQueue {
    @synchronized(self) {
        _dbQueue = nil;
        _path = nil;
    }
}
- (instancetype)initPrivate {
    self = [super init];
    if (!self) {
        return nil;
    }
    _dbQueue = nil;
    _path = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetDatebaseDBQueue) name:@"kYPDatebaseServiceResetDBQueue" object:nil];
    return self;
}
- (void)_createTables {
    __block NSString* sql = nil;
    sql = @"SELECT * FROM yp_api_request limit 1";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        if(resultSet != nil) {
            if([resultSet columnIndexForName:@"url"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN url TEXT";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"method"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN method TEXT";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"headers"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN headers TEXT";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"body"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN body TEXT";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"isLoading"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN isLoading INTEGER";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"response"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN response TEXT";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"success"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN success INTEGER";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"isEnable"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN isEnable INTEGER";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"extend"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN extend TEXT";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"startDate"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN startDate TIMESTAMP";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"endDate"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN endDate TIMESTAMP";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"createdDate"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN createdDate TIMESTAMP";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"updatedDate"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN updatedDate TIMESTAMP";
                [db executeUpdate:sql];
            }
            if([resultSet columnIndexForName:@"deletedDate"] < 0) {
                sql = @"ALTER TABLE yp_api_request ADD COLUMN deletedDate TIMESTAMP";
                [db executeUpdate:sql];
            }
            [resultSet close];
        } else {
            sql = @" CREATE TABLE IF NOT EXISTS yp_api_request(id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, method TEXT, headers TEXT, body TEXT, isLoading INTEGER, response TEXT, success INTEGER, isEnable INTEGER, extend TEXT, startDate TIMESTAMP, endDate TIMESTAMP, createdDate TIMESTAMP, updatedDate TIMESTAMP, deletedDate TIMESTAMP)";
            if ([db executeUpdate:sql]) {
                NSLog(@"create table yp_api_request success");
            } else {
                NSLog(@"create table yp_api_request failed");
                return;
           }
       }
   }];
}
- (BOOL)insertYpApiRequest:(YpApiRequest *)record aRid:(int64_t *)rid {
    if (!_dbQueue) return NO;
    NSString* sql = @"INSERT INTO yp_api_request (url, method, headers, body, isLoading, response, success, isEnable, extend, startDate, endDate, createdDate, updatedDate, deletedDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    __block BOOL errorOccurred = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollBack) {
        errorOccurred = ![db executeUpdate:sql, record.url, record.method, record.headers, record.body, @(record.isLoading), record.response, @(record.success), @(record.isEnable), record.extend, record.startDate, record.endDate, record.createdDate, record.updatedDate, record.deletedDate];
        if (errorOccurred) {
            *rollBack = YES;
        } else {
            if (rid != nil) *rid = [db lastInsertRowId];
        }
    }];
    return !errorOccurred;
}
- (BOOL)batchInsertYpApiRequest:(NSArray *)records {
    if (records.count == 0) return YES;
    if (!_dbQueue) return NO;
    NSString* sql = @"INSERT INTO yp_api_request (url, method, headers, body, isLoading, response, success, isEnable, extend, startDate, endDate, createdDate, updatedDate, deletedDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    __block BOOL errorOccurred = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollBack) {
        for (YpApiRequest* record in records) {
            errorOccurred = ![db executeUpdate:sql, record.url, record.method, record.headers, record.body, @(record.isLoading), record.response, @(record.success), @(record.isEnable), record.extend, record.startDate, record.endDate, record.createdDate, record.updatedDate, record.deletedDate];
            if (errorOccurred) {
            }
        }
    }];
    return YES;
}
- (BOOL)deleteYpApiRequestByPrimaryKey:(int64_t)key {
    if (!_dbQueue) return NO;
    NSString* sql = @"DELETE FROM yp_api_request WHERE id=?";
    __block BOOL errorOccurred = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollBack) {
        errorOccurred = ![db executeUpdate:sql, @(key)];
        if (errorOccurred) {
            *rollBack = YES;
        }
    }];
    return !errorOccurred;
}
- (BOOL)deleteYpApiRequestBySQLCondition:(NSString *)condition {
    if (!_dbQueue) return NO;
    NSString *sql = @"DELETE FROM yp_api_request";
    if(condition != nil) {
        sql = [NSString stringWithFormat:@"%@ WHERE %@", sql, condition];
    }
    __block BOOL errorOccurred = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollBack) {
        errorOccurred = ![db executeUpdate:sql];
        if (errorOccurred) {
            *rollBack = YES;
        }
    }];
    return !errorOccurred;
}
- (BOOL)batchUpdateYpApiRequest:(NSArray *)records {
    if (records.count == 0) return YES;
    if (!_dbQueue) return NO;
    NSString* sql = @"UPDATE yp_api_request SET id=?, url=?, method=?, headers=?, body=?, isLoading=?, response=?, success=?, isEnable=?, extend=?, startDate=?, endDate=?, createdDate=?, updatedDate=?, deletedDate=? WHERE id=?";
    __block BOOL errorOccurred = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollBack) {
        for (YpApiRequest *record in records) {
            errorOccurred = ![db executeUpdate:sql, @(record.id), record.url, record.method, record.headers, record.body, @(record.isLoading), record.response, @(record.success), @(record.isEnable), record.extend, record.startDate, record.endDate, record.createdDate, record.updatedDate, record.deletedDate, @(record.id)];
            if (errorOccurred) {
            }
        }
    }];
    return YES;
}
- (BOOL)updateYpApiRequestByPrimaryKey:(int64_t)key aYpApiRequest:(YpApiRequest *)aYpApiRequest {
    if (!_dbQueue) return NO;
    NSString* sql = @"UPDATE yp_api_request SET id=?, url=?, method=?, headers=?, body=?, isLoading=?, response=?, success=?, isEnable=?, extend=?, startDate=?, endDate=?, createdDate=?, updatedDate=?, deletedDate=? WHERE id=?";
    __block BOOL errorOccurred = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollBack) {
        errorOccurred = ![db executeUpdate:sql, @(aYpApiRequest.id), aYpApiRequest.url, aYpApiRequest.method, aYpApiRequest.headers, aYpApiRequest.body, @(aYpApiRequest.isLoading), aYpApiRequest.response, @(aYpApiRequest.success), @(aYpApiRequest.isEnable), aYpApiRequest.extend, aYpApiRequest.startDate, aYpApiRequest.endDate, aYpApiRequest.createdDate, aYpApiRequest.updatedDate, aYpApiRequest.deletedDate, @(key)];
        if (errorOccurred) {
            *rollBack = YES;
        }
    }];
    return !errorOccurred;
}
- (BOOL)updateYpApiRequestBySQLCondition:(NSString *)condition aYpApiRequest:(YpApiRequest *)aYpApiRequest {
    if (!_dbQueue) return NO;
    NSString* sql = @"UPDATE yp_api_request SET id=?, url=?, method=?, headers=?, body=?, isLoading=?, response=?, success=?, isEnable=?, extend=?, startDate=?, endDate=?, createdDate=?, updatedDate=?, deletedDate=?";
    if(condition != nil) {
        sql = [NSString stringWithFormat:@"%@ WHERE %@", sql, condition];
    }
    __block BOOL errorOccurred = NO;
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollBack) {
        errorOccurred = ![db executeUpdate:sql, @(aYpApiRequest.id), aYpApiRequest.url, aYpApiRequest.method, aYpApiRequest.headers, aYpApiRequest.body, @(aYpApiRequest.isLoading), aYpApiRequest.response, @(aYpApiRequest.success), @(aYpApiRequest.isEnable), aYpApiRequest.extend, aYpApiRequest.startDate, aYpApiRequest.endDate, aYpApiRequest.createdDate, aYpApiRequest.updatedDate, aYpApiRequest.deletedDate];
        if (errorOccurred) {
            *rollBack = YES;
        }
    }];
    return !errorOccurred;
}
- (YpApiRequest *)selectYpApiRequestByPrimaryKey:(int64_t)key {
    if (!_dbQueue) return nil;
    __block YpApiRequest* record = [[YpApiRequest alloc] init];
    NSString* sql = @"SELECT id, url, method, headers, body, isLoading, response, success, isEnable, extend, startDate, endDate, createdDate, updatedDate, deletedDate FROM yp_api_request WHERE id=?";
    __block BOOL found = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql, @(key)];
        while (resultSet.next) {
            record.id = [resultSet longLongIntForColumn:@"id"];
            record.url = [resultSet stringForColumn:@"url"];
            record.method = [resultSet stringForColumn:@"method"];
            record.headers = [resultSet stringForColumn:@"headers"];
            record.body = [resultSet stringForColumn:@"body"];
            record.isLoading = [resultSet boolForColumn:@"isLoading"];
            record.response = [resultSet stringForColumn:@"response"];
            record.success = [resultSet boolForColumn:@"success"];
            record.isEnable = [resultSet boolForColumn:@"isEnable"];
            record.extend = [resultSet stringForColumn:@"extend"];
            record.startDate = [resultSet dateForColumn:@"startDate"];
            record.endDate = [resultSet dateForColumn:@"endDate"];
            record.createdDate = [resultSet dateForColumn:@"createdDate"];
            record.updatedDate = [resultSet dateForColumn:@"updatedDate"];
            record.deletedDate = [resultSet dateForColumn:@"deletedDate"];
            found = YES;
            break;
        }
        [resultSet close];
    }];
    if(!found) return nil;
    return record;
}
- (NSArray *)selectYpApiRequestBySQLCondition:(NSString *)condition {
    if (!_dbQueue) return nil;
    __block NSMutableArray* records = [[NSMutableArray alloc] init];
    NSString* sql = @"SELECT id, url, method, headers, body, isLoading, response, success, isEnable, extend, startDate, endDate, createdDate, updatedDate, deletedDate FROM yp_api_request";
    if(condition != nil) {
        sql = [NSString stringWithFormat:@"%@ WHERE %@", sql, condition];
    }
    __block BOOL found = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        while (resultSet.next) {
            YpApiRequest* record = [[YpApiRequest alloc] init];
            record.id = [resultSet longLongIntForColumn:@"id"];
            record.url = [resultSet stringForColumn:@"url"];
            record.method = [resultSet stringForColumn:@"method"];
            record.headers = [resultSet stringForColumn:@"headers"];
            record.body = [resultSet stringForColumn:@"body"];
            record.isLoading = [resultSet boolForColumn:@"isLoading"];
            record.response = [resultSet stringForColumn:@"response"];
            record.success = [resultSet boolForColumn:@"success"];
            record.isEnable = [resultSet boolForColumn:@"isEnable"];
            record.extend = [resultSet stringForColumn:@"extend"];
            record.startDate = [resultSet dateForColumn:@"startDate"];
            record.endDate = [resultSet dateForColumn:@"endDate"];
            record.createdDate = [resultSet dateForColumn:@"createdDate"];
            record.updatedDate = [resultSet dateForColumn:@"updatedDate"];
            record.deletedDate = [resultSet dateForColumn:@"deletedDate"];
            found = YES;
            [records addObject:record];
        }
        [resultSet close];
    }];
    if(!found) return nil;
    return records;
}
- (int)selectYpApiRequestCount:(NSString *)condition {
    if (!_dbQueue) return -1;
    __block int count = 0;
    NSString* sql = @"SELECT COUNT(*) FROM yp_api_request";
    if(condition != nil) {
        sql = [NSString stringWithFormat:@"%@ WHERE %@", sql, condition];
    }
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        if (resultSet.next) {
            count = [resultSet intForColumnIndex:0];
        }
        [resultSet close];
    }];
    return count;
}

@end
