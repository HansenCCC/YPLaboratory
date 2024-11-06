//
//  YPPayInputView.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/6.
//

#import "YPPayInputView.h"

@interface _YPPayInputTextField : UITextField

@end

@implementation _YPPayInputTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end

@interface YPPayInputViewLabel : UILabel

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UIView *starView;

@end

@implementation YPPayInputViewLabel

- (instancetype)init {
    if (self = [super init]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor yp_whiteColor];
        self.textColor = [UIColor yp_blackColor];
        self.font = [UIFont boldSystemFontOfSize:20.f];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.starView = [[UIView alloc] init];
    self.starView.backgroundColor = [UIColor yp_blackColor];
    [self addSubview:self.starView];
    
    self.backgroundView = [[UIView alloc] init];
    [self addSubview:self.backgroundView];
    
    self.markView = [[UIView alloc] init];
    self.markView.backgroundColor = [UIColor yp_gray5Color];
    [self addSubview:self.markView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    f1.size = CGSizeMake(8.f, 8.f);
    f1.origin.x = (bounds.size.width - f1.size.width) / 2.0;
    f1.origin.y = (bounds.size.height - f1.size.height) / 2.0;
    self.starView.frame = f1;
    self.starView.layer.cornerRadius = f1.size.height / 2.0f;
    self.backgroundView.frame = bounds;
    
    CGRect f2 = bounds;
    f2.size.width = 1.f;
    f2.origin.x = bounds.size.width - f2.size.width;
    self.markView.frame = f2;
}

@end


@interface YPPayInputView () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSArray *labelViews;

@end

@implementation YPPayInputView

- (instancetype)init {
    if (self = [super init]) {
        self.clipsToBounds = YES;
        self.secureTextEntry = YES;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.textField = [[_YPPayInputTextField alloc] init];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.secureTextEntry = YES;
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:self.textField];
    
    NSMutableArray *labels = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i ++) {
        YPPayInputViewLabel *label = [[YPPayInputViewLabel alloc] init];
        label.tag = i;
        [self addSubview:label];
        if (i == 5) {
            label.markView.hidden = YES;
        }
        [labels addObject:label];
    }
    self.labelViews = [labels copy];
    [self updateLabels];
    
    self.backgroundColor = [UIColor colorWithRed:229/255.0 green:76/255.0 blue:66/255.0 alpha:0.02];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = 4.f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.textField.frame = f1;
    CGRect f2 = bounds;
    f2.size.width = f2.size.height;
    for (YPPayInputViewLabel *label in self.labelViews) {
        label.frame = f2;
        f2.origin.x = CGRectGetMaxX(f2);
    }
}

- (void)updateLabels {
    for (int i = 0; i < self.labelViews.count; i ++) {
        YPPayInputViewLabel *label = self.labelViews[i];
        NSString *value = self.textField.text;
        NSString *labelValue;
        if (value.length > i) {
            labelValue = [value substringWithRange:NSMakeRange(i, 1)];
        }
        if (labelValue.length > 0) {
            if (self.secureTextEntry) {
                label.text = nil;
                label.starView.hidden = NO;
            }else{
                label.text = labelValue;
                label.starView.hidden = YES;
            }
        }else{
            label.text = nil;
            label.starView.hidden = YES;
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    for (YPPayInputViewLabel *label in self.labelViews) {
        label.backgroundView.backgroundColor = backgroundColor;
    }
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    [self updateLabels];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= 6 && string.length > 0) {
        return NO;
    } else {
        return YES;
    }
}

- (void)textFieldDidEditing:(UITextField *)textField {
    [self updateLabels];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
