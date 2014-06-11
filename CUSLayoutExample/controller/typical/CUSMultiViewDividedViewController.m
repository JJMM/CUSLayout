//
//  CUSMultiViewDividedViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-6-11.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUSMultiViewDividedViewController.h"

@implementation CUSMultiViewDividedViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.layoutFrame = CUSLAYOUT.share_linnerLayout_V;
    UIView *topView = [[UIView alloc]init];
    CUSLinnerData *topData = [[CUSLinnerData alloc]init];
    topData.height = 44;
    topView.layoutData = topData;
    [self.view addSubview:topView];
    
    UIView *centerView = [CUSLayoutSampleFactory createControl:@"center"];
    CUSLinnerData *centerData = [[CUSLinnerData alloc]init];
    centerData.fill = YES;
    centerView.layoutData = centerData;
    [self.view addSubview:centerView];
    
    topView.layoutFrame = CUSLAYOUT.share_fillLayout_H;
    for (int i = 0; i < 4; i++) {
        UIView *view = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",i]];
        [topView addSubview:view];
    }
}
@end
