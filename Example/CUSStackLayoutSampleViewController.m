//
//  CUSStackLayoutSampleViewController.m
//  CUSLayout
//
//  Created by zhangyu on 13-5-22.
//
//

#import "CUSStackLayoutSampleViewController.h"

@implementation CUSStackLayoutSampleViewController
@synthesize contentView;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",i]];
        [self.contentView addSubview:view];
    }
    CUSStackLayout *layout = [[CUSStackLayout alloc]init];
    self.contentView.layoutFrame = layout;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)toolItemClicked:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem *)sender;
    CUSStackLayout *layout = (CUSStackLayout *)self.contentView.layoutFrame;
    if(btn.tag == 0){
        layout.showViewIndex++;
        if(layout.showViewIndex >= [self.contentView.subviews count]){
            layout.showViewIndex = 0;
        }
        [self.contentView CUSLayout:YES];
        
        //You could use the next code to design animation by you self
        /*
         [self.contentView CUSLayout];
         [UIView beginAnimations:@"animation" context:nil];
         [UIView setAnimationDuration:0.5f];
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.contentView cache:YES];
         [UIView commitAnimations];
         */
    }else if(btn.tag == 11){
        NSArray *array = self.contentView.subviews;
        if(array && [array count] > 0){
            UIView *lastView = [array lastObject];
            [lastView removeFromSuperview];
        }
        [self.contentView CUSLayout];
    }else if(btn.tag == 12){
        UIView *view = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",[self.contentView.subviews count]]];
        [self.contentView addSubview:view];
        [self.contentView CUSLayout];
    }
}
@end