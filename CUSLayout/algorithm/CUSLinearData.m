/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLinearData.h"

@implementation CUSLinearData
@synthesize width = _width;
@synthesize height = _height;
@synthesize fill = _fill;
- (id)init
{
    self = [super init];
    if (self) {
        self.width = CUS_LAY_DEFAULT;
        self.height = CUS_LAY_DEFAULT;
        self.fill = NO;
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width
{
    self = [self init];
    if (self) {
        _width = width;
    }
    return self;
}

- (instancetype)initWithHeight:(CGFloat)height
{
    self = [self init];
    if (self) {
        _height = height;
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height
{
    self = [self init];
    if (self) {
        _width = width;
        _height = height;
    }
    return self;
}

- (instancetype)initWithFill:(CGFloat)fill
{
    self = [self init];
    if (self) {
        _fill = fill;
    }
    return self;
}
@end

@implementation CUSLinearData(Factory)
+ (CUSLinearData *)createWithWidth:(CGFloat)width
{
    return [[CUSLinearData alloc]initWithWidth:width];
}

+ (CUSLinearData *)createWithHeight:(CGFloat)height
{
    return [[CUSLinearData alloc]initWithHeight:height];
}

+ (CUSLinearData *)createWithWidth:(CGFloat)width height:(CGFloat)height
{
    return [[CUSLinearData alloc]initWithWidth:width height:height];
}

+ (CUSLinearData *)createWithFill:(CGFloat)fill
{
    return [[CUSLinearData alloc]initWithFill:fill];
}

@end
