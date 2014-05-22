/**
 @header CUSGridLayout.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLayoutFrame.h"

/**
 @class CUSGridLayout
 @abstract
 */
@interface CUSGridLayout : CUSLayoutFrame
@property (nonatomic,assign) NSInteger numColumns;//Default:1
@property (nonatomic,assign) BOOL makeColumnsEqualWidth;//Default:YES
@property (nonatomic,assign) CGFloat horizontalSpacing;//Default:5
@property (nonatomic,assign) CGFloat verticalSpacing;//Default:5

/**
 @abstract init.
 @param numColumns
 */
- (id)initWithNumColumns:(NSInteger)numColumns;
@end
