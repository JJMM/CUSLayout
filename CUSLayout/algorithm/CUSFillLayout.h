/**
 @header CUSFillLayout.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLayoutFrame.h"
#import "CUSLayoutConstant.h"

/**
 @class CUSFillLayout
 @abstract A simple and efficient layout.Fill in all the subview in the parent view.
 */
@interface CUSFillLayout : CUSLayoutFrame
@property (nonatomic,assign) CUSLayoutType type;//Default:CUSLayoutTypeHorizontal
@property (nonatomic,assign) CGFloat spacing;   //Default:5

@end
