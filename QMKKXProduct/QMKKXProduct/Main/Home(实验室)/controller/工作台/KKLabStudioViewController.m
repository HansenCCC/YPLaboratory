//
//  KKLabStudioViewController.m
//  QMKKXProduct
//
//  Created by 程恒盛 on 2019/11/11.
//  Copyright © 2019 力王工作室. All rights reserved.
//

#import "KKLabStudioViewController.h"

@interface KKLabStudioViewController ()

@end

@implementation KKLabStudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"工作台";
    [self dispatchQueue00];
    [self dispatchQueue01];
    [self dispatchQueue10];
    [self dispatchQueue11];
    self.view.backgroundColor = KKColor_000000;
}
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
@end





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
