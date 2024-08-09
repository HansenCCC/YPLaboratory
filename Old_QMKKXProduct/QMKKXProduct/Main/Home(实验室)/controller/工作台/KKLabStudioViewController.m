//
//  KKLabStudioViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKLabStudioViewController.h"
#import "AppDelegate.h"
#import "KKArrowContainerView.h"
#import "KKAutoContentScrollDownView.h"

@interface KKLabStudioViewController () <UIDocumentPickerDelegate>

@property (strong, nonatomic) UILabel *xlabel;
@property (strong, nonatomic) UILabel *ylabel;
@property (strong, nonatomic) KKBeeAVPlayerView *playerView;
@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) KKAutoContentScrollDownView *rollView;
@property (nonatomic, assign) NSInteger indexRow;

@end

@implementation KKLabStudioViewController{
    KKArrowContainerView *_containerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.indexRow = 0;
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = [UIColor redColor];
    self.button.layer.cornerRadius = 15.f;
    [self.button setTitle:[UIFont familyNames][self.indexRow] forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200.f);
        make.height.offset(30.f);
        make.center.equalTo(self.view);
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES handler:^(NSTimer *timer) {
        [self startAnimate];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self downLoadWithFilePath:@"http://jadinec-test.oss-accelerate.aliyuncs.com/excelFile/a5f23e130d5e4dd7adda942c45207927.pdf"];
}

- (void)startAnimate {
    [self firstStageAnimate];
}

- (void)firstStageAnimate {
    self.button.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.25 animations:^{
        self.button.transform = CGAffineTransformScale(self.button.transform, 1.0, 0.01);
    } completion:^(BOOL finished) {
        [self secondStageAnimate];
    }];
}

- (void)secondStageAnimate {
    self.indexRow ++;
    [self.button setTitle:[UIFont familyNames][self.indexRow] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.button.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - 下载文件
/// http://jadinec-test.oss-accelerate.aliyuncs.com/excelFile/a5f23e130d5e4dd7adda942c45207927.pdf
- (void)downLoadWithFilePath:(NSString *)filePath {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 11) {
        
    } else {
        [self showError:@"下载文件要求手机系统版本在11.0以上"];
        return;
    }
    /**
    /// 保存网络文件到沙盒一
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:filePath]];
    NSData *fileData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    NSString *temp = NSTemporaryDirectory();
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *fullPath = [self getNativeFilePath:[filePath componentsSeparatedByString:@"/"].lastObject];
    BOOL downResult = [fm createFileAtPath:fullPath contents:fileData attributes:nil];
    */
    /// 保存网络文件到沙盒二
    NSData *fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:filePath]];
    NSString *fullPath = [self getNativeFilePath:[filePath componentsSeparatedByString:@"/"].lastObject];
    BOOL downResult = [fileData writeToFile:fullPath atomically:YES];
    
    if (downResult) {
        UIDocumentPickerViewController *documentPickerVC = [[UIDocumentPickerViewController alloc] initWithURL:[NSURL fileURLWithPath:fullPath] inMode:UIDocumentPickerModeExportToService];
        // 设置代理
        documentPickerVC.delegate = self;
        // 设置模态弹出方式
        documentPickerVC.modalPresentationStyle = UIModalPresentationFormSheet;
        [self.navigationController presentViewController:documentPickerVC animated:YES completion:nil];
    }
}
 
