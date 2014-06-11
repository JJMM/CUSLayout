//
//  CUSGridLayoutSampleViewController.h
//  CUSLayout
//
//  Created by zhangyu on 13-7-19.
//
//

#import <UIKit/UIKit.h>
#import "CUSLayoutSampleFactory.h"
@interface CUSGridLayoutSampleViewController : CUSViewController
@property (nonatomic,strong) IBOutlet UIView *contentView;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
-(IBAction)toolItemClicked:(id)sender;
@end
