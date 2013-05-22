//
//  CUSStackLayout.h
//  CUSLayout
//
//  Created by zhangyu on 13-5-22.
//
//

#import "CUSLayoutFrame.h"
#import "CUSLayoutConstant.h"

/*
 堆栈布局：一种简单的布局，以充满的形式，仅显示一个子控件
 简单、高效率，推荐使用
 */
@interface CUSStackLayout : CUSLayoutFrame
//The index of view.If "CUSLayoutData.exclude = YES;",it do not need to count.
@property (nonatomic,assign) NSInteger showViewIndex;
@end
