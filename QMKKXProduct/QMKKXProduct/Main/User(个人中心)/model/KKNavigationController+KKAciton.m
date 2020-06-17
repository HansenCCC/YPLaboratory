//
//  KKNavigationController+KKAciton.m
//  QMKKXProduct
//
//  Created by Hansen on 6/16/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKNavigationController+KKAciton.h"

@implementation KKNavigationController (KKAciton)
//push记录
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    //记录用户行为
    NSString *name = @"用户push操作";
    NSString *action = @"push";
    NSString *value = NSStringFromClass([viewController class]);
    NSString *date = [[NSDate date] stringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //生成字典格式
    KKPeopleAcitonModel *model = [[KKPeopleAcitonModel alloc] init];
    model.name = name;
    model.action = action;
    model.value = value;
    model.date = date;
    //记录用户行为
    [[KKUser shareInstance] savaUserActionWithJson:model.mj_JSONString];
}
@end
