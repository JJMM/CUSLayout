//
//  CUSThreeViewExtendViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-6-11.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUSThreeViewExtendViewController.h"

@implementation CUSThreeViewExtendViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.layoutFrame = CUSLAYOUT.share_linnerLayout_V;
    UIView *topView = [CUSLayoutSampleFactory createControl:@"top"];
    CUSLinnerData *topData = [[CUSLinnerData alloc]init];
    topData.height = 44;
    topView.layoutData = topData;
    [self.view addSubview:topView];
    
    UIView *centerView = [CUSLayoutSampleFactory createControl:@"center"];
    CUSLinnerData *centerData = [[CUSLinnerData alloc]init];
    centerData.fill = YES;
    centerView.layoutData = centerData;
    [self.view addSubview:centerView];
    
    UIView *bottomView = [CUSLayoutSampleFactory createControl:@"bottom"];
    CUSLinnerData *bottomData = [[CUSLinnerData alloc]init];
    bottomData.height = 44;
    bottomView.layoutData = bottomData;
    [self.view addSubview:bottomView];
}
@end
