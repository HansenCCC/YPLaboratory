//
//  YPBarcodeAndQRCodeManager.h
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPBarcodeAndQRCodeManager : NSObject

@property (nonatomic, strong) NSString *codeText;
@property (nonatomic, strong) NSString *faultTolerant;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong, nullable) UIImage *qrImage;

@property (nonatomic, strong) NSString *brCodeText;
@property (nonatomic, strong, nullable) UIImage *brImage;

+ (instancetype)shareInstance;

- (NSArray <NSString *>*)faultTolerants;

- (NSArray<NSString *> *)sizes;

@end

NS_ASSUME_NONNULL_END
