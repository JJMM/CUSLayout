//
//  CUSLayoutManagerSampleViewController.m
//  CUSLayout
//
//  Created by zhangyu on 13-5-20.
//
//

#import "CUSLayoutManagerSampleViewController.h"
 

@implementation CUSLayoutManagerSampleViewController
@synthesize designerView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.designerView = [[CUSLayoutDesignerView alloc]init];
    [self.view addSubview:self.designerView];
    self.view.layoutFrame = CUSLAYOUT.share_fillLayout_H;
    
    NSInteger controlCounter = 13;
    for (int i = 0; i < controlCounter; i++) {
        UIView *button = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",i]];
        [self.designerView addSubview:button];
    }
    
    NSMutableArray *colums = [NSMutableArray array];
    for (int i = 0 ; i < 4; i++) {
        [colums addObject:[CUSValue valueWithPercent:0.25]];
    }
    NSMutableArray *rows = [NSMutableArray array];
    for (int i = 0 ; i < 4; i++) {
        [rows addObject:[CUSValue valueWithPercent:0.25]];
    }
    
    CUSTableLayout *layout = [[CUSTableLayout alloc]initWithcolumns:colums rows:rows];

    [layout merge:1 row:1 colspan:2 rowspan:2];
    self.designerView.layoutFrame = layout;
}

@end
