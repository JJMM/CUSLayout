//
//  CUSRowData.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSRowData.h"

@implementation CUSRowData
@synthesize width;
@synthesize height;
@synthesize fill;
@synthesize alignment;

- (id)init
{
    self = [super init];
    if (self) {
        width = CUS_LAY_DEFAULT;
        height = CUS_LAY_DEFAULT;
        fill = NO;
        alignment = CUSLayoutAlignmentFill;
    }
    return self;
}

- (id)initWithWidth:(CGFloat)width_ height:(CGFloat)height_{
    self = [super init];
    if (self) {
        width = width_;
        height = height_;
    }
    return self;
}
@end
