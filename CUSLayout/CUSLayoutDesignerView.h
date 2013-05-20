//
//  CUSLayoutDesignerView.h
//  CUSLayout
//
//  Created by zhangyu on 13-5-20.
//
//

#import <UIKit/UIKit.h>
#import "UIView+CUSLayout.h"
#import "CUSLayoutData.h"

@interface CUSLayoutDesignerView : UIView
@property (nonatomic,assign) BOOL dragAndDropEnable;
@property (nonatomic,assign) CGFloat dragScale;


//you can override the 3 method to designe youself drag animation.
-(void)dragBegan:(CGPoint)touchPoint;
-(void)dragChanged:(CGPoint)touchPoint;
-(void)dragEnd;
@end