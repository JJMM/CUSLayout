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

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(320 * 2, 44);
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    for (int i = 0; i < 15; i++) {
        UIView *button = [CUSLayoutSampleFactory createControl];
        button.layoutData = CUS_LAYOUT.share_rowData;
        [self.contentView addSubview:button];
    }
    
    CUSRowLayout *layout = [[CUSRowLayout alloc]init];
    self.contentView.layoutFrame = layout;
    
    self.scrollView.contentSize = CGSizeMake(320 * 2, 44);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)toolItemClicked:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem *)sender;
    CUSRowLayout *layout = (CUSRowLayout *)self.contentView.layoutFrame;
    if(btn.tag == 0){
        if(layout.type == CUSLayoutTypeHorizontal){
            layout.type = CUSLayoutTypeVertical;
            [btn setTitle:@"水平"];
        }else{
            layout.type = CUSLayoutTypeHorizontal;
            [btn setTitle:@"垂直"];
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
@end
