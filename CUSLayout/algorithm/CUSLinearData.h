/**
 @header CUSLinearData.h
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
 @class CUSLinearData
 @abstract
 */
@interface CUSLinearData : CUSLayoutData
@property (nonatomic,assign) CGFloat width;//Default:CUS_LAY_DEFAULT
@property (nonatomic,assign) CGFloat height;//Default:CUS_LAY_DEFAULT
@property (nonatomic,assign) BOOL fill;//Default:NO

- (instancetype)initWithWidth:(CGFloat)width;

- (instancetype)initWithHeight:(CGFloat)height;

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;

- (instancetype)initWithFill:(CGFloat)fill;
@end


@interface CUSLinearData(Factory)

+ (CUSLinearData *)createWithWidth:(CGFloat)width;

+ (CUSLinearData *)createWithHeight:(CGFloat)height;

+ (CUSLinearData *)createWithWidth:(CGFloat)width height:(CGFloat)height;

+ (CUSLinearData *)createWithFill:(CGFloat)fill;
@end