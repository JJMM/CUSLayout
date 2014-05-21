/**
 @header CUSLayoutObject+Util.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface NSMutableArray(CUSLayoutNumber)
-(void)addFloat:(CGFloat)value;
-(void)replaceFloatAtIndex:(NSUInteger)index withFloat:(CGFloat)value;
-(CGFloat)floatAtIndex:(NSUInteger)index;
@end

@interface NSMutableArray(CUSLayoutCGRect)
-(void)addRect:(CGRect)value;
-(void)replaceRectAtIndex:(NSUInteger)index withRect:(CGRect)value;
-(CGRect)CGRectAtIndex:(NSUInteger)index;
@end


@interface CUS2DArray : NSObject
@property (nonatomic,assign) NSInteger rowCount;
@property (nonatomic,assign,readonly) NSInteger columnCount;
-(id)init:(NSUInteger)rowCount atColumnCount:(NSUInteger)columnCount;
- (id)objectAtRow:(NSUInteger)row atColumn:(NSUInteger)column;
- (void)addObject:(id)anObject atRow:(NSUInteger)row atColumn:(NSUInteger)column;
- (void)removeObjectAtRow:(NSUInteger)row_ atColumn:(NSUInteger)column_;
@end