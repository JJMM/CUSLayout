//
//  CUS9GridViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-6-11.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUS9GridViewController.h"

@implementation CUS9GridViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    CUSGridLayout *layout = [[CUSGridLayout alloc]initWithNumColumns:3];
    self.view.layoutFrame = layout;
    
    for (int i = 0; i < 9; i++) {
        UIView *view = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"%i",i]];
        CUSGridData *data = [[CUSGridData alloc]init];
        data.grabExcessHorizontalSpace = YES;
        data.grabExcessVerticalSpace = YES;
        view.layoutData = data;
        [self.view addSubview:view];
    }
}

@end