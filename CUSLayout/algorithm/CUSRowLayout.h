/**
 @header CUSRowLayout.h
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
 @class CUSLinnerLayout
 @abstract The subview in the parent view layout to a row or column
 */
@interface CUSRowLayout : CUSLayoutFrame
@property (nonatomic,assign) CUSLayoutType type;//Default:CUSLayoutTypeHorizontal
@property (nonatomic,assign) CGFloat spacing;//Default:5

//If NO layout in one line, elsewise layout in mutil lines
@property (nonatomic,assign) BOOL wrap;//Default:YES

//It work on wrap = NO.All subviews fill the remaining space to the view.
@property (nonatomic,assign) BOOL fill;//Default:NO

//Not implemented
@property (nonatomic,assign) BOOL pack;//Default:YES

//Spacing to divide, spacing control, make the control looks uniform
@property (nonatomic,assign) BOOL justify;//Default:NO

@end
