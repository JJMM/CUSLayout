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
 @abstract
 流式布局：一种简单的布局，RowLayou的简化版，类似HTML中的布局或Android中的LinnerLayout
 简单、高效率，推荐使用
 */
@interface CUSLinnerLayout : CUSLayoutFrame
//填充方向：默认水平方向
@property (nonatomic,assign) CUSLayoutType type;
//对齐：受布局水平或垂直类型影响
@property (nonatomic,assign) CUSLayoutAlignmentType alignment;
//子控件间距
@property (nonatomic,assign) CGFloat spacing;
@end
