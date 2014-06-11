//
//  CUSWaterfallViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-6-11.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUSWaterfallViewController.h"


@interface FallEntity : NSObject
@property(nonatomic,assign)NSInteger column;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign)NSInteger columnSpan;
@property(nonatomic,assign)NSInteger rowSpan;
+ (FallEntity *)createR:(NSInteger)r C:(NSInteger)c RS:(NSInteger)rs CS:(NSInteger)cs;
@end

@implementation FallEntity
@synthesize column;
@synthesize row;
@synthesize columnSpan;
@synthesize rowSpan;

+ (FallEntity *)createR:(NSInteger)r C:(NSInteger)c RS:(NSInteger)rs CS:(NSInteger)cs{
    FallEntity *entity = [[FallEntity alloc]init];
    entity.row = r;
    entity.column = c;
    entity.rowSpan = rs;
    entity.columnSpan = cs;
    return entity;
}
@end

@interface CUSWaterfallViewController()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger pageCounter;
@end


@implementation CUSWaterfallViewController
@synthesize scrollView;
@synthesize pageCounter;
@synthesize dataArray;
-(void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStyleBordered target:self action:@selector(buttonItemClicked)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    self.view.layoutFrame = CUSLAYOUT.share_fillLayout_V;
    scrollView = [[UIScrollView alloc]init];
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.dataArray = [NSMutableArray array];
    [self addMoreControls];
}

-(void)buttonItemClicked{
    [self addMoreControls];
    [scrollView CUSLayout:YES];
}

-(void)addMoreControls{
    self.pageCounter++;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.pageCounter * 5 * (60 + 5));
    //prepare data
    NSInteger startIndex = [self.dataArray count];
    NSInteger rowIndex = (self.pageCounter - 1)*5;
    [self.dataArray addObject:[FallEntity createR:rowIndex + 0 C:0 RS:1 CS:1]];
    [self.dataArray addObject:[FallEntity createR:rowIndex + 0 C:1 RS:2 CS:1]];
    [self.dataArray addObject:[FallEntity createR:rowIndex + 0 C:2 RS:1 CS:1]];
    [self.dataArray addObject:[FallEntity createR:rowIndex + 1 C:0 RS:2 CS:1]];
    [self.dataArray addObject:[FallEntity createR:rowIndex + 1 C:2 RS:2 CS:1]];
    [self.dataArray addObject:[FallEntity createR:rowIndex + 2 C:1 RS:2 CS:1]];
    [self.dataArray addObject:[FallEntity createR:rowIndex + 3 C:0 RS:2 CS:1]];
    [self.dataArray addObject:[FallEntity createR:rowIndex + 3 C:2 RS:1 CS:1]];
    [self.dataArray addObject:[FallEntity createR:rowIndex + 4 C:1 RS:1 CS:2]];
    
    //init layou data
    NSMutableArray *colums = [NSMutableArray array];
    for (int i = 0 ; i < 3; i++) {
        [colums addObject:[CUSValue valueWithPercent:0.33]];
    }
    NSMutableArray *rows = [NSMutableArray array];
    for (int i = 0 ; i < self.pageCounter * 5; i++) {
        [rows addObject:[CUSValue valueWithFloat:60]];
    }
    //merge
    CUSTableLayout *layout = [[CUSTableLayout alloc]initWithcolumns:colums rows:rows];
    for (int i = 0; i < [self.dataArray count]; i++) {
        FallEntity *entity = [self.dataArray objectAtIndex:i];
        [layout merge:entity.column row:entity.row colspan:entity.columnSpan rowspan:entity.rowSpan];
    }
    
    //create views
    for (int i = startIndex; i < [self.dataArray count]; i++) {
        UIView *subView = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button %i",i]];
        //animate start frame
        subView.frame = CGRectMake(160, 0, 0, 0);
        [scrollView addSubview:subView];
    }
    
    scrollView.layoutFrame = layout;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.pageCounter * 5 * (60 + 5));
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView_{
    
}
@end

