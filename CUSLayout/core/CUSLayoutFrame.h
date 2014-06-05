/**
 @header CUSLayoutFrame.h
 @abstract
 @code

 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+CUSLayout.h"
/**
 @class CUSLayoutFrame
 @abstract
    The base object of Layout define.
 */
@interface CUSLayoutFrame : NSObject
@property (nonatomic,assign) CGFloat marginLeft;
@property (nonatomic,assign) CGFloat marginTop;
@property (nonatomic,assign) CGFloat marginRight;
@property (nonatomic,assign) CGFloat marginBottom;

/**
 @abstract set marginLeft,marginTop,marginRight,marginBottom
 @param margin
 */
-(void)setMargin:(CGFloat)margin;

/**
 @abstract set marginLeft and marginRight
 @param margin
 */
-(void)setMarginWidth:(CGFloat)margin;

/**
 @abstract set marginTop and marginBottom
 @param margin
 */
-(void)setMarginHeight:(CGFloat)margin;


/////////////////Protected method for internal use/////////////////
/**
 @abstract The core layout method.
 @protected internal method
 @param view layout view
 */
-(void)layout:(UIView *)view;

/**
 @abstract compute the layout size
 @protected internal method
 @param view layout view
 */
-(CGSize)computeSize:(UIView *)view;

/**
 @abstract compute the layout size
 @protected internal method
 @param view layout view
 @param wHint width
 @param hHint height
 */
-(CGSize)computeSize:(UIView *)view wHint:(CGFloat)wHint hHint:(CGFloat)hHint;

/**
 @abstract get the subview,layoutData.exclude == NO
 @protected internal method
 @param view layout view
 */
-(NSArray *)getUsealbeChildren:(UIView *)view;

/**
 @abstract set marginTop and marginBottom
 @protected internal method
 @param view subview
 @param frame
 */
-(void)setControlFrame:(UIView *)view withFrame:(CGRect)frame;

@end