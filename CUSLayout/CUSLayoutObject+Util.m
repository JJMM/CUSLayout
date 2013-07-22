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




@implementation CUS2DArray{
    NSMutableArray *mainArray;
    
}
@synthesize rowCount;
@synthesize columnCount;

-(id)init:(NSUInteger)rowCount_ atColumnCount:(NSUInteger)columnCount_
{
    self = [super init];
    if (self) {
        rowCount = rowCount_;
        columnCount = columnCount_;
        mainArray = [self buildArray:rowCount_ atColumn:columnCount_];
    }
    return self;
}

-(void)setRowCount:(NSInteger)rowCount_{
    if (rowCount_<=rowCount) {
        return;
    }

    for (int i = rowCount; i < rowCount_; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < self.columnCount; j++) {
            [rowArray addObject:[NSNull null]];
        }
        [mainArray addObject:rowArray];
    }
    rowCount = rowCount_;
}
-(NSMutableArray *)buildArray:(NSUInteger)rowCount_ atColumn:(NSUInteger)columnCount_{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < rowCount_; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < columnCount_; j++) {
            [rowArray addObject:[NSNull null]];
        }
        [array addObject:rowArray];
    }
    return array;
}

- (id)objectAtRow:(NSUInteger)row_ atColumn:(NSUInteger)column_{
    if (row_ < self.rowCount) {
        NSMutableArray * rowArray = [mainArray objectAtIndex:row_];
        if (column_ < self.columnCount) {
            id obj = [rowArray objectAtIndex:column_];
            if ([NSNull null] == obj) {
                return nil;
            }else{
                return obj;
            }
        }
    }
    return nil;
}
- (void)addObject:(id)anObject atRow:(NSUInteger)row_ atColumn:(NSUInteger)column_{
    if (row_ < self.rowCount) {
        NSMutableArray * rowArray = [mainArray objectAtIndex:row_];
        if (column_ < self.columnCount) {
            [rowArray replaceObjectAtIndex:column_ withObject:anObject];
            return;
        }
    }
    NSLog(@"2D数组插入失败:%@  row:%i column:%i", anObject, row_, column_);
}
- (void)removeObjectAtRow:(NSUInteger)row_ atColumn:(NSUInteger)column_{
    if (row_ < self.rowCount) {
        NSMutableArray * rowArray = [mainArray objectAtIndex:row_];
        if (column_ < self.columnCount) {
            [rowArray replaceObjectAtIndex:column_ withObject:[NSNull null]];
            return;
        }
    }
    NSLog(@"2D数组删除失败:row:%i column:%i", row_, column_);
}

-(NSString *)description{
    NSMutableString *str = [NSMutableString stringWithString:@"\n==========CUS2DArray===========\n"];
    for (int i = 0; i < self.rowCount; i++) {
        NSMutableArray *rowArray = [mainArray objectAtIndex:i];
        for (int j = 0; j < self.columnCount; j++) {
            id obj = [rowArray objectAtIndex:j];
            [str appendString:[[obj class] description]];
            [str appendString:@" "];
        }
        [str appendString:@"\n"];
    }
    return str;
};
@end