// 获得文件沙盒地址
- (NSString *)getNativeFilePath:(NSString *)fileName {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *munu = [NSString stringWithFormat:@"%@/%@",@"downLoad",fileName];
    NSString *filePath = [path stringByAppendingPathComponent:munu];
    // 判断是否存在,不存在则创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL isDir = NO;
    NSMutableArray *theArr = [[filePath componentsSeparatedByString:@"/"] mutableCopy];
    [theArr removeLastObject];
    NSString *thePath = [theArr componentsJoinedByString:@"/"];
    BOOL existed = [fileManager fileExistsAtPath:thePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) { // 如果文件夹不存在
        [fileManager createDirectoryAtPath:thePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
}
 
#pragma mark - UIDocumentPickerDelegate
 
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    // 获取授权
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        // 通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            // 读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            NSLog(@"%@",fileData);
            if (error) {
                // 读取出错
            } else {
                // 上传
                NSLog(@"fileName : %@", fileName);
            }
        }];
        [urls.firstObject stopAccessingSecurityScopedResource];
    } else {
        // 授权失败
    }
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    self.title = @"工作台";
//    self.view.backgroundColor = KKColor_FFFFFF;
//    //右边导航刷新按钮
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(whenRightClickAction:)];
//    //
//    self.playerView = [[KKBeeAVPlayerView alloc] init];
//    [self.view addSubview:self.playerView];
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self presentDocumentPicker];
//}
//
//- (void)presentDocumentPicker {
//    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt",@"com.pkware.zip-archive",];
//    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes
//                                                                                                                          inMode:UIDocumentPickerModeOpen];
//    documentPickerViewController.delegate = self;
//    [self presentViewController:documentPickerViewController animated:YES completion:nil];
//}
//
//#pragma mark - UIDocumentPickerDelegate
//- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls{
//    for (NSURL *url in urls) {
//        NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
//        NSString *fileName = [array lastObject];
//        fileName = [fileName stringByRemovingPercentEncoding];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        NSLog(@"%@",data);
//    }
//}
//
//
////点击右上角操作
//- (void)whenRightClickAction:(id)sender{
////    CGFloat xProgress = 1;
////    CGFloat yProgress = 1;
////    self.qgdzlView.xProgress = xProgress;
////    self.qgdzlView.yProgress = yProgress;
////    //
////    CGPoint xpoint = [self.qgdzlView xPointForProgress:xProgress];
////    self.xlabel.center = xpoint;
////    //
////    CGPoint ypoint = [self.qgdzlView yPointForProgress:yProgress];
////    self.ylabel.center = ypoint;
////
////    [KKBadgeView showBadgeToView:self.qgdzlView badgeInteger:1];
//    NSArray <NSString *>*items = @[@"https://img.qumeng666.com/1590398734.269067",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590399408.463029",
//                                   @"https://img.qumeng666.com/1590399442.681522",
//                                   @"https://img.qumeng666.com/1590399510.690721",
//                                   @"https://img.qumeng666.com/1590398734.269067",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590399408.463029",
//                                   @"https://img.qumeng666.com/1590399442.681522",
//                                   @"https://img.qumeng666.com/1590399510.690721",
//                                   @"https://img.qumeng666.com/1590398734.269067",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590399408.463029",
//                                   @"https://img.qumeng666.com/1590399442.681522",
//                                   @"https://img.qumeng666.com/1590399510.690721",
//                                   @"https://img.qumeng666.com/1590398734.269067",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590399408.463029",
//                                   @"https://img.qumeng666.com/1590399442.681522",
//                                   @"https://img.qumeng666.com/1590399510.690721",
//                                   @"https://img.qumeng666.com/1590398734.269067",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590399408.463029",
//                                   @"https://img.qumeng666.com/1590399442.681522",
//                                   @"https://img.qumeng666.com/1590399510.690721",
//                                   @"https://img.qumeng666.com/1590398734.269067",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590399408.463029",
//                                   @"https://img.qumeng666.com/1590399442.681522",
//                                   @"https://img.qumeng666.com/1590399510.690721",
//                                   @"https://img.qumeng666.com/1590398734.269067",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590398820.492414",
//                                   @"https://img.qumeng666.com/1590399408.463029",
//                                   @"https://img.qumeng666.com/1590399442.681522",
//                                   @"https://img.qumeng666.com/1590399510.690721",
//                                  ];
//    NSInteger index = rand()%items.count;
//    self.playerView.playerItemUrl = items[index].toURL;
//}
//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    CGRect bounds = self.view.bounds;
//    CGRect f1 = bounds;
//    f1.origin.y = AdaptedWidth(100.f);
//    f1.origin.x = AdaptedWidth(50.f);
//    f1.size.width = bounds.size.width - 2 * f1.origin.x;
//    f1.size.height = AdaptedWidth(200);
//    //
//    self.playerView.frame = f1;
//}
@end

