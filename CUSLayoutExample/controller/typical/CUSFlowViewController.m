//
//  CUSFlowViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-7-30.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUSFlowViewController.h"

@interface CUSFlowViewController()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)NSInteger pageCounter;
@end

@implementation CUSFlowViewController
@synthesize scrollView;
@synthesize pageCounter;

-(void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonItemClicked)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    self.view.layoutFrame = CUSLAYOUT.share_fillLayout_V;
    scrollView = [[UIScrollView alloc]init];
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.delegate = self;
    scrollView.layoutFrame = CUSLAYOUT.share_linnerLayout_V;
    [self.view addSubview:scrollView];
    [self addMoreControls];
    
    
}

-(void)buttonItemClicked{
    [self addMoreControls];
    [scrollView CUSLayout:YES];
}

-(void)addMoreControls{
    UIView *subView = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button %i",self.pageCounter]];
    subView.frame = CGRectMake(0, -44, 320, 44);
    CUSLinnerData *topData = [[CUSLinnerData alloc]init];
    topData.height = 44;
    subView.layoutData = topData;
    [scrollView addSubview:subView];
    scrollView.contentSize = [scrollView computeSize:CGSizeMake(self.view.frame.size.width, -1)];
    self.pageCounter++;
}
@end
