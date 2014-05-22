/**
 @header CUSStackLayout.h
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
 @class CUSStackLayout
 @abstract Full screen display a view from subviews.
 */
@interface CUSStackLayout : CUSLayoutFrame
//The index of view.If "CUSLayoutData.exclude = YES;",it do not need to count.
@property (nonatomic,assign) NSInteger showViewIndex;
@end
