//
//  YPBarcodeAndQRCodeManager.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPBarcodeAndQRCodeManager.h"

@implementation YPBarcodeAndQRCodeManager

+ (instancetype)shareInstance {
    static YPBarcodeAndQRCodeManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[YPBarcodeAndQRCodeManager alloc] init];
        m.codeText = @"开发者实验室".yp_localizedString;
        m.faultTolerant = @"M";
        m.size = @"1000";
        m.brCodeText = @"1568656582";
    });
    return m;
}

- (NSArray<NSString *> *)faultTolerants {
    return @[
        @"L",
        @"M",
        @"Q",
        @"H",
    ];
}

- (NSArray<NSString *> *)sizes {
    return @[
        @"50",   // 超小尺寸（适合微型二维码）
        @"100",  // 小尺寸
        @"150",  // 小-中过渡
        @"200",  // 中等尺寸（常用推荐尺寸）
        @"250",  // 中-高清过渡
        @"300",  // 高清尺寸（推荐）
        @"350",  // 高清-大尺寸过渡
        @"400",  // 大尺寸（适合打印）
        @"450",  // 超大尺寸过渡
        @"500",  // 超大尺寸（高清打印）
        @"600",  // 极大尺寸（需要更高精度时）
        @"800",  // 超高精度
        @"1000",  // 特殊场景下的超大尺寸
        @"1500",
        @"2000",
        @"2500",
        @"3000",
        @"5000",
    ];
}

@end
