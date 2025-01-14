//
//  YPNetworkRequestCell.m
//  YPLaboratory
//
//  Created by Hansen on 2025/1/12.
//

#import "YPNetworkRequestCell.h"

@interface YPNetworkRequestCell () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *keyTextField;
@property (nonatomic, strong) UITextField *valieTextField;

@end

@implementation YPNetworkRequestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self.contentView addSubview:self.keyTextField];
    [self.contentView addSubview:self.valieTextField];
}

- (void)setCellModel:(YPPageRouter *)cellModel {
    [super setCellModel:cellModel];
    self.keyTextField.text = cellModel.title;
    self.valieTextField.text = cellModel.content;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.origin.x = 15.f;
    f1.origin.y = 5.f;
    f1.size.height = bounds.size.height - f1.origin.y * 2;
    f1.size.width = (bounds.size.width - 15.f * 3) / 2.f;
    self.keyTextField.frame = f1;
    
    f1.origin.x = CGRectGetMaxX(f1) + 15.f;
    self.valieTextField.frame = f1;
}

#pragma mark - getters | setters

- (UITextField *)keyTextField {
    if (!_keyTextField) {
        _keyTextField = [[UITextField alloc] init];
        _keyTextField.placeholder = @"key";
        _keyTextField.clearButtonMode = UITextFieldViewModeAlways;
        _keyTextField.backgroundColor = [UIColor yp_gray6Color];
        _keyTextField.layer.cornerRadius = 5.f;
        _keyTextField.returnKeyType = UIReturnKeyDone;
        _keyTextField.delegate = self;
        _keyTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _keyTextField.font = [UIFont systemFontOfSize:15.f];
    }
    return _keyTextField;
}

- (UITextField *)valieTextField {
    if (!_valieTextField) {
        _valieTextField = [[UITextField alloc] init];
        _valieTextField.placeholder = @"value";
        _valieTextField.clearButtonMode = UITextFieldViewModeAlways;
        _valieTextField.backgroundColor = [UIColor yp_gray6Color];
        _valieTextField.layer.cornerRadius = 5.f;
        _valieTextField.returnKeyType = UIReturnKeyDone;
        _valieTextField.delegate = self;
        _valieTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _valieTextField.font = [UIFont systemFontOfSize:15.f];
    }
    return _valieTextField;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.cellModel.title = self.keyTextField.text;
    self.cellModel.content = self.valieTextField.text;
    if (self.cellModel.didSelectedCallback) {
        self.cellModel.didSelectedCallback(self.cellModel, self);
    }
}

@end
