//
//  KKAddressPickerModel.h
//  YunPOS
//
//  Created by czq on 2018/1/18.
//  Copyright © 2018年 莫艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKProvince.h"
#import "KKCity.h"
#import "KKDistrict.h"

@interface KKAddressPickerModel : NSObject

@property (nonatomic, strong) NSArray<KKProvince *> *allProvinces;//所有省
@property (nonatomic, strong) NSArray <KKCity *> *currentCitys;//当前市数组
@property (nonatomic, strong) NSArray <KKDistrict *> *currentDistrict;//当前区数组
@property (nonatomic, assign) NSInteger pIndex;//省index
@property (nonatomic, assign) NSInteger cIndex;//市index
@property (nonatomic, assign) NSInteger dIndex;//区index

@end
