/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSRowData.h"

@implementation CUSRowData
@synthesize width = _width;
@synthesize height = _height;
@synthesize fill;
@synthesize alignment;

- (id)init
{
    self = [super init];
    if (self) {
        self.width = CUS_LAY_DEFAULT;
        self.height = CUS_LAY_DEFAULT;
        self.fill = NO;
        self.alignment = CUSLayoutAlignmentFill;
    }
    return self;
}

- (id)initWithWidth:(CGFloat)width height:(CGFloat)height{
    self = [super init];
    if (self) {
        self.width = width;
        self.height = height;
    }
    return self;
}
@end
