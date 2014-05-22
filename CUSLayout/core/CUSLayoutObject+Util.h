/**
 @header CUSLayoutObject+Util.h
 @abstract internal tools
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 @class NSMutableArray(CUSLayoutNumber)
 @abstract
 */
@interface NSMutableArray(CUSLayoutNumber)

/**
 @abstract internal method
 @param value
 */
-(void)addFloat:(CGFloat)value;

/**
 @abstract internal method
 @param index
 @param value
 */
-(void)replaceFloatAtIndex:(NSUInteger)index withFloat:(CGFloat)value;

/**
 @abstract internal method
 @param animate
 @result CGFloat
 */
-(CGFloat)floatAtIndex:(NSUInteger)index;
@end


/**
 @class NSMutableArray(CUSLayoutCGRect)
 @abstract
 */
@interface NSMutableArray(CUSLayoutCGRect)

/**
 @abstract internal method
 @param value
 */
-(void)addRect:(CGRect)value;

/**
 @abstract internal method
 @param index
 @param value
 */
-(void)replaceRectAtIndex:(NSUInteger)index withRect:(CGRect)value;

/**
 @abstract internal method
 @param index
 @result CGRect
 */
-(CGRect)CGRectAtIndex:(NSUInteger)index;
@end


/**
 @class CUS2DArray
 @abstract
 */
@interface CUS2DArray : NSObject
@property (nonatomic,assign) NSInteger rowCount;
@property (nonatomic,assign,readonly) NSInteger columnCount;

-(id)init:(NSUInteger)rowCount atColumnCount:(NSUInteger)columnCount;
- (id)objectAtRow:(NSUInteger)row atColumn:(NSUInteger)column;
- (void)addObject:(id)anObject atRow:(NSUInteger)row atColumn:(NSUInteger)column;
- (void)removeObjectAtRow:(NSUInteger)row_ atColumn:(NSUInteger)column_;
@end