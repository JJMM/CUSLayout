/**
 @header CUSLinnerLayout.h
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
 @abstract A simple and efficient layout.Similar to HTML layout or Android LinnerLayout.
 */
@interface CUSLinnerLayout : CUSLayoutFrame
@property (nonatomic,assign) CUSLayoutType type;//Default:CUSLayoutTypeVertical
@property (nonatomic,assign) CUSLayoutAlignmentType alignment;//Default:CUSLayoutAlignmentFill
@property (nonatomic,assign) CGFloat spacing;//Default:5
@end
