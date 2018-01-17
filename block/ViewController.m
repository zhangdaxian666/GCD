//
//  ViewController.m
//  block
//
//  Created by slcf888 on 2017/9/21.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "ViewController.h"
#import "BlockViewController.h"
@interface ViewController ()
{
     NSInteger _ticketCount;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BlockViewController *vc =[[BlockViewController alloc]init];
    vc.colorBlock = ^(UIColor *color) {
        self.view.backgroundColor =color;
    };
    
    NSArray *familyName =[UIFont familyNames];
    NSLog(@"%@",familyName);
    [self label];
    [self labelT];
    
    //串
    dispatch_queue_t queue =dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
//    并
    dispatch_queue_t qneue =dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    //同步   [NSThread currentThread]获取当前线程
    dispatch_sync(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);  //这里放任务代码
    });
    //异步
    dispatch_async(queue, ^{
        NSLog(@"");        //这里放任务代码
    });
    
#pragma mark  并行队列+同步执行      不会开启新线程执行完以后再往下
    dispatch_queue_t queu =dispatch_queue_create("test.queu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queu, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"1");
        }
    });
    dispatch_sync(queu, ^{
        for (int i=0; i<2; ++i) {
            NSLog(@"2");
        }
    });
    NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxxxx");
#pragma mark  并行队列+异步执行     同时开启
    dispatch_queue_t qurur =dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(qurur, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"1");
        }
    });
    dispatch_async(qurur, ^{
        for (int i=0; i<2; i++) {
            NSLog(@"2");
        }
    });
    
    
    #pragma mark   模拟售票
    //先监听线程退出的通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(threadExitNotice) name:NSThreadWillExitNotification object:nil];
       _ticketCount =10;
    NSThread *Window =[[NSThread alloc]initWithTarget:self selector:@selector(saleTicker) object:nil];
    Window.name =@"北京售票窗口";
    [Window start];
    NSThread *windowT =[[NSThread alloc]initWithTarget:self selector:@selector(saleTicker) object:nil];
    windowT.name =@"广州售票窗口";
    [windowT start];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark 售票结束
- (void)saleTicker{
    while (1) {
        @synchronized (self) {
            if (_ticketCount>0) {
                _ticketCount --;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%ld 窗口：%@", _ticketCount, [NSThread currentThread].name]);
                [NSThread sleepForTimeInterval:0.2];
            }else{
                if ([NSThread currentThread].isCancelled) {
                    break;
                }else{
                    NSLog(@"wancheng");
                    //给当前线程标记为取消状态，停止当前的线程runLoop
                    [[NSThread currentThread] cancel];
                    CFRunLoopStop(CFRunLoopGetCurrent());
                }
            }
        }
            }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark   自动撑开
- (void)label{
    UILabel *labeltext =[[UILabel alloc]init];
    labeltext.backgroundColor =[UIColor greenColor];
    labeltext.text =@"九把刀七宗罪还有谁";
//    UIFont *fnt =[UIFont fontWithName:@"Courier New" size:15];
    UIFont *fnt =[UIFont systemFontOfSize:15];
    labeltext.font =fnt;
    CGSize size =[labeltext.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    CGFloat nameH =size.height;
    CGFloat nameW =size.width;
    labeltext.frame =CGRectMake(100, 100, nameW, nameH);
    [self.view addSubview:labeltext];
}
- (void)labelT{
    UILabel *lbl_text = [UILabel new];
    lbl_text.font = [UIFont systemFontOfSize:14];
    lbl_text.text = @"一段伤感的话，一夜疯狂的xxx，七宗罪，九把刀，福禄寿";
    lbl_text.backgroundColor = [UIColor greenColor];
    lbl_text.numberOfLines = 0;//多行显示，计算高度
    lbl_text.textColor = [UIColor lightGrayColor];
    CGSize lblSize = [lbl_text.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    lbl_text.frame = CGRectMake(10, 200, lblSize.width, lblSize.height);
    [self.view addSubview:lbl_text];
}
@end
