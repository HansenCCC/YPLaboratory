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
#import "KKWeChatCommentTableViewCell.h"

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
    element.contentValue = @"我要的东西呢？\n我要的你也未必带来了。\n什么意思？你上来晒太阳的啊？\n给我个机会。\n怎么给你机会？\n我以前没的选择，现在我想做一个好人。\n好，跟法官说，看他让不让你做好人。\n那就让我死。\n对不起，我是警察。\n谁知道？";
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

@implementation KKWeChatCommentTableViewCell (KPreviewDemo)
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KKWeChatCommentTableViewCell *kCell = (KKWeChatCommentTableViewCell *)cell;
    kCell.cellModel = [self setupWeChatMoments:indexPath];
}
+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath{
    KKWeChatMomentsCommentModel *cellModel = [self setupWeChatMoments:indexPath];
    KKWeChatCommentTableViewCell *cell = [KKWeChatCommentTableViewCell sharedInstance];
    cell.bounds = [UIScreen mainScreen].bounds;
    cell.cellModel = cellModel;
    CGSize size = [cell sizeThatFits:CGSizeMake(cell.bounds.size.width, 0)];
    CGFloat height = size.height + AdaptedWidth(6.f);
    return height;
}
+ (KKWeChatMomentsCommentModel *)setupWeChatMoments:(NSIndexPath *)indexPath{
    KKWeChatMomentsCommentModel *cellModel = [[KKWeChatMomentsCommentModel alloc] initWithId:@"1" userName:@"力王" content:@"英雄联盟憨憨;我要玩压缩-游戏-高清正版视频在线观看–爱奇艺https://www.iqiyi.com/v_19rv0pc2mg.html"];
    if (indexPath.row == 0) {
    }else if (indexPath.row == 1){
        cellModel.content = @"你发的这个我早就看过了";
        KKWeChatMomentsCommentModel *replyModel = [[KKWeChatMomentsCommentModel alloc] initWithId:@"2" userName:@"李四" content:nil];
        cellModel.replyModel = replyModel;
    }
    return cellModel;
}
@end

@implementation KKAdaptiveTableViewCell (KPreviewDemo)
+ (void)previewDemoTestCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KKAdaptiveTableViewCell *kCell = (KKAdaptiveTableViewCell *)cell;
    kCell.contentLabel.text = [self setupWeChatMoments:indexPath];
}
+ (CGFloat)heightForPreviewDemoTest:(NSIndexPath *)indexPath{
    NSString *cellModel = [self setupWeChatMoments:indexPath];
    KKAdaptiveTableViewCell *cell = [KKAdaptiveTableViewCell sharedInstance];
    cell.bounds = [UIScreen mainScreen].bounds;
    cell.contentLabel.text = cellModel;
    CGSize size = [cell sizeThatFits:CGSizeMake(cell.bounds.size.width, 0)];
    CGFloat height = size.height;
    return height;
}
+ (NSString *)setupWeChatMoments:(NSIndexPath *)indexPath{
    NSString *value = @"";
    if (indexPath.row == 0) {
        value = @"力王CH";
    }else if (indexPath.row == 1){
        value = @"英雄联盟憨憨;我要玩压缩-游戏-高清正版视频在线观看–爱奇艺https://www.iqiyi.com/v_19rv0pc2mg.html";
    }
    return value;
}
@end
