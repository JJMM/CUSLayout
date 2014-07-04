/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLayoutObject+Util.h"


@implementation NSMutableArray(CUSLayoutNumber)
-(void)addFloat:(CGFloat)value{
    NSNumber *number = [NSNumber numberWithFloat:value];
    [self addObject:number];
}

-(void)replaceFloatAtIndex:(NSInteger)index withFloat:(CGFloat)value{
    NSNumber *number = [NSNumber numberWithFloat:value];
    [self replaceObjectAtIndex:index withObject:number];
}
-(CGFloat)floatAtIndex:(NSInteger)index{
    NSNumber *number = [self objectAtIndex:index];
    return [number floatValue];
}

@end

@implementation NSMutableArray(CUSLayoutCGRect)
-(void)addRect:(CGRect)value{
    NSValue *nsValue = [NSValue valueWithCGRect:value];
    [self addObject:nsValue];
}

-(void)replaceRectAtIndex:(NSInteger)index withRect:(CGRect)value{
    NSValue *nsValue = [NSValue valueWithCGRect:value];
    [self replaceObjectAtIndex:index withObject:nsValue];
}
-(CGRect)CGRectAtIndex:(NSInteger)index{
    NSValue *nsValue = [self objectAtIndex:index];
    return [nsValue CGRectValue];
}

@end




@implementation CUS2DArray{
    NSMutableArray *mainArray;
    
}
@synthesize rowCount = _rowCount;
@synthesize columnCount = _columnCount;

-(id)init:(NSInteger)rowCount atColumnCount:(NSInteger)columnCount{
    self = [super init];
    if (self) {
        _rowCount = rowCount;
        _columnCount = columnCount;
        mainArray = [self buildArray:rowCount atColumn:columnCount];
    }
    return self;
}

-(void)setRowCount:(NSInteger)rowCount{
    if (rowCount<=_rowCount) {
        return;
    }

    for (NSInteger i = _rowCount; i < rowCount; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < self.columnCount; j++) {
            [rowArray addObject:[NSNull null]];
        }
        [mainArray addObject:rowArray];
    }
    _rowCount = rowCount;
}
-(NSMutableArray *)buildArray:(NSInteger)rowCount atColumn:(NSInteger)columnCount{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < rowCount; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < columnCount; j++) {
            [rowArray addObject:[NSNull null]];
        }
        [array addObject:rowArray];
    }
    return array;
}

- (id)objectAtRow:(NSInteger)row atColumn:(NSInteger)column{
    if (row < self.rowCount) {
        NSMutableArray * rowArray = [mainArray objectAtIndex:row];
        if (column < self.columnCount) {
            id obj = [rowArray objectAtIndex:column];
            if ([NSNull null] == obj) {
                return nil;
            }else{
                return obj;
            }
        }
    }
    return nil;
}
- (void)addObject:(id)anObject atRow:(NSInteger)row atColumn:(NSInteger)column{
    if (row < self.rowCount) {
        NSMutableArray * rowArray = [mainArray objectAtIndex:row];
        if (column < self.columnCount) {
            [rowArray replaceObjectAtIndex:column withObject:anObject];
            return;
        }
    }
    NSLog(@"2D array insert error:%@  row:%ld column:%ld", anObject, row, column);
}
- (void)removeObjectAtRow:(NSInteger)row atColumn:(NSInteger)column{
    if (row < self.rowCount) {
        NSMutableArray * rowArray = [mainArray objectAtIndex:row];
        if (column < self.columnCount) {
            [rowArray replaceObjectAtIndex:column withObject:[NSNull null]];
            return;
        }
    }
    NSLog(@"2D array delete error:row:%ld column:%ld", row, column);
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