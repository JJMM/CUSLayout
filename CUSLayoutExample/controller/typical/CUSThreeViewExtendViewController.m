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
    
    self.view.layoutFrame = CUSLAYOUT.share_linearLayout_V;
    UIView *topView = [CUSLayoutSampleFactory createControl:@"top"];
    CUSLinearData *topData = [[CUSLinearData alloc]init];
    topData.height = 44;
    topView.layoutData = topData;
    [self.view addSubview:topView];
    
    UIView *centerView = [CUSLayoutSampleFactory createControl:@"center"];
    CUSLinearData *centerData = [[CUSLinearData alloc]init];
    centerData.fill = YES;
    centerView.layoutData = centerData;
    [self.view addSubview:centerView];
    
    UIView *bottomView = [CUSLayoutSampleFactory createControl:@"bottom"];
    CUSLinearData *bottomData = [[CUSLinearData alloc]init];
    bottomData.height = 44;
    bottomView.layoutData = bottomData;
    [self.view addSubview:bottomView];
}
@end
