//
//  KKWKURLSchemeHandler.h
//  MotoVPN3
//
//  Created by Hansen on 5/13/21.
//  Copyright © 2021 力王. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *KKWKURLSchemeHandlerJoyFishScheme;//监管ios请求
@interface KKWKURLSchemeHandler : NSObject<WKURLSchemeHandler>

/// 本地HTML已经缓存，那么就拦截HTML
/// @param url html地址
+ (NSURL *)htmlFileExistsAtPath:(NSURL *)url;

// APP启动调用，启动缓存模式，把项目html资源转移到都NSDocumentDirectory下面。（文件存在的情况下，不做拷贝）
+ (void)setupHTMLCache;

/// 下载HTML文件，实现缓存目的
/// @param items 需要下载的html文件集合
+ (void)downloadHTMLCache:(NSArray *)items;

@end

