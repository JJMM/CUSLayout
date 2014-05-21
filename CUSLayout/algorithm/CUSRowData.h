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
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
//默认NO，如果时fill，剩余位置分给该控件
@property (nonatomic,assign) BOOL fill;
//对齐：受布局水平或垂直类型影响
@property (nonatomic,assign) CUSLayoutAlignmentType alignment;

- (id)initWithWidth:(CGFloat)width height:(CGFloat)height;
@end
