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
@property (nonatomic,assign) CUSLayoutAlignmentType  horizontalAlignment;//Default:CUSLayoutAlignmentFill
@property (nonatomic,assign) CUSLayoutAlignmentType  verticalAlignment;//Default:CUSLayoutAlignmentFill
@property (nonatomic,assign) NSInteger  horizontalIndent;//Default:0
@property (nonatomic,assign) NSInteger  verticalIndent;//Default:0
@property (nonatomic,assign) NSInteger  horizontalSpan;//Default:1
@property (nonatomic,assign) NSInteger  verticalSpan;//Default:1
@property (nonatomic,assign) NSInteger  widthHint;//Default:CUS_LAY_DEFAULT
@property (nonatomic,assign) NSInteger  heightHint;//Default:CUS_LAY_DEFAULT
@property (nonatomic,assign) BOOL grabExcessHorizontalSpace;//Default:NO
@property (nonatomic,assign) BOOL grabExcessVerticalSpace;//Default:NO
@property (nonatomic,assign) CGFloat minimumWidth;//Default:0
@property (nonatomic,assign) CGFloat minimumHeight;//Default:0

//===========internel
@property (nonatomic,assign) NSInteger cacheWidth;//Default:-1
@property (nonatomic,assign) NSInteger cacheHeight;//Default:-1

-(void) computeSize:(UIView *)control wHint:(NSInteger)wHint hHint:(NSInteger)hHint flushCache:(BOOL)flushCache;
-(void) flushCache;
@end

/**
 @class CUSGridData(Factory)
 @abstract
 */
@interface CUSGridData(Factory)

/**
 @abstract init.
 @param width
 @param height
 @result CUSGridData *
 */
+(CUSGridData *)createWithWidth:(CGFloat)width withHeight:(CGFloat)height;

/**
 @abstract init.
 @result CUSGridData *
 */
+(CUSGridData *)createGrab;
@end