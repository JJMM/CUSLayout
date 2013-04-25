//
//  CUSTableData.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-10.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSTableData.h"


static CUSValue* CUSValueInstance;
@implementation CUSValue
- (id)init
{
    self = [super init];
    if (self) {
        dataType = CUSLayoutDataTypeDefault;
        value = CUS_LAY_DEFAULT;
    }
    return self;
}
- (id)initWithFloat:(CGFloat)floatValue{
    self = [super init];
    if (self) {
        dataType = CUSLayoutDataTypeFloat;
        value = floatValue;
    }
    return self;
}

- (id)initWithPercent:(CGFloat)percentValue{
    self = [super init];
    if (self) {
        dataType = CUSLayoutDataTypePercent;
        value = percentValue;
    }
    return self;
}
-(CUSLayoutDataType)getDataType{
    return dataType;
}
-(CGFloat)getValue{
    return value;
}

+ (CUSValue *)valueWithFloat:(float)floatValue{
    return [[CUSValue alloc]initWithFloat:floatValue];
}
+ (CUSValue *)valueWithPercent:(float)percentValue{
    return [[CUSValue alloc]initWithPercent:percentValue];
}
+ (CUSValue *)valueWithDefault{
    return CUSValueInstance;
}

-(NSString *)description{
    NSString *typeStr = nil;
    if([self getDataType] == CUSLayoutDataTypeFloat){
        typeStr = @"Float";
    }else if([self getDataType] == CUSLayoutDataTypePercent){
        typeStr = @"Percent";
    }else{
        typeStr = @"Default";
    }
    
    NSString *str = [NSString stringWithFormat:@"CUSValue:%@ %f",typeStr,value];
    return str;
}

+ (CUSValue *)shareValue{
    return CUSValueInstance;
}
+(void)load{
    CUSValueInstance = [[CUSValue alloc]init];
}


@end

@implementation CUSTableData
@synthesize width;
@synthesize height;
@synthesize horizontalIndent;
@synthesize verticalIndent;
@synthesize horizontalAlignment;
@synthesize verticalAlignment;

- (id)init
{
    self = [super init];
    if (self) {
        width = [CUSValue shareValue];
        height = [CUSValue shareValue];
        horizontalIndent = 0.0;
        verticalIndent = 0.0;
        horizontalAlignment = CUSLayoutAlignmentFill;
        verticalAlignment = CUSLayoutAlignmentFill;
    }
    return self;
}

- (id)init:(CUSValue *)width_ height:(CUSValue *)height_{
    self = [self init];
    if (self) {
        width = width_;
        height = height_;
    }
    return self;
}

@end