/**
 @header CUSRowData.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLayoutData.h"
#import "CUSLayoutConstant.h"

/**
 @class CUSRowData
 @abstract
 */
@interface CUSRowData : CUSLayoutData
@property (nonatomic,assign) CGFloat width;//Default:CUS_LAY_DEFAULT
@property (nonatomic,assign) CGFloat height;//Default:CUS_LAY_DEFAULT
//Dafault:NO  If YES The remaining space to the view
@property (nonatomic,assign) BOOL fill;//Dafault:NO
@property (nonatomic,assign) CUSLayoutAlignmentType alignment;//Dafault:CUSLayoutAlignmentFill

/**
 @abstract init.
 @param width
 @param height
 */
- (id)initWithWidth:(CGFloat)width height:(CGFloat)height;
@end
