//
//  CUSLinnerLayoutSampleViewController.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-16.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSLinnerLayoutSampleViewController.h"
 
@implementation CUSLinnerLayoutSampleViewController
@synthesize contentView;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSInteger controlCounter = 3;
    for (int i = 0; i < controlCounter; i++) {
        UIView *button = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",i]];
        if(i == controlCounter - 2){
            CUSLinnerData *layoutData = [[CUSLinnerData alloc]init];
            layoutData.fill = YES;
            button.layoutData = layoutData;
        }else{
            button.layoutData = CUSLAYOUT.share_linnerData;
        }
        [self.contentView addSubview:button];
        
        
    }
    CUSLinnerLayout *layout = [[CUSLinnerLayout alloc]init];
    self.contentView.layoutFrame = layout;
}

-(IBAction)toolItemClicked:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem *)sender;
    CUSLinnerLayout *layout = (CUSLinnerLayout *)self.contentView.layoutFrame;
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
        NSArray *array = self.contentView.subviews;
        if(array && [array count] > 0){
            UIView *lastView = [array lastObject];
            [lastView removeFromSuperview];
        }
        
    }else if(btn.tag == 4){
        UIView *view = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%ld",[self.contentView.subviews count]]];
        [self.contentView addSubview:view];
    }
    
    [self.contentView CUSLayout:YES];
}

@end