/*
//线程相关
 [self dispatchQueue00];
 [self dispatchQueue01];
 [self dispatchQueue10];
 [self dispatchQueue11];
 //同步执行 + 并发队列
 - (void)dispatchQueue00{
     dispatch_queue_t queue = dispatch_queue_create("同步执行 + 并发队列", DISPATCH_QUEUE_CONCURRENT);
     dispatch_sync(queue, ^{
         NSLog(@"同步执行 + 并发队列%@",[NSThread currentThread]);
     });
 }
 //异步执行 + 并发队列
 - (void)dispatchQueue01{
     dispatch_queue_t queue = dispatch_queue_create("异步执行 + 并发队列", DISPATCH_QUEUE_CONCURRENT);
     dispatch_async(queue, ^{
         NSLog(@"异步执行 + 并发队列%@",[NSThread currentThread]);
     });
 }
 //同步执行 + 串行队列
 - (void)dispatchQueue10{
     dispatch_queue_t queue = dispatch_queue_create("同步执行 + 串行队列", DISPATCH_QUEUE_SERIAL);
     dispatch_sync(queue, ^{
         NSLog(@"同步执行 + 串行队列%@",[NSThread currentThread]);
     });
 }
 //异步执行 + 串行队列
 - (void)dispatchQueue11{
     dispatch_queue_t queue = dispatch_queue_create("异步执行 + 串行队列", DISPATCH_QUEUE_SERIAL);
     dispatch_async(queue, ^{
         NSLog(@"异步执行 + 串行队列%@",[NSThread currentThread]);
     });
 }
 */

/*
 GCD开线程巩固 https://www.jianshu.com/p/2d57c72016c6
 同步执行（sync）：
     同步添加任务到指定的队列中，在添加的任务执行结束之前，会一直等待，直到队列里面的任务完成之后再继续执行。
     只能在当前线程中执行任务，不具备开启新线程的能力。
 异步执行（async）：
     异步添加任务到指定的队列中，它不会做任何等待，可以继续执行任务。
     可以在新的线程中执行任务，具备开启新线程的能力。
 举个简单例子：你要打电话给小明和小白。
     『同步执行』 就是：你打电话给小明的时候，不能同时打给小白。只有等到给小明打完了，才能打给小白（等待任务执行结束）。而且只能用当前的电话（不具备开启新线程的能力）。
     『异步执行』 就是：你打电话给小明的时候，不用等着和小明通话结束（不用等待任务执行结束），还能同时给小白打电话。而且除了当前电话，你还可以使用其他一个或多个电话（具备开启新线程的能力）。
 
 队列（Dispatch Queue）：这里的队列指执行任务的等待队列，即用来存放任务的队列。队列是一种特殊的线性表，采用 FIFO（先进先出）的原则，即新任务总是被插入到队列的末尾，而读取任务的时候总是从队列的头部开始读取。每读取一个任务，则从队列中释放一个任务。队列的结构可参考下图：

 队列的创建方法 / 获取方法
     可以使用 dispatch_queue_create 方法来创建队列。该方法需要传入两个参数：
     第一个参数表示队列的唯一标识符，用于 DEBUG，可为空。队列的名称推荐使用应用程序 ID 这种逆序全程域名。
     第二个参数用来识别是串行队列还是并发队列。DISPATCH_QUEUE_SERIAL 表示串行队列，DISPATCH_QUEUE_CONCURRENT 表示并发队列。
任务和队列不同组合方式的区别
     区别    并发队列    串行队列    主队列
     同步（sync）    没有开启新线程，串行执行任务    没有开启新线程，串行执行任务    死锁卡住不执行
     异步（async）    有开启新线程，并发执行任务    有开启新线程（1条），串行执行任务    没有开启新线程，串行执行任务
 */
