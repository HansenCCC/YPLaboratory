//
//  KKGreedySnakeViewController.m
//  QMKKXProduct
//
//  Created by Hansen on 6/27/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "KKGreedySnakeViewController.h"
#import "KKGreedySnakeView.h"

@interface KKGreedySnakeViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) KKGreedySnakeView *snakeView;

@end

@implementation KKGreedySnakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"贪吃蛇";
    [self setupSubvuews];
    [self updateDatas];
}
- (void)setupSubvuews{
    self.snakeView = [[KKGreedySnakeView alloc] init];
    [self.view addSubview:self.snakeView];
}
- (void)updateDatas{
    //to do
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = self.view.safeAreaInsets;
    }
    bounds = UIEdgeInsetsInsetRect(bounds,insets);
    //
    CGRect f1 = bounds;
    self.snakeView.frame = f1;
}
#pragma mark - UIScrollViewDelegate

#pragma mark - action

@end
