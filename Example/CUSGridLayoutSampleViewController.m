//
//  CUSGridLayoutSampleViewController.m
//  CUSLayout
//
//  Created by zhangyu on 13-7-19.
//
//

#import "CUSGridLayoutSampleViewController.h"
 
@implementation CUSGridLayoutSampleViewController
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
- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSInteger controlCounter = 6;
    for (int i = 0; i < controlCounter; i++) {
        UIView *button = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",i]];
        button.layoutData = [CUSGridData createGrab];
        [self.contentView addSubview:button];
    }
    
    CUSGridLayout *layout = [[CUSGridLayout alloc]initWithNumColumns:2];
    self.contentView.layoutFrame = layout;
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 44);
    CUSFillLayout *fillLayout = [[CUSFillLayout alloc]init];
    fillLayout.spacing = 0;
    self.scrollView.layoutFrame = fillLayout;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)toolItemClicked:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem *)sender;
    CUSGridLayout *layout = (CUSGridLayout *)self.contentView.layoutFrame;
    if(btn.tag == 1){
        layout.verticalSpacing -= 5;
        layout.horizontalSpacing -=5;
        if(layout.verticalSpacing < 0){
            layout.verticalSpacing = 0;
        }
        if(layout.horizontalSpacing < 0){
            layout.horizontalSpacing = 0;
        }
    }else if(btn.tag == 2){
        layout.verticalSpacing += 5;
        layout.horizontalSpacing +=5;
    }else if(btn.tag == 3){
        NSArray *array = self.contentView.subviews;
        if(array && [array count] > 0){
            UIView *lastView = [array lastObject];
            [lastView removeFromSuperview];
        }
    }else if(btn.tag == 4){
        UIView *button = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",[self.contentView.subviews count]]];
        button.layoutData = [CUSGridData createGrab];
        [self.contentView addSubview:button];
    }else if(btn.tag == 5){
        layout.numColumns -=1;
        if(layout.numColumns < 1){
            layout.numColumns = 1;
        }
    }else if(btn.tag == 6){
        layout.numColumns +=1;
        if(layout.numColumns < 1){
            layout.numColumns = 1;
        }
    }
    
    [self.contentView CUSLayout:YES];
}
@end