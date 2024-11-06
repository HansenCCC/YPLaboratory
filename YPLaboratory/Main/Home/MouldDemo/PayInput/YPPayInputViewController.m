//
//  YPPayInputViewController.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/6.
//

#import "YPPayInputViewController.h"
#import "YPPayInputView.h"

@interface YPPayInputViewController ()

@property (nonatomic, strong) YPPayInputView *inputView;

@end

@implementation YPPayInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightAction)];
    [self setupSubviews];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.inputView.textField becomeFirstResponder];
    });
}

- (void)setupSubviews {
    self.inputView = [[YPPayInputView alloc] init];
    [self.view addSubview:self.inputView];
}

- (void)rightAction {
    self.inputView.secureTextEntry = !self.inputView.secureTextEntry;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.size.height = 42.f;
    f1.size.width = f1.size.height * 6;
    f1.origin.x = (bounds.size.width - f1.size.width)/2.0;
    f1.origin.y = 200.f;
    self.inputView.frame = f1;
}

@end
