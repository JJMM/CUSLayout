//
//  CUSAboutViewController.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-22.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUSAboutViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) IBOutlet UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataItems;
@end
