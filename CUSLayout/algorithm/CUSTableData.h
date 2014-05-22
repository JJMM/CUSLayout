/**
 @header CUSTableData.h
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
 @class CUSValue
 @code
    [CUSValue initWithFloat:100];
    [CUSValue valueWithPercent:0.25];
 @abstract const object.Renew an object when you want to changing the value
 */
@interface CUSValue : NSObject{
    CUSLayoutDataType dataType;
    CGFloat value;
}

/**
 @abstract init.
 @param floatValue (1 , ∞). Set value type to CUSLayoutDataTypeFloat.
 */
- (id)initWithFloat:(CGFloat)floatValue;

/**
 @abstract init.
 @param percentValue (0 ,1]. Set value type to CUSLayoutDataTypePercent.
 */
- (id)initWithPercent:(CGFloat)percentValue;

-(CUSLayoutDataType)getDataType;
-(CGFloat)getValue;

+ (CUSValue *)valueWithFloat:(float)floatValue;
+ (CUSValue *)valueWithPercent:(float)percentValue;
+ (CUSValue *)valueWithDefault;
+ (CUSValue *)shareValue;

@end

/**
 @class CUSTableData
 @abstract
 */
@interface CUSTableData : CUSLayoutData
@property (nonatomic,strong) CUSValue *width;//Default:[CUSValue shareValue]
@property (nonatomic,strong) CUSValue *height;//Default:[CUSValue shareValue]
@property (nonatomic,assign) CGFloat horizontalIndent;//Default:0
@property (nonatomic,assign) CGFloat verticalIndent;//Default:0

@property (nonatomic,assign) CUSLayoutAlignmentType horizontalAlignment;//Default:CUSLayoutAlignmentFill
@property (nonatomic,assign) CUSLayoutAlignmentType verticalAlignment;//Default:CUSLayoutAlignmentFill

@end


