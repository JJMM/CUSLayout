//
//  CUSMainViewController.m
//  CUSPadFrameSample
//
//  Created by zhangyu on 13-4-3.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSMainViewController.h"

@implementation CUSMainViewController
@synthesize dataItems;
- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"CUSLayout";
        self.dataItems = [NSMutableArray array];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"FillLayout",@"Simple, easy to use, efficient",@"CUSFillLayoutSampleViewController", nil]];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"LinnerLayout",@"Simple to HTML or LinnerLayout in Android",@"CUSLinnerLayoutSampleViewController", nil]];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"RowLayout",@"Layout in a row",@"CUSRowLayoutSampleViewController", nil]];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"TableLayout",@"Simple to HTML Table Tag Layout",@"CUSTableLayoutSampleViewController", nil]];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"StackLayout",@"Cascading Display",@"CUSStackLayoutSampleViewController", nil]];
        [self.dataItems addObject:[NSArray arrayWithObjects:@"GridLayout",@"Flat style? So easy",@"CUSGridLayoutSampleViewController", nil]];
        
        
        [self.dataItems addObject:[NSArray arrayWithObjects:@"LayoutManager",@"Long press to drag",@"CUSLayoutManagerSampleViewController", nil]];
        
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	
    UITableView *talbeView = [[UITableView alloc]init];
    talbeView.dataSource = self;
    talbeView.delegate = self;
    
    [self.view addSubview:talbeView];
    self.view.layoutFrame = CUS_LAYOUT.share_fillLayout_H;
    
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc]initWithTitle:@"about" style:UIBarButtonItemStyleBordered target:self action:@selector(aboutButtonClicked)];
    self.navigationItem.rightBarButtonItem = aboutButton;
}

- (void)aboutButtonClicked{
    CUSAboutViewController *nextController = [[CUSAboutViewController alloc]initWithNibName:@"CUSAboutViewController" bundle:nil];
    [self.navigationController pushViewController:nextController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSArray *array = [self.dataItems objectAtIndex:indexPath.row];
    if (array && [array count] >= 1) {
        cell.textLabel.text = [array objectAtIndex:0];
        cell.detailTextLabel.text = [array objectAtIndex:1];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [self.dataItems objectAtIndex:indexPath.row];
    if (array && [array count] >= 2) {
        BOOL flag = [self loadViewWithClassName:[array objectAtIndex:2] title:[array objectAtIndex:0]];
        if(!flag){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该布局算法没有实现，将在后续版本中提供" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else{
        NSLog(@"dataItems 数据格式错误");
    }
}

-(BOOL)loadViewWithClassName:(NSString*)name title:(NSString*)title {
    Class controllerClass=NSClassFromString(name);
    if(controllerClass){
        UIViewController* backController=[[controllerClass alloc]initWithNibName:name bundle:nil];
        backController.title = title;
        [self.navigationController pushViewController:backController animated:YES];
        return YES;
    }
    return NO;
}


@end
