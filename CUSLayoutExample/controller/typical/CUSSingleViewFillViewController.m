//
//  CUSSingleViewFillViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-6-11.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUSSingleViewFillViewController.h"

@implementation CUSSingleViewFillViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.layoutFrame = CUSLAYOUT.share_fillLayout_H;
    UIView *view = [CUSLayoutSampleFactory createControl:@"fill"];
    [self.view addSubview:view];
}
@end