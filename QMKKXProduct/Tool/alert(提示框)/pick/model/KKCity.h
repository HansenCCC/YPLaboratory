//
//  KKCity.h
//  YunPOS
//
//  Created by czq on 2018/1/18.
//  Copyright © 2018年 莫艳. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KKDistrict;

@interface KKCity : NSObject
@property (nonatomic, strong) NSString *ID;//邮政编码
@property (nonatomic, strong) NSString *n;//名称
@property (nonatomic, copy) NSArray<KKDistrict *> *d;//区

@end
