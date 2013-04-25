//
//  CUSLayoutObject+Util.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-22.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSLayoutObject+Util.h"


@implementation NSMutableArray(CUSLayoutNumber)
-(void)addFloat:(CGFloat)value{
    NSNumber *number = [NSNumber numberWithFloat:value];
    [self addObject:number];
}

-(void)replaceFloatAtIndex:(NSUInteger)index withFloat:(CGFloat)value{
    NSNumber *number = [NSNumber numberWithFloat:value];
    [self replaceObjectAtIndex:index withObject:number];
}
-(CGFloat)floatAtIndex:(NSUInteger)index{
    NSNumber *number = [self objectAtIndex:index];
    return [number floatValue];
}

@end

@implementation NSMutableArray(CUSLayoutCGRect)
-(void)addRect:(CGRect)value{
    NSValue *nsValue = [NSValue valueWithCGRect:value];
    [self addObject:nsValue];
}

-(void)replaceRectAtIndex:(NSUInteger)index withRect:(CGRect)value{
    NSValue *nsValue = [NSValue valueWithCGRect:value];
    [self replaceObjectAtIndex:index withObject:nsValue];
}
-(CGRect)CGRectAtIndex:(NSUInteger)index{
    NSValue *nsValue = [self objectAtIndex:index];
    return [nsValue CGRectValue];
}

@end