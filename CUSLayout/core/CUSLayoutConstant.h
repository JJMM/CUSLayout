/**
 @header CUSLayoutConstant.h
 @abstract Constant:CUSLayoutType,CUSLayoutAlignmentType,CUSLayoutDataType
 @code
    use CUSLayout
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

/**
 @enum CUSLayoutType
 @abstract Layout direction.Used it in LayoutFrame.
 */
typedef enum {
    CUSLayoutTypeHorizontal,
    CUSLayoutTypeVertical
}CUSLayoutType;

/**
 @enum CUSLayoutAlignmentType
 @abstract Layout alignment position.Used it in LayoutData.
 */
typedef enum {
    CUSLayoutAlignmentLeft,
    CUSLayoutAlignmentCenter,
    CUSLayoutAlignmentRight,
    CUSLayoutAlignmentFill
}CUSLayoutAlignmentType;

/**
 @enum CUSLayoutDataType
 @abstract Data value type.It's not the type of the LayoutData object.
 */
typedef enum {
    CUSLayoutDataTypeFloat,
    CUSLayoutDataTypePercent,
    CUSLayoutDataTypeDefault
}CUSLayoutDataType;

#define CUSLAYOUT ([CUSLayoutUtil getShareInstance])
//#define CUS_LAYOUT ([CUSLayoutUtil getShareInstance])
#define CUS_LAY_DEFAULT (-1)
#define CUS_LAY_EMPTY (-999999)

