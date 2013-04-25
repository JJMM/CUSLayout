//
//  CUSLinnerData.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-10.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSLinnerData.h"

@implementation CUSLinnerData
@synthesize width;
@synthesize height;
@synthesize fill;
- (id)init
{
    self = [super init];
    if (self) {
        width = CUS_LAY_DEFAULT;
        height = CUS_LAY_DEFAULT;
        fill = NO;
    }
    return self;
}
@end
