//
//  CUSAboutViewController.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-22.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSAboutViewController.h"

@implementation CUSAboutViewController
@synthesize table;
@synthesize dataItems;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"About";
        self.dataItems = [NSMutableArray array];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"作者：",@"张宇", nil]];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"版本：",@"1.0", nil]];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"邮箱：",@"iosdes@163.com", nil]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //    获取txt文件路径
    NSString *txtPath = [[NSBundle mainBundle] pathForResource:@"README" ofType:@"txt"];
    //    将txt到string对象中，编码类型为NSUTF8StringEncoding
    NSString *string = [[NSString  alloc] initWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    
    CGRect labelframe = CGRectMake(0, 0, 300, 500);
    UIView *labelContainer = [[UIView alloc]initWithFrame:labelframe];
    CUSFillLayout *layout = [[CUSFillLayout alloc]init];
    layout.marginHeight = 10;
    layout.marginWidth = 10;
    labelContainer.layoutFrame = layout;

    UILabel *label = [[UILabel alloc] init];
    label.text=string;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentLeft;
    label.lineBreakMode = UILineBreakModeCharacterWrap;
    label.numberOfLines = 0;
    [labelContainer addSubview:label];
    self.table.tableHeaderView = labelContainer;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"联系方式";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSArray *array = [self.dataItems objectAtIndex:indexPath.row];
    if (array && [array count] >= 1) {
        cell.textLabel.text = [array objectAtIndex:0];
        cell.detailTextLabel.text = [array objectAtIndex:1];
    }
    
    return cell;
}

@end
