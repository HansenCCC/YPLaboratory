//
//  TDSHttpDownloadFile.h
//  TapCommonSDK
//
//  Created by SeraphLi on 2022/12/13.
//

#import <TapCommonSDK/TDSHttpDownloadBase.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TDSHttpDownloadFile : TDSHttpDownloadBase

+ (void)downloadFile:(NSString *)url callback:(downloadCallback)callback;

+ (void)getFileFromCacheOrNet:(NSString *)url callback:(downloadCallback)callback;

+ (NSString *) getFullCachePath:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
