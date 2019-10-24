//
//  KKAddressPickAlert.m
//  CHHomeDec
//
//  Created by 程恒盛 on 2019/4/4.
//  Copyright © 2019 Herson. All rights reserved.
//

#import "KKAddressPickAlert.h"
#import "KKAddressPickerModel.h"

@interface KKAddressPickAlert ()<UIPickerViewDelegate,UIPickerViewDataSource>
//数据
@property (nonatomic, strong) KKAddressPickerModel *model;//数据模型

@end

@implementation KKAddressPickAlert
- (instancetype)init{
    if(self = [super init]){
        self.contentView.backgroundColor = [UIColor redColor];
        self.canTouchBeginMove = YES;
    }
    return self;
}
- (instancetype)initWithProvinceIndex:(NSInteger)pIndex cityIndex:(NSInteger)cIndex districtIndex:(NSInteger)dIndex{
    if (self = [self initWithPresentType:KKUIBaseMiddlePresentType]) {
        [self resetProvinceIndex:pIndex cityIndex:cIndex districtIndex:dIndex];
    }
    return self;
}
//重置选中城市
- (void)resetProvinceIndex:(NSInteger)pIndex cityIndex:(NSInteger)cIndex districtIndex:(NSInteger)dIndex{
    self.model.pIndex = pIndex;
    self.model.cIndex = cIndex;
    self.model.dIndex = dIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadAddressData];//初始化数据源
