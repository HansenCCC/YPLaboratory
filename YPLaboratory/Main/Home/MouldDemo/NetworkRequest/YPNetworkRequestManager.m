//
//  YPNetworkRequestManager.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPNetworkRequestManager.h"
#import "YPCustomHTTPRequest.h"
#import "YpApiRequestDao.h"

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <netinet/in.h>

@implementation YPNetworkRequestManager

+ (instancetype)shareInstance {
    static YPNetworkRequestManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPNetworkRequestManager alloc] init];
        m.method = YPRequestMethodGET;
        m.body = @{}.yp_dictionaryToJsonStringNoSpace;
        m.headers = [YPCustomHTTPRequest defaultHeaders].yp_dictionaryToJsonStringNoSpace;
        m.urlString = @"https://my.chuizi.shop/api/v1/helloWorld";
        [[YpApiRequestDao get] openWithPath:@"api-request"];
    });
    return m;
}

- (NSString *)methodString {
    return self.methods[self.method];
}

- (NSArray <NSString*> *)methods {
    return @[
        @"GET",
        @"POST",
        @"PUT",
        @"DELETE",
        @"HEAD",
    ];
}

- (NSDictionary *)headersDictionary {
    return self.headers.yp_jsonStringToDictionary;
}

- (NSDictionary *)bodyDictionary {
    return self.body.yp_jsonStringToDictionary;
}

- (NSArray *)resolveDomainToIPAddresses:(NSString *)domain {
    struct addrinfo hints, *res;
    int errcode;
    NSMutableArray *ipAddresses = [NSMutableArray array];
    char ipstr[INET6_ADDRSTRLEN];
    memset(&hints, 0, sizeof(hints));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    errcode = getaddrinfo([domain UTF8String], NULL, &hints, &res);
    if (errcode != 0) {
        return nil;
    }
    for (struct addrinfo *p = res; p != NULL; p = p->ai_next) {
        void *addr;
        if (p->ai_family == AF_INET) {
            struct sockaddr_in *ipv4 = (struct sockaddr_in *)p->ai_addr;
            addr = &(ipv4->sin_addr);
        } else {
            struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)p->ai_addr;
            addr = &(ipv6->sin6_addr);
        }
        inet_ntop(p->ai_family, addr, ipstr, sizeof(ipstr));
        [ipAddresses addObject:[NSString stringWithUTF8String:ipstr]];
    }
    freeaddrinfo(res);
    return ipAddresses;
}

- (BOOL)isPortOpen:(NSString *)host port:(NSInteger)port {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, (UInt32)port, &readStream, &writeStream);
    if (readStream == NULL || writeStream == NULL) {
        return NO;
    }
    CFReadStreamOpen(readStream);
    CFWriteStreamOpen(writeStream);
    BOOL result = (CFReadStreamHasBytesAvailable(readStream) && CFWriteStreamCanAcceptBytes(writeStream));
    CFReadStreamClose(readStream);
    CFWriteStreamClose(writeStream);
    return result;
}

@end
