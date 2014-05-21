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
@property (nonatomic,assign) NSInteger numColumns;
@property (nonatomic,assign) BOOL makeColumnsEqualWidth;
@property (nonatomic,assign) CGFloat horizontalSpacing;
@property (nonatomic,assign) CGFloat verticalSpacing;

- (id)initWithNumColumns:(NSInteger)numColumns;
@end
