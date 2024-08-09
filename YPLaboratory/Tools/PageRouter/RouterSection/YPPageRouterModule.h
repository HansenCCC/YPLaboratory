//
//  YPPageRouterModule.h
//  YPLaboratory
//
//  Created by Hansen on 2023/5/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPPageRouterModule : NSObject

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) NSArray *routers;

- (instancetype)initWithRouters:(NSArray *)routers;

@end

NS_ASSUME_NONNULL_END
