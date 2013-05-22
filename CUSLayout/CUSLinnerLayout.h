//
//  CUSLinnerLayout.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-10.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSLayoutFrame.h"
#import "CUSLayoutConstant.h"

/*
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
