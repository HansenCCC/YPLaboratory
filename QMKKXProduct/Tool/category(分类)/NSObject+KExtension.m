//
//  NSObject+KExtension.m
//  lwbasic
//
//  Created by 程恒盛 on 2018/3/20.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "NSObject+KExtension.h"
#import <objc/runtime.h>
#import "NSDictionary+KExtension.h"

@implementation NSObject (KExtension)
- (NSString *)lwDescription{
    NSDictionary *para = [self getMyAllPropertyNamesAndValuesUntilClass];
    NSString *lwDescription = [NSString stringWithFormat:@"%@\n Property:%@",self.description,para];
    return lwDescription;
}
+ (NSArray <NSString *> *)getMyAllPropertyNames{
    NSArray *names = [self getAllPropertyNamesToRoot:self];
    return names;
}
+ (NSArray <NSString *> *)getAllPropertyNames{
    NSArray *names = [self getAllPropertyNamesToRoot:nil];
    return names;
}
+ (NSArray <NSString *> *)getAllPropertyNamesToRoot:(Class) root{
    Class cls = [self class];
    unsigned int count;
    if (root) {
        root = class_getSuperclass(root);
    }
    NSMutableArray <NSString *>* propertyNames = [[NSMutableArray alloc] init];
    while (cls != root) {
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        for (int i = 0; i<count; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if (![propertyNames containsObject:propertyName]) {
                [propertyNames addObject:propertyName];
            }
        }
        if (properties){
            free(properties);
        }
        cls = class_getSuperclass(cls);
    }
    return propertyNames;
}
- (NSDictionary *)getMyAllPropertyNamesAndValuesUntilClass{
    NSDictionary *para = [self getAllPropertyNamesAndValuesUntilClass:self.class];
    return para;
}
- (NSDictionary *)getAllPropertyNamesAndValuesUntilClass:(Class) root{
    NSArray *propertyNames = [self.class getAllPropertyNamesToRoot:root];
    NSMutableDictionary *para = [[NSMutableDictionary alloc] initWithCapacity:propertyNames.count];
    for (NSString *propertyName in propertyNames) {
        id object = [self valueForKey:propertyName];
        if (object) {
            [para setObject:object forKey:propertyName];
        }
    }
    return para;
}
@end
