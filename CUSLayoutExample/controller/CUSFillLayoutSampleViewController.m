//
//  CUSFillLayoutSampleViewController.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSFillLayoutSampleViewController.h"

@implementation CUSFillLayoutSampleViewController
@synthesize contentView;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    for (int i = 0; i < 4; i++) {
        
        UIView *view = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",i]];
        [self.contentView addSubview:view];
    }
    CUSFillLayout *layout = [[CUSFillLayout alloc]init];
    self.contentView.layoutFrame = layout;
    
//    CUSLinnerLayout *viewLayout = [[CUSLinnerLayout alloc]init];
//    viewLayout.spacing = 0;
//    self.view.layoutFrame = viewLayout;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)toolItemClicked:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem *)sender;
    CUSFillLayout *layout = (CUSFillLayout *)self.contentView.layoutFrame;
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
        UIView *view = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",[self.contentView.subviews count]]];
        [self.contentView addSubview:view];
    }
    
    [self.contentView CUSLayout:YES];
}
@end
