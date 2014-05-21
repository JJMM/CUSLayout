/**
 @header CUSGridData.h
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
 @class CUSGridData
 @abstract
 */
@interface CUSGridData : CUSLayoutData
@property (nonatomic,assign) CUSLayoutAlignmentType  horizontalAlignment;
@property (nonatomic,assign) CUSLayoutAlignmentType  verticalAlignment;
@property (nonatomic,assign) NSInteger  horizontalIndent;
@property (nonatomic,assign) NSInteger  verticalIndent;
@property (nonatomic,assign) NSInteger  horizontalSpan;//default:1
@property (nonatomic,assign) NSInteger  verticalSpan;//default:1
@property (nonatomic,assign) NSInteger  widthHint;
@property (nonatomic,assign) NSInteger  heightHint;
@property (nonatomic,assign) BOOL grabExcessHorizontalSpace;
@property (nonatomic,assign) BOOL grabExcessVerticalSpace;
@property (nonatomic,assign) CGFloat minimumWidth;
@property (nonatomic,assign) CGFloat minimumHeight;

//===========internel
@property (nonatomic,assign) int cacheWidth;
@property (nonatomic,assign) int cacheHeight;
-(void) computeSize:(UIView *)control wHint:(int)wHint hHint:(int)hHint flushCache:(BOOL)flushCache;
-(void) flushCache;
@end

/**
 @class CUSGridData(Factory)
 @abstract
 */
@interface CUSGridData(Factory)
+(CUSGridData *)createWithWidth:(CGFloat)width withHeight:(CGFloat)height;
+(CUSGridData *)createGrab;
@end