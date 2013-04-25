//
//  CUSLayoutObject+Util.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-22.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

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
