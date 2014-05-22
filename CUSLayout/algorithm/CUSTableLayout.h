/**
 @header CUSTableLayout.h
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
 @class CUSTableLayout
 @abstract HTML Table Layout
 */
@interface CUSTableLayout : CUSLayoutFrame
@property (nonatomic,assign) BOOL pixelFirst;//Default:5
@property (nonatomic,assign) CGFloat spacing;//Default:5

/**
 * @abstract init
 * @param columnWiths
 * @param rowHeights
 */
- (id)initWithcolumns:(NSArray *)columnWiths rows:(NSArray *)rowHeights;

/**
 * @abstract merge
 * @param column
 * @param row
 * @param colspan
 * @param rowspan
 */
-(void) merge:(NSInteger)column row:(NSInteger)row colspan:(NSInteger) colspan rowspan:(NSInteger) rowspan;

/**
 * @abstract unmerge
 * @param column
 * @param row
 */
-(void)unmerge:(NSInteger)column row:(NSInteger)row;

/**
 * @abstract
 * @result NSInteger
 */
-(NSInteger)getColumnCount;

/**
 * @abstract
 * @result NSInteger
 */
-(NSInteger)getRowCount;

@end
