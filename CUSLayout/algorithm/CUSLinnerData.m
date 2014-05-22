/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLinnerData.h"

@implementation CUSLinnerData
@synthesize width;
@synthesize height;
@synthesize fill;
- (id)init
{
    self = [super init];
    if (self) {
        self.width = CUS_LAY_DEFAULT;
        self.height = CUS_LAY_DEFAULT;
        self.fill = NO;
    }
    return self;
}
@end
