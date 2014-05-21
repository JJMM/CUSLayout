/**
 @header CUSFillLayout.h
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
 @class CUSFillLayout
 @abstract
 充满式布局:一种简单布局，以同样大小对容器中的子组件进行布局， 这些子组件可以一行或一列的形式排列，并且填充整个容器的空间。
 效率超高、建议使用
 */
@interface CUSFillLayout : CUSLayoutFrame
//填充方向:默认水平方向
@property (nonatomic,assign) CUSLayoutType type;
//子控件间距
@property (nonatomic,assign) CGFloat spacing;

@end
