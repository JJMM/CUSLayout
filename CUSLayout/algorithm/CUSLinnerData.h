/**
 @header CUSLinnerData.h
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
 @class CUSLinnerData
 @abstract
 */
@interface CUSLinnerData : CUSLayoutData
@property (nonatomic,assign) CGFloat width;//Default:CUS_LAY_DEFAULT
@property (nonatomic,assign) CGFloat height;//Default:CUS_LAY_DEFAULT
@property (nonatomic,assign) BOOL fill;//Default:NO

@end