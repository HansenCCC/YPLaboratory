//
//  YPIconBuildManager.h
//  YPLaboratory
//
//  Created by Hansen on 2023/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPIconBuildManager : NSObject

@property (nonatomic, strong) NSString *iconPath;
@property (nonatomic, assign) BOOL isAddBeta;// 是否添加add
@property (nonatomic, strong) NSString *betaString;// default beta
@property (nonatomic, strong) UIColor *betaColor;// default white
@property (nonatomic, strong) UIColor *betaBackgroundColor;// default red

@property (nonatomic, readonly) UIImage *iconImage;// 根据 iconPath 转化成 image
@property (nonatomic, readonly) NSArray <NSDictionary *>*icons;// icon 配置

+ (instancetype)shareInstance;

- (void)resetIconBuild;

- (void)iconBuild;

@end

NS_ASSUME_NONNULL_END
