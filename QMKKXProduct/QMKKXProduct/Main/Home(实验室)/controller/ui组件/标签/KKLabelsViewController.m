//
//  KKLabelsViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 4/29/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKLabelsViewController.h"

@interface KKLabelsViewController ()
@property (strong, nonatomic) KKLabelsView *labelsView;


@end

@implementation KKLabelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"标签";
    self.labelsView = [[KKLabelsView alloc] init];
    WeakSelf
    self.labelsView.whenAcitonClick = ^(KKLabelsView *view, NSInteger index) {
        KKOfficialLabelsModel *model = weakSelf.labelsView.datas[index];
        [weakSelf showSuccessWithMsg:model.mj_JSONString];
    };
    [self.view addSubview:self.labelsView];
    [self reloadDatas];
}
- (void)reloadDatas{
    NSArray *familyNames = [UIFont familyNames];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSString *familyName in familyNames) {
        KKOfficialLabelsModel *model = [[KKOfficialLabelsModel alloc] init];
        model.label = familyName;
        model.color = @"000000";
        [items addObject:model];
    }
    self.labelsView.datas = items;
    [self.labelsView reloadDatas];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.labelsView.frame = f1;
}
@end
