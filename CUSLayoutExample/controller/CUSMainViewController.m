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
        //
        NSMutableArray *groupArray0 = [NSMutableArray array];
         [groupArray0 addObject:[NSArray arrayWithObjects:@"FillLayout",@"Simple, easy to use, efficient",@"CUSFillLayoutSampleViewController", nil]];
        [groupArray0 addObject:[NSArray arrayWithObjects:@"StackLayout",@"Cascading Display",@"CUSStackLayoutSampleViewController", nil]];
        [groupArray0 addObject:[NSArray arrayWithObjects:@"LinnerLayout",@"Simple to HTML or LinnerLayout in Android",@"CUSLinnerLayoutSampleViewController", nil]];
        [self.dataItems addObject:groupArray0];
        
        NSMutableArray *groupArray1 = [NSMutableArray array];
        [groupArray1 addObject:[NSArray arrayWithObjects:@"RowLayout",@"Layout in a row",@"CUSRowLayoutSampleViewController", nil]];
        [groupArray1 addObject:[NSArray arrayWithObjects:@"TableLayout",@"Simple to HTML Table Tag Layout",@"CUSTableLayoutSampleViewController", nil]];
        
        [groupArray1 addObject:[NSArray arrayWithObjects:@"GridLayout",@"Flat style? So easy",@"CUSGridLayoutSampleViewController", nil]];
        
        
        [self.dataItems addObject:groupArray1];
        
        NSMutableArray *groupArray2 = [NSMutableArray array];
        [groupArray2 addObject:[NSArray arrayWithObjects:@"LayoutManager",@"Long press to drag",@"CUSLayoutManagerSampleViewController", nil]];
        [self.dataItems addObject:groupArray2];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	
    UITableView *talbeView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    talbeView.dataSource = self;
    talbeView.delegate = self;
    
    [self.view addSubview:talbeView];
    self.view.layoutFrame = CUSLAYOUT.share_fillLayout_H;
    
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc]initWithTitle:@"about" style:UIBarButtonItemStyleBordered target:self action:@selector(aboutButtonClicked)];
    self.navigationItem.rightBarButtonItem = aboutButton;
}

- (void)aboutButtonClicked{
    CUSAboutViewController *nextController = [[CUSAboutViewController alloc]initWithNibName:@"CUSAboutViewController" bundle:nil];
    [self.navigationController pushViewController:nextController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionArray = [self.dataItems objectAtIndex:section];
    return [sectionArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Base Layout";
    }else if (section == 1) {
        return @"Advance Layout";
    }else if (section == 2) {
        return @"Other";
    }else{
        return @"";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSArray *sectionArray = [self.dataItems objectAtIndex:indexPath.section];
    NSArray *array = [sectionArray objectAtIndex:indexPath.row];
    if (array && [array count] >= 1) {
        cell.textLabel.text = [array objectAtIndex:0];
        cell.detailTextLabel.text = [array objectAtIndex:1];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *sectionArray = [self.dataItems objectAtIndex:indexPath.section];
    NSArray *array = [sectionArray objectAtIndex:indexPath.row];
    if (array && [array count] >= 2) {
        BOOL flag = [self loadViewWithClassName:[array objectAtIndex:2] title:[array objectAtIndex:0]];
        if(!flag){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"notice" message:@"Not impletmented" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else{
        NSLog(@"dataItems error");
    }
}

-(BOOL)loadViewWithClassName:(NSString*)name title:(NSString*)title {
    Class controllerClass=NSClassFromString(name);
    if(controllerClass){
        UIViewController* nextController = nil;
        if ([self fileExist:name ofType:@"nib"]) {
            nextController = [[controllerClass alloc]initWithNibName:name bundle:nil];
        }else{
            nextController = [[controllerClass alloc]init];
        }
        
        nextController.title = title;
        [self.navigationController pushViewController:nextController animated:YES];
        return YES;
    }
    return NO;
}

-(BOOL)fileExist:(NSString *)fileName ofType:(NSString *)type{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:path];
}

@end
