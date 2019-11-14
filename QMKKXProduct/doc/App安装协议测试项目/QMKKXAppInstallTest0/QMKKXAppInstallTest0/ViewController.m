//
//  ViewController.m
//  QMKKXAppInstallTest0
//
//  Created by 程恒盛 on 2019/11/14.
//  Copyright © 2019 南京猫玩. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}
- (IBAction)whenAcitonXib:(UIButton *)sender {
    NSString *urlString = @"chsqmkkx://QMKKXAuthLogin?";
    NSURL *url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        self.titleLabel.text = @"k k";
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }else{
        self.titleLabel.text = @"未安装QMKKXPrioduct";
    }
}
@end
