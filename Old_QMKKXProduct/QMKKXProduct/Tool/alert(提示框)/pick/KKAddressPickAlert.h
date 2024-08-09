//
//  KKAddressPickAlert.h
//  CHHomeDec
//  地区选择器
//  Created by 程恒盛 on 2019/4/4.
//  Copyright © 2019 Herson. All rights reserved.
//

#import "KKUIBasePresentController.h"

/**
 *  确定按钮的回调
 *  province    省
 *  city        市
 *  area        区
 *  pPostalCode 省邮编
 *  cPostalCode 市邮编
 *  dPostalCode 区邮编
 *  pIndex      省index
 *  cIndex      市index
 *  dIndex      区index
 */
typedef void(^KKAddressPickAlertViewConfirmBlock)(NSString *province,NSString *city,NSString *area,NSString *pPostalCode,NSString *cPostalCode,NSString *dPostalCode,NSInteger pIndex,NSInteger cIndex,NSInteger dIndex);
typedef void(^KKAddressPickAlertViewCancelBlock)(void);

@interface KKAddressPickAlert : KKUIBasePresentController
@property (nonatomic, strong) KKInputToolBar *inputToolBar;//输入框
@property (nonatomic, strong) UIPickerView *pickerView;//地址选择器
//标准初始化
- (instancetype)init;
//选中城市初始化
- (instancetype)initWithProvinceIndex:(NSInteger)pIndex cityIndex:(NSInteger) cIndex districtIndex:(NSInteger )dindex;
//重置选中城市
- (void)resetProvinceIndex:(NSInteger)pIndex cityIndex:(NSInteger)cIndex districtIndex:(NSInteger)dIndex;
//回调
@property (nonatomic, copy) KKAddressPickAlertViewConfirmBlock confirmBlock;//确认的回调
@property (nonatomic, copy) KKAddressPickAlertViewCancelBlock cancelBlock;//取消的回调

@end

@interface KKAddressPickAlert (Extend)
//根据省市去获取地址信息
+ (void)getAddressWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area success:(void(^)(NSString *province,NSString *city,NSString *area,NSString *pPostalCode,NSString *cPostalCode,NSString *dPostalCode,NSInteger pIndex,NSInteger cIndex,NSInteger dIndex))success;
@end
