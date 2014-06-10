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
@synthesize rowCount;
@synthesize columnCount;

-(id)init:(NSInteger)rowCount_ atColumnCount:(NSInteger)columnCount_
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

    for (NSInteger i = rowCount; i < rowCount_; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < self.columnCount; j++) {
            [rowArray addObject:[NSNull null]];
        }
        [mainArray addObject:rowArray];
    }
    rowCount = rowCount_;
}
-(NSMutableArray *)buildArray:(NSInteger)rowCount_ atColumn:(NSInteger)columnCount_{
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

- (id)objectAtRow:(NSInteger)row_ atColumn:(NSInteger)column_{
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
- (void)addObject:(id)anObject atRow:(NSInteger)row_ atColumn:(NSInteger)column_{
    if (row_ < self.rowCount) {
        NSMutableArray * rowArray = [mainArray objectAtIndex:row_];
        if (column_ < self.columnCount) {
            [rowArray replaceObjectAtIndex:column_ withObject:anObject];
            return;
        }
    }
    NSLog(@"2D array insert error:%@  row:%d column:%d", anObject, (int)row_, (int)column_);
}
- (void)removeObjectAtRow:(NSInteger)row_ atColumn:(NSInteger)column_{
    if (row_ < self.rowCount) {
        NSMutableArray * rowArray = [mainArray objectAtIndex:row_];
        if (column_ < self.columnCount) {
            [rowArray replaceObjectAtIndex:column_ withObject:[NSNull null]];
            return;
        }
    }
    NSLog(@"2D array delete error:row:%d column:%d", (int)row_, (int)column_);
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