//    [self addObserver];//监听数据变化
    [self setupConfirmBar];
    [self setupPickerView];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    //
    CGRect f1 = bounds;
    f1.size.height = [self.inputToolBar sizeThatFits:CGSizeZero].height;
    self.inputToolBar.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size.height = kPickViewHeight;
    f2.origin.y = CGRectGetMaxY(f1);
    self.pickerView.frame = f2;
    //
    CGRect f3 = bounds;
    f3.size.height = f1.size.height + f2.size.height;
    f3.origin.y = bounds.size.height - f3.size.height;
    self.contentView.frame = f3;
}
//设置确定栏
- (void)setupConfirmBar {
    KKInputToolBar *bar = [[KKInputToolBar alloc] init];
    self.inputToolBar = bar;
    [self.contentView addSubview:bar];
    WeakSelf
    self.inputToolBar.whenClickBlock = ^(NSInteger index) {
        if (index == 0) {
            if (weakSelf.cancelBlock) {
                weakSelf.cancelBlock();
            }
        }else if(index == 1){
            if (weakSelf.confirmBlock) {
                NSInteger selectProvince = [weakSelf.pickerView selectedRowInComponent:0];
                NSInteger selectCity     = [weakSelf.pickerView selectedRowInComponent:1];
                NSInteger selectArea     = [weakSelf.pickerView selectedRowInComponent:2];
                KKProvince * p = weakSelf.model.allProvinces[selectProvince];
                //解决省市同时滑动未结束时点击完成按钮的数组越界问题
                if (selectCity > p.c.count - 1) {
                    selectCity = p.c.count - 1;
                }
                KKCity * c = p.c[selectCity];
                //解决省市区同时滑动未结束时点击完成按钮的数组越界问题
                if (selectArea > c.d.count - 1) {
                    selectArea = c.d.count - 1;
                }
                weakSelf.confirmBlock(p.n, c.n, c.d[selectArea].n, p.ID, c.ID, c.d[selectArea].ID, selectProvince, selectCity, selectArea);
            }
        }
        [weakSelf dismissViewControllerCompletion:nil];
    };
}
//设置picker view
- (void)setupPickerView {
    UIPickerView *p = [[UIPickerView alloc] init];
    p.backgroundColor = KKColor_F0F0F0;
    self.pickerView = p;
    p.delegate = self;
    p.dataSource = self;
    [self.contentView addSubview:p];
}
#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component) {
        return self.model.allProvinces.count;
    }
    else if (1 == component){
        self.model.currentCitys = self.model.allProvinces[_model.pIndex].c;
        return self.model.currentCitys.count;
    }
    else if (2 == component){
        self.model.currentDistrict = self.model.currentCitys[_model.cIndex].d;
        return self.model.currentDistrict.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (0 == component) {
        if (row > self.model.allProvinces.count - 1) {
            return nil;
        }
        KKProvince * p = self.model.allProvinces[row];
        return p.n;
    }
    else if (1 == component) {
        if (row > self.model.currentCitys.count - 1) {
            return nil;
        }
        return self.model.currentCitys[row].n;
    }
    else if (2 == component) {
        if (row > self.model.currentDistrict.count - 1) {
            return nil;
        }
        return self.model.currentDistrict[row].n;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (0 == component) {
        _model.pIndex = row;
        _model.cIndex = 0;
        _model.dIndex = 0;
    }
    else if (1 == component){
        _model.cIndex = row;
        _model.dIndex = 0;
    } else {
        _model.dIndex = row;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = KKColor_2E3032;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:AdaptedFontSize(16)];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
#pragma mark - lazy load
- (KKAddressPickerModel *)model {
    if (!_model) {
        _model = [[KKAddressPickerModel alloc] init];
    }
    return _model;
}
#pragma mark - 加载数据
- (void)loadAddressData{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSError  * error;
    NSString * str22 = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return;
    }
    NSArray *address = [self serializationJsonString:str22];
    NSMutableArray *provinces = [NSMutableArray new];
    for (NSDictionary *dict in address) {
        KKProvince *province = [KKProvince mj_objectWithKeyValues:dict];
        [provinces addObject:province];
    }
    self.model.allProvinces = [provinces copy];
}
//解析json
- (id)serializationJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData  * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return result;
}
//#pragma mark - 监听
//- (void)addObserver {
//    [self.model addObserver:self forKeyPath:@"pIndex" options:NSKeyValueObservingOptionNew context:nil];
//    [self.model addObserver:self forKeyPath:@"cIndex" options:NSKeyValueObservingOptionNew context:nil];
//    [self.model addObserver:self forKeyPath:@"dIndex" options:NSKeyValueObservingOptionNew context:nil];
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"pIndex"]) {
//        NSInteger pIndex = [change[NSKeyValueChangeNewKey] integerValue];
//        self.model.currentCitys = self.model.allProvinces[pIndex].c;
//        [self.pickerView selectRow:pIndex inComponent:0 animated:NO];
//        [self.pickerView reloadComponent:1];
//    }
//    if ([keyPath isEqualToString:@"cIndex"]) {
//        NSInteger cIndex = [change[NSKeyValueChangeNewKey] integerValue];
//        self.model.currentDistrict = self.model.currentCitys[cIndex].d;
//        [self.pickerView selectRow:cIndex inComponent:1 animated:NO];
//        [self.pickerView reloadComponent:2];
//    }
//    if ([keyPath isEqualToString:@"dIndex"]) {
//        NSInteger dIndex = [change[NSKeyValueChangeNewKey] integerValue];
//        [self.pickerView selectRow:dIndex inComponent:2 animated:NO];
//    }
//}
//
//- (void)dealloc {
//    [self.model removeObserver:self forKeyPath:@"pIndex"];
//    [self.model removeObserver:self forKeyPath:@"cIndex"];
//    [self.model removeObserver:self forKeyPath:@"dIndex"];
//}

@end

@implementation KKAddressPickAlert (Extend)
//根据省市去获取地址信息
+ (void)getAddressWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area success:(void(^)(NSString *province,NSString *city,NSString *area,NSString *pPostalCode,NSString *cPostalCode,NSString *dPostalCode,NSInteger pIndex,NSInteger cIndex,NSInteger dIndex))success{
    NSInteger pIndex = 0;
    NSInteger cIndex = 0;
    NSInteger dIndex = 0;
    NSString *provinceStr;
    NSString *cityStr;
    NSString *areaStr;
    NSString *pPostalCode;
    NSString *cPostalCode;
    NSString *dPostalCode;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"n == %@",province];
    KKAddressPickAlert *pickAlert = [[KKAddressPickAlert alloc] init];
    NSArray <KKProvince *>*pArray = [pickAlert.model.allProvinces filteredArrayUsingPredicate:predicate];
    if (pArray.count) {
        KKProvince *p = pArray.firstObject;
        pIndex = [pickAlert.model.allProvinces indexOfObject:p];
        provinceStr = p.n;
        pPostalCode = p.ID;
        predicate = [NSPredicate predicateWithFormat:@"n == %@",city];
        NSArray <KKCity *>*cArray = [p.c filteredArrayUsingPredicate:predicate];
        if (cArray.count) {
            KKCity *c = cArray.firstObject;
            cIndex = [p.c indexOfObject:c];
            cityStr = c.n;
            cPostalCode = c.ID;
            predicate = [NSPredicate predicateWithFormat:@"n == %@",area];
            NSArray <KKDistrict *>*dArray = [c.d filteredArrayUsingPredicate:predicate];
            if (dArray.count) {
                KKDistrict *d = dArray.firstObject;
                dIndex = [c.d indexOfObject:d];
                areaStr = d.n;
                dPostalCode = d.ID;
            } else {
                KKDistrict *d = c.d.firstObject;
                areaStr = d.n;
                dPostalCode = d.ID;
            }
        } else {
            //没有匹配到市
            KKCity *c = p.c.firstObject;
            cityStr = c.n;
            cPostalCode = c.ID;
            KKDistrict *d = c.d.firstObject;
            areaStr = d.n;
            dPostalCode = d.ID;
        }
    } else {
        //没有匹配到省
        KKProvince *p = pickAlert.model.allProvinces.firstObject;
        provinceStr = p.n;
        pPostalCode = p.ID;
        KKCity *c = p.c.firstObject;
        cityStr = c.n;
        cPostalCode = c.ID;
        KKDistrict *d = c.d.firstObject;
        areaStr = d.n;
        dPostalCode = d.ID;
    }
    if (success) {
        success(provinceStr,cityStr,areaStr,pPostalCode,cPostalCode,dPostalCode,pIndex,cIndex,dIndex);
    }
}

@end
