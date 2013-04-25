//
//  CUSMainViewController.h
//  CUSPadFrameSample
//
//  Created by zhangyu on 13-4-3.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CUSAboutViewController.h"
#import "CUSLayout.h"

@interface CUSMainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray *dataItems;
@end
