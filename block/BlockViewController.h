//
//  BlockViewController.h
//  block
//
//  Created by slcf888 on 2017/9/22.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockViewController : UIViewController

@property (nonatomic, copy) void(^colorBlock) (UIColor *color);

@end
