//
//  CUSPassViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-6-11.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUSPassViewController.h"


@interface CUSPassViewController()
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation CUSPassViewController
@synthesize topView;
@synthesize bottomView;
-(void)viewDidLoad{
    [super viewDidLoad];
    CUSLinearLayout *layout = [[CUSLinearLayout alloc]init];
    self.view.layoutFrame = layout;
    CUSLinearData *fillData = [[CUSLinearData alloc]init];
    fillData.fill = YES;
    CUSLinearData *centerData = [[CUSLinearData alloc]init];
    centerData.height = 50;
    
    topView = [[UIView alloc]init];
    topView.layoutData = fillData;
    [self.view addSubview:topView];
    
    UILabel *centerView = [[UILabel alloc]init];
    centerView.layoutData = centerData;
    centerView.textAlignment = NSTextAlignmentCenter;
    [centerView setText:@"touch the buttons"];
    [centerView setFont:[UIFont systemFontOfSize:22]];
    [self.view addSubview:centerView];
    
    bottomView = [[UIView alloc]init];
    bottomView.layoutData = fillData;
    [self.view addSubview:bottomView];
    
    [self addControlsToView:topView withTag:0 withText:@"tpView"];
    [self addControlsToView:bottomView withTag:1 withText:@"btView"];
}
-(void)addControlsToView:(UIView *)parentView withTag:(NSInteger)tag withText:(NSString *)text{
    CUSRowLayout *layout = [[CUSRowLayout alloc]init];
    parentView.layoutFrame = layout;
    for (int i = 0; i < 10; i++) {
        UIButton *view = (UIButton *)[CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"%@%i",text,i]];
        view.tag = tag;
        [view addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [parentView addSubview:view];
    }
}

-(void)buttonClicked:(UIButton *)button{
    if (button.tag == 0) {
        button.tag = 1;
        [button removeFromSuperview];
        [bottomView addSubview:button];
        
        CGRect frame = button.frame;
        frame.origin.y = frame.origin.y - bottomView.frame.origin.y;
        button.frame = frame;
    }else {
        button.tag = 0;
        [button removeFromSuperview];
        [topView addSubview:button];
        CGRect frame = button.frame;
        frame.origin.y = frame.origin.y + bottomView.frame.origin.y;
        button.frame = frame;
    }
    [topView CUSLayout:YES];
    [bottomView CUSLayout:YES];
}
@end


