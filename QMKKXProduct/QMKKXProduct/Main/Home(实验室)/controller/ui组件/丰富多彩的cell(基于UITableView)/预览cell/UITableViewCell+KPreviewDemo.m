//
//  UITableViewCell+KPreviewDemo.m
//  QMKKXProduct
//
//  Created by Hansen on 2/1/20.
//  Copyright © 2020 力王工作室. All rights reserved.
//

#import "UITableViewCell+KPreviewDemo.h"
#import "KKLabelTableViewCell.h"
#import "KKButtonTableViewCell.h"
#import "KKSwitchTableViewCell.h"
#import "KKAppIconLabelModel.h"
#import "KKAppIconTableViewCell.h"
#import "KKWeChatMomentsTableViewCell.h"

@implementation UITableViewCell (KPreviewDemo)
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    if (![NSStringFromClass(cell.class) isEqualToString:@"UITableViewCell"]) {
        return;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath{
    return AdaptedWidth(44.f);
}
@end

@implementation KKLabelTableViewCell (KPreviewDemo)
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KKLabelTableViewCell *kCell = (KKLabelTableViewCell *)cell;
    KKLabelModel *cellModel = [[KKLabelModel alloc] initWithTitle:@"丰富多彩的cell" value:nil];
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1){
        cellModel.value = @"value";
    }else if (indexPath.row == 2){
        cellModel.title = @"丰富多彩的cell(可以编辑)";
        cellModel.isCanEdit = YES;
        cellModel.placeholder = @"丰富多彩的cell";
    }else if (indexPath.row == 3){
        cellModel.title = @"丰富多彩的cell(不可以编辑)";
        cellModel.isCanEdit = NO;
        cellModel.placeholder = @"丰富多彩的cell";
    }else if (indexPath.row == 4){
        cellModel.title = @"丰富多彩的cell(不可以编辑)";
        cellModel.isCanEdit = NO;
        cellModel.placeholder = @"丰富多彩的cell";
        cellModel.value = @"丰富多彩的cell";
    }else if (indexPath.row == 5){
        cellModel.title = @"丰富多彩的cell(图片)";
        cellModel.imageName = @"kk_icon_fileUnknow";
    }
    kCell.cellModel = cellModel;
}
@end

@implementation KKButtonTableViewCell (KPreviewDemo)
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KKButtonTableViewCell *kCell = (KKButtonTableViewCell *)cell;
    KKLabelModel *cellModel = [[KKLabelModel alloc] initWithTitle:@"丰富多彩的cell" value:nil];
    kCell.cellModel = cellModel;
}
@end

@implementation KKSwitchTableViewCell (KPreviewDemo)
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KKSwitchTableViewCell *kCell = (KKSwitchTableViewCell *)cell;
    KKLabelModel *cellModel = [[KKLabelModel alloc] initWithTitle:@"丰富多彩的cell" value:nil];
    kCell.cellModel = cellModel;
}
@end

@implementation KKAppIconTableViewCell (KPreviewDemo)
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KKAppIconTableViewCell *kCell = (KKAppIconTableViewCell *)cell;
    KKAppIconLabelModel *cellModel = [[KKAppIconLabelModel alloc] initWithTitle:@"丰富多彩的cell" value:nil];
    NSString *iconFilePath = [KKUser shareInstance].userModel.iconFilePath;
    cellModel.placeholder = @"请选择图标文件：最佳1024*1024尺寸";
    cellModel.filePath = iconFilePath;
    kCell.cellModel = cellModel;
}
+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath{
    return AdaptedWidth(88.f);
}
@end

@implementation KKWeChatMomentsTableViewCell (KPreviewDemo)
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KKWeChatMomentsTableViewCell *kCell = (KKWeChatMomentsTableViewCell *)cell;
    kCell.cellModel = [KKWeChatMomentsTableViewCell setupWeChatMoments:indexPath];
}
+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath{
    KKWeChatMomentsModel *cellModel = [KKWeChatMomentsTableViewCell setupWeChatMoments:indexPath];
    KKWeChatMomentsTableViewCell *cell = [KKWeChatMomentsTableViewCell sharedInstance];
    cell.bounds = [UIScreen mainScreen].bounds;
    cell.cellModel = cellModel;
    CGFloat height = CGRectGetMaxY(cell.tableView.frame);
    return height + AdaptedWidth(10.f);
}
+ (KKWeChatMomentsModel *)setupWeChatMoments:(NSIndexPath *)indexPath{
    KKWeChatMomentsModel *element = [[KKWeChatMomentsModel alloc] init];
    element.nickname = @"力王";
    element.iconUrl = @"https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2462146637,4274174245&fm=26&gp=0.jpg";
    element.contentValue = @"石器盒子上线以来，注册用户3w左右，日活最高达3k人次。从线上用户反馈来说，用户体验极好。自物品交易、金币交易和拍卖功能上线后，收益成果显著。目前Bee的用户较少，但是我一直都在关注Bee的用户体验和上线反馈率，非常期待Bee能够像其他游戏分发平台那样做大做强。石器盒子上线以来，注册用户3w左右，日活最高达3k人次。从线上用户反馈来说，用户体验极好。自物品交易、金币交易和拍卖功能上线后，收益成果显著。目前Bee的用户较少，但是我一直都在关注Bee的用户体验和上线反馈率，非常期待Bee能够像其他游戏分发平台那样做大做强。";
    element.timestampDate = @"两天前";
    element.likes = @[[[KKWeChatMomentsLikeModel alloc] initWithId:@"1" userName:@"张三"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"李四"],[[KKWeChatMomentsLikeModel alloc] initWithId:@"2" userName:@"王五"]];
    KKWeChatMomentsCommentModel *m1 = [[KKWeChatMomentsCommentModel alloc] initWithId:@"1" userName:@"王五" content:@"你发的这个我看过"];
    KKWeChatMomentsCommentModel *m2 = [[KKWeChatMomentsCommentModel alloc] initWithId:@"1" userName:@"力王" content:@"你发的这个我看过"];
    m1.replyModel = m2;
    element.comments = @[[[KKWeChatMomentsCommentModel alloc] initWithId:@"1" userName:@"张三" content:@"你发的这个我看过"],[[KKWeChatMomentsCommentModel alloc] initWithId:@"1" userName:@"张三" content:@"我好想记错了，不好意思我好想记错了，不好意思"],m1];
    element.images = @[@"https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2462146637,4274174245&fm=26&gp=0.jpg",@"https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2462146637,4274174245&fm=26&gp=0.jpg",@"https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2462146637,4274174245&fm=26&gp=0.jpg",];
    return element;
}
@end
