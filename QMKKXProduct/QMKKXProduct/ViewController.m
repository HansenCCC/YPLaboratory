//
//  ViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/6/19.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "ViewController.h"
#import "KKIDCardScanViewController.h"
#import "KKDropdownBoxView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = KKColor_999999;
}
- (IBAction)whenClick:(UIButton *)sender {
    KKDropdownBoxView *boxView = [[KKDropdownBoxView alloc] initWithTitles:@[@"1",@"2",@"3"] withComplete:^(NSInteger index) {
        NSLog(@"%ld",index);
    }];
    [boxView showWithView:self.sendButton];
}
@end
