//
//  YPButtonViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/5.
//

#import "YPButtonViewController.h"

@interface YPButtonViewController ()

@property (nonatomic, strong) YPButton *btnA;
@property (nonatomic, strong) YPButton *btnB;
@property (nonatomic, strong) YPButton *btnC;
@property (nonatomic, strong) YPButton *btnD;

@end

@implementation YPButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnA = [self buildButton];
    [self.view addSubview:self.btnA];
    
    self.btnB = [self buildButton];
    self.btnB.reverseContent = YES;
    [self.view addSubview:self.btnB];
    
    self.btnC = [self buildButton];
    self.btnC.contentStyle = YPButtonContentStyleVertical;
    [self.view addSubview:self.btnC];
    
    self.btnD = [self buildButton];
    self.btnD.contentStyle = YPButtonContentStyleVertical;
    self.btnD.reverseContent = YES;
    [self.view addSubview:self.btnD];
}

- (YPButton *)buildButton {
    YPButton *button = [[YPButton alloc] init];
    button.backgroundColor = [UIColor yp_gray6Color];
    button.titleLabel.backgroundColor = [UIColor yp_gray5Color];
    [button setTitleColor:[UIColor yp_blackColor] forState:UIControlStateNormal];
    [button setTitle:@"实验室".yp_localizedString forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"yp-appLogo"] forState:UIControlStateNormal];
    button.imageSize = CGSizeMake(44.f, 44.f);
    button.interitemSpacing = 10.f;
    return button;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.size = [self.btnA sizeThatFits:CGSizeZero];
    f1.origin.x = (bounds.size.width - f1.size.width) / 2.f;
    f1.origin.y = 100.f;
    self.btnA.frame = f1;
    
    CGRect f2 = bounds;
    f2.size = [self.btnB sizeThatFits:CGSizeZero];
    f2.origin.x = (bounds.size.width - f2.size.width) / 2.f;
    f2.origin.y = CGRectGetMaxY(f1) + 50.f;
    self.btnB.frame = f2;
    
    CGRect f3 = bounds;
    f3.size = [self.btnC sizeThatFits:CGSizeZero];
    f3.origin.x = (bounds.size.width - f3.size.width) / 2.f;
    f3.origin.y = CGRectGetMaxY(f2) + 50.f;;
    self.btnC.frame = f3;
    
    CGRect f4 = bounds;
    f4.size = [self.btnD sizeThatFits:CGSizeZero];
    f4.origin.x = (bounds.size.width - f4.size.width) / 2.f;
    f4.origin.y = CGRectGetMaxY(f3) + 50.f;;
    self.btnD.frame = f4;
    
}

@end
