//
//  UITableViewCell+YPPreviewDemo.m
//  YPLaboratory
//
//  Created by Hansen on 2024/11/5.
//

#import "UITableViewCell+YPPreviewDemo.h"
#import "YPModuleNormalCell.h"
#import "YPModuleSwitchCell.h"
#import "YPModuleButtonCell.h"
#import "YPModuleImageCell.h"
#import "YPSwiperNormalTableViewCell.h"
#import "YPSwiperCardTableViewCell.h"

@implementation UITableViewCell (YPPreviewDemo)

+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (![NSStringFromClass(cell.class) isEqualToString:@"UITableViewCell"]) {
        return;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    NSString *detail = @"";
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        detail = @"UITableViewCellAccessoryNone";
    }else if (indexPath.row == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        detail = @"UITableViewCellAccessoryDisclosureIndicator";
    }else if (indexPath.row == 2){
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        detail = @"UITableViewCellAccessoryDetailDisclosureButton";
    }else if (indexPath.row == 3){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        detail = @"UITableViewCellAccessoryCheckmark";
    }else if (indexPath.row == 4){
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        detail = @"UITableViewCellAccessoryDetailButton";
    }
    cell.textLabel.text = detail;
}

+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath {
    return 44.f;
}

@end

@implementation YPModuleBaseCell (YPPreviewDemo)

+ (void)previewDemoTestCell:(YPModuleBaseCell *)cell indexPath:(NSIndexPath *)indexPath {
    YPPageRouter *cellModel = [[YPPageRouter alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cellModel.title = @"左边标题".yp_localizedString;
    cellModel.content = @"右边数据".yp_localizedString;
    if ([cell isKindOfClass:[YPModuleNormalCell class]]) {
        if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if ([cell isKindOfClass:[YPModuleSwitchCell class]]) {
        if (indexPath.row == 0) {
            cellModel.content = @(YES).stringValue;
        } else if (indexPath.row == 1) {
            cellModel.content = @(NO).stringValue;
        }
    } else if ([cell isKindOfClass:[YPModuleButtonCell class]]) {
        cellModel.title = @"中间按钮".yp_localizedString;
    } else if ([cell isKindOfClass:[YPModuleImageCell class]]) {
        cellModel.extend = [UIImage imageNamed:@"yp_icon_1024"];
    } else if ([cell isKindOfClass:[YPSwiperNormalTableViewCell class]]) {
        cellModel.extend = @[
            @"",
            @"",
            @"",
            @"",
        ];
    } else if ([cell isKindOfClass:[YPSwiperCardTableViewCell class]]) {
        cellModel.extend = @[
            @"",
            @"",
            @"",
            @"",
        ];
    }
    
    cell.cellModel = cellModel;
}

+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath {
    return 44.f;
}

@end

@implementation YPModuleImageCell (YPPreviewDemo)

+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44.f;
    } else if (indexPath.row == 1) {
        return 100.f;
    } else if (indexPath.row == 2) {
        return 150.f;
    } else if (indexPath.row == 3) {
        return 200.f;
    } else if (indexPath.row == 4) {
        return 250.f;
    }
    return 44.f;
}

@end

@implementation YPSwiperNormalTableViewCell (YPPreviewDemo)

+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath {
    return 200.f;
}

@end

@implementation YPSwiperCardTableViewCell (YPPreviewDemo)

+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath {
    return 200.f;
}

@end
