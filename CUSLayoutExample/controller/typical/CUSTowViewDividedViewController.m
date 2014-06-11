//
//  CUSTowViewDividedViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-6-11.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUSTowViewDividedViewController.h"

@implementation CUSTowViewDividedViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.layoutFrame = CUSLAYOUT.share_fillLayout_H;
    
    [self.view addSubview:[CUSLayoutSampleFactory createControl:@"left"]];
    [self.view addSubview:[CUSLayoutSampleFactory createControl:@"right"]];
}
@end

