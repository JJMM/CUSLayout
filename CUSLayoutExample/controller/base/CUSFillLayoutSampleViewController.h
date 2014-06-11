//
//  CUSFillLayoutSampleViewController.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUSLayout.h"
#import "CUSLayoutSampleFactory.h"
@interface CUSFillLayoutSampleViewController : CUSViewController
@property (nonatomic,strong) IBOutlet UIView *contentView;


-(IBAction)toolItemClicked:(id)sender;
@end
