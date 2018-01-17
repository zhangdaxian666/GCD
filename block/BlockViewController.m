//
//  BlockViewController.m
//  block
//
//  Created by slcf888 on 2017/9/22.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import "BlockViewController.h"
@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //无参无返回的block
    void(^WBBlock1)() =^(){
        NSLog(@"wbBlock");
    };
    WBBlock1();
    
    //有参有返回的block
    int(^WBBlock2)(int) =^(int num){
        return num;
    };
    WBBlock2(2);
    
    //有参无返回的block
    void(^WBBlock3)(int) =^(int num){
        NSLog(@"%d",num);
    };
    WBBlock3(3);
    
    //免循环引用
//    __block int mulitiplier =7;
//    int (^myBlock)(int) =^(int num){
//        mulitiplier ++;
//        return num *mulitiplier;
//    };
    NSMutableArray *mArray =[NSMutableArray arrayWithObjects:@"a",@"b",@"cssss",@"123a", nil];
    NSMutableArray *mArrayCount =[NSMutableArray arrayWithCapacity:1];
    [mArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mArrayCount addObject:[NSNumber numberWithInt:[obj length]]];
    }];
    NSLog(@"%@",mArrayCount);
    
    //
    int (^myBlock)(int,int) =^(int num1, int num2){
        return num1 +num2;
    };
    NSLog(@"%d",myBlock(5,4));
    
    //
    NSString *(^block3)(NSString *) =^(NSString *string){
        string =[NSString stringWithFormat:@"%@_%@",string,string];
        return string;
    };
    NSLog(@"%@",block3(@"欧皇"));
    
    //001
    int x = 5;
    int (^block4)(int) = ^(int y) {
        int z = x + y;
        return z;
    };
    NSLog(@"%d,%d",x +=5,block4(5));
    //002     ke du gai
    __block int X = 5;
    int (^block5)(int) = ^(int Y) {
        int Z = X + Y;
        return Z;
    };
    NSLog(@"%d,%d",X +=5,block5(5));
    
    //
    UIColor *color =[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    if (self.colorBlock) {
        self.colorBlock(color);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    //jiandan cubao
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
