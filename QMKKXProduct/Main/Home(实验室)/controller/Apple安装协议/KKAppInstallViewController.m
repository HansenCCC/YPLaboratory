//
//  KKAppInstallViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/14.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKAppInstallViewController.h"

/*
 App安装协议测试项目
 https://fir.im/7c6f
 测试项目文件路径
 /当前项目路径/doc/App安装协议测试项目/QMKKXAppInstallTest0
 
 App安装协议地址：itms-services://?action=download-manifest&url=https%3A%2F%2Fdownload.fir.im%2Fapps%2F5c088a47548b7a5556cc82d7%2Finstall%3Fdownload_token%3D469edbf39a112de58a445cf07f1ac350%26authentication_token%3Dw_oGB0Cjxk_ZpW7HTDJmczZp0VKDLk%240084d%26release_id%3D5dcd1426f9454819da994ab3
 
 */
//#define QMKKXAppInstallTest0installURL @"itms-services://?action=download-manifest&url=https%3A%2F%2Fdownload.fir.im%2Fapps%2F5c088a47548b7a5556cc82d7%2Finstall%3Fdownload_token%3D469edbf39a112de58a445cf07f1ac350%26authentication_token%3Dw_oGB0Cjxk_ZpW7HTDJmczZp0VKDLk%240084d%26release_id%3D5dcd1426f9454819da994ab3"
//
//@interface KKAppInstallViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//
//@end
//
//@implementation KKAppInstallViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    self.title = @"Apple安装协议";
//    BOOL flag = [[KKUser shareInstance] canOpenGameByGameid:@"0"];
//    NSString *rightString = flag?@"打开":@"安装";
//    UIBarButtonItem *installItem = [[UIBarButtonItem alloc] initWithTitle:rightString style:UIBarButtonItemStylePlain target:self action:@selector(__onInstallButtonDidTap:)];
//    self.navigationItem.rightBarButtonItem = installItem;
//    //
//    NSString *urlString = QMKKXAppInstallTest0installURL;
//#if TARGET_IPHONE_SIMULATOR //模拟器
//    NSString *device = [NSString stringWithFormat:@"模拟器：%@",[NSString getCurrentDeviceModel]];
//#elif TARGET_OS_IPHONE //真机
//    NSString *device = [NSString stringWithFormat:@"真机：%@",[NSString getCurrentDeviceModel]];
//#endif
//    NSString *version = [KKUser shareInstance].version;
//    NSDate *time = [NSDate date];
//    NSString *installString = flag?@"检测已经安装QMKKXAppInstallTest0\n点击右上角，即打开":@"检测未安装QMKKXAppInstallTest0\n点击右上角，即安装";
//    self.titleLabel.text = [NSString stringWithFormat:@"检测当前设备为%@\n\n\n当前App版本：%@\n\n\n当前时间：%@\n\n\n安装协议：%@\n\n\n%@",device,version,time,urlString,installString];
//}
//- (void)__onInstallButtonDidTap:(id)sender{
//    if ([[KKUser shareInstance] canOpenGameByGameid:@"0"]) {
//        [[KKUser shareInstance] openGameByGameId:@"0"];
//    }else{
//#if TARGET_IPHONE_SIMULATOR
//        //模拟器
//        [self showError:@"请使用真机安装!"];
//#elif TARGET_OS_IPHONE
//        //真机
//        NSString *urlString = QMKKXAppInstallTest0installURL;
//        [[KKUser shareInstance] openURL:urlString.toURL];
//#endif
//    }
//}
//@end
