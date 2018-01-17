//
//  GcdViewController.m
//  block
//
//  Created by slcf888 on 2017/9/21.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "GcdViewController.h"

@interface GcdViewController ()
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation GcdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //开启一个后台线程
//    [self performSelectorInBackground:@selector(test) withObject:nil];
    
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    _imageView.backgroundColor =[UIColor yellowColor];
    [self.view addSubview:_imageView];
    // Do any additional setup after loading the view.
}
//当手指触摸屏幕的时候，从网络下载一张图片显示
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{    //data 数据
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        //加载图片
        NSURL *urlStr =[NSURL URLWithString:@"http://h.hiphotos.baidu.com/baike/w%3D268/sign=30b3fb747b310a55c424d9f28f444387/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg"];
        NSData *data =[NSData dataWithContentsOfURL:urlStr];
        UIImage *image =[UIImage imageWithData:data];
        NSLog(@"图片加载完毕");
        //回到主线程，展现图片
        [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    });
}
- (void)test{
    NSLog(@"当前线程--%@",[NSThread currentThread]);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //异步函数                       获取当前线程
    dispatch_async(queue, ^{
        NSLog(@"任务1所在的线程--%@",[NSThread currentThread]);
    });
    //同步函数
    dispatch_sync(queue, ^{
        NSLog(@"任务2所在的线程--%@",[NSThread currentThread]);
    });
}

#pragma mark

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
