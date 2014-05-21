//
//  CUSStackLayoutSampleViewController.h
//  CUSLayout
//
//  Created by zhangyu on 13-5-22.
//
//

#import <UIKit/UIKit.h>
#import "CUSLayout.h"
#import "CUSLayoutSampleFactory.h"

@interface CUSStackLayoutSampleViewController : CUSViewController
@property (nonatomic,strong) IBOutlet UIView *contentView;


-(IBAction)toolItemClicked:(id)sender;
@end
