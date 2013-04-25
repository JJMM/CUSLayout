//
//  CUSConstant.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

typedef enum {
    CUSLayoutTypeHorizontal,
    CUSLayoutTypeVertical
}CUSLayoutType;


typedef enum {
    CUSLayoutAlignmentLeft,
    CUSLayoutAlignmentCenter,
    CUSLayoutAlignmentRight,
    CUSLayoutAlignmentFill
}CUSLayoutAlignmentType;

typedef enum {
    CUSLayoutDataTypeFloat,
    CUSLayoutDataTypePercent,
    CUSLayoutDataTypeDefault
}CUSLayoutDataType;


#define CUS_LAYOUT ([CUSLayoutUtil getShareInstance])
#define CUS_LAY_DEFAULT (-1)
#define CUS_LAY_EMPTY (-999999)

