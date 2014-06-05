/**
 @header CUSLayoutDesignerView.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import <UIKit/UIKit.h>

/**
 @class CUSLayoutDesignerView
 @abstract
 */
@interface CUSLayoutDesignerView : UIView
@property (nonatomic,assign) BOOL dragAndDropEnable;
@property (nonatomic,assign) CGFloat dragScale;


//you can override the 3 method to designe youself drag animation.
-(void)dragBegan:(CGPoint)touchPoint;
-(void)dragChanged:(CGPoint)touchPoint;
-(void)dragEnd;
@end