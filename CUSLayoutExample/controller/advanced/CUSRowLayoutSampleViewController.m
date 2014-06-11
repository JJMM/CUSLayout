//
//  CUSRowLayoutSampleViewController.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-10.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSRowLayoutSampleViewController.h"

@implementation CUSRowLayoutSampleViewController
@synthesize contentView;
@synthesize scrollView;

//rotation
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 44);
    [self.scrollView CUSLayout];
}

//for ipad of ios4
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 44);
    [self.scrollView CUSLayout];
}

-(void)buttonClicked:(id)sender{
    NSLog(@"buttonClicked:%@",sender);
}
- (void)viewDidLoad{
    [super viewDidLoad];
    for (int i = 0; i < 15; i++) {
        UIButton *button = (UIButton *)[CUSLayoutSampleFactory createControl];
        button.layoutData = CUSLAYOUT.share_rowData;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
    
    CUSRowLayout *layout = [[CUSRowLayout alloc]init];
    self.contentView.layoutFrame = layout;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 44);
    
    CUSFillLayout *fillLayout = [[CUSFillLayout alloc]init];
    fillLayout.spacing = 0;
    self.scrollView.layoutFrame = fillLayout;
    
    UIBarButtonItem *toolButton = [[UIBarButtonItem alloc]initWithTitle:@"tool" style:UIBarButtonItemStyleBordered target:self action:@selector(toolButtonClicked)];
    self.navigationItem.rightBarButtonItem = toolButton;
}

-(IBAction)toolItemClicked:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem *)sender;
    CUSRowLayout *layout = (CUSRowLayout *)self.contentView.layoutFrame;
    if(btn.tag == 0){
        if(layout.type == CUSLayoutTypeHorizontal){
            layout.type = CUSLayoutTypeVertical;
            [btn setTitle:@"HOR"];
        }else{
            layout.type = CUSLayoutTypeHorizontal;
            [btn setTitle:@"VER"];
        }
    }else if(btn.tag == 1){
        layout.spacing -= 5;
        if(layout.spacing < 0){
            layout.spacing = 0;
        }
    }else if(btn.tag == 2){
        layout.spacing += 5;
    }else if(btn.tag == 3){
        if(layout.pack){
            layout.pack = NO;
            [btn setTitle:@" pack "];
        }else{
            layout.pack = YES;
            [btn setTitle:@"unpack"];
        }
    }else if(btn.tag == 4){
        if(layout.justify){
            layout.justify = NO;
            [btn setTitle:@" just "];
        }else{
            layout.justify = YES;
            [btn setTitle:@"unjust"];
        }
    }else if(btn.tag == 10){
        NSArray *array = self.contentView.subviews;
        if(array && [array count] > 0){
            UIView *lastView = [array lastObject];
            [lastView removeFromSuperview];
        }
        
    }else if(btn.tag == 11){
        UIView *view = [CUSLayoutSampleFactory createControl];
        [self.contentView addSubview:view];
    }
    
    [self.contentView CUSLayout:YES];
}

-(void)toolButtonClicked{
    if (self.scrollView.contentOffset.x == 0) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
    }else{
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
@end
