//
//  CUSTypicalCasesViewController.m
//  CUSLayoutExample
//
//  Created by zhangyu on 14-5-29.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "CUSTypicalCasesViewController.h"

@implementation CUSSingleViewFillViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.layoutFrame = CUSLAYOUT.share_fillLayout_H;
    UIView *view = [CUSLayoutSampleFactory createControl:@"fill"];
    [self.view addSubview:view];
}
@end

@implementation CUSTowViewDividedViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.layoutFrame = CUSLAYOUT.share_fillLayout_H;
    
    [self.view addSubview:[CUSLayoutSampleFactory createControl:@"left"]];
    [self.view addSubview:[CUSLayoutSampleFactory createControl:@"right"]];
}
@end

@implementation CUSThreeViewExtendViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.layoutFrame = CUSLAYOUT.share_linnerLayout_V;
    UIView *topView = [CUSLayoutSampleFactory createControl:@"top"];
    CUSLinnerData *topData = [[CUSLinnerData alloc]init];
    topData.height = 44;
    topView.layoutData = topData;
    [self.view addSubview:topView];
    
    UIView *centerView = [CUSLayoutSampleFactory createControl:@"center"];
    CUSLinnerData *centerData = [[CUSLinnerData alloc]init];
    centerData.fill = YES;
    centerView.layoutData = centerData;
    [self.view addSubview:centerView];
    
    UIView *bottomView = [CUSLayoutSampleFactory createControl:@"bottom"];
    CUSLinnerData *bottomData = [[CUSLinnerData alloc]init];
    bottomData.height = 44;
    bottomView.layoutData = bottomData;
    [self.view addSubview:bottomView];
}
@end

@implementation CUSMultiViewDividedViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.layoutFrame = CUSLAYOUT.share_linnerLayout_V;
    UIView *topView = [[UIView alloc]init];
    CUSLinnerData *topData = [[CUSLinnerData alloc]init];
    topData.height = 44;
    topView.layoutData = topData;
    [self.view addSubview:topView];
    
    UIView *centerView = [CUSLayoutSampleFactory createControl:@"center"];
    CUSLinnerData *centerData = [[CUSLinnerData alloc]init];
    centerData.fill = YES;
    centerView.layoutData = centerData;
    [self.view addSubview:centerView];
    
    topView.layoutFrame = CUSLAYOUT.share_fillLayout_H;
    for (int i = 0; i < 4; i++) {
        UIView *view = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button%i",i]];
        [topView addSubview:view];
    }
}
@end

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
    [self buttonItemClicked];
}

-(void)buttonItemClicked{
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
    NSInteger endIndex = [self.dataArray count];
    NSArray *subArray = [NSArray arrayWithArray:scrollView.subviews];
    for (UIView *v in scrollView.subviews) {
        [v removeFromSuperview];
    }

    for (int i = 0; i < endIndex; i++) {
        if (i < startIndex) {
            //iOS system will add tow UIImageView to ScrollView subviews when it scrolled.
            [scrollView addSubview:[subArray objectAtIndex:i]];
        }else{
            UIView *subView = [CUSLayoutSampleFactory createControl:[NSString stringWithFormat:@"button %i",i]];
            //animate start frame
            subView.frame = CGRectMake(160, 0, 0, 0);
            [scrollView addSubview:subView];
        }
    }
    
    scrollView.layoutFrame = layout;
    [scrollView CUSLayout:YES];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.pageCounter * 5 * (60 + 5));
}
@end
