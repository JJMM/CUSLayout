//
//  CUSLayoutData.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 布局数据对象，辅助布局对象，精确控制容器中的每个控件细节
 */
@interface CUSLayoutData : NSObject
//排除，默认NO，参与布局，当exclude为YES时，控件不参与布局
@property (nonatomic,assign) BOOL exclude;
@end
