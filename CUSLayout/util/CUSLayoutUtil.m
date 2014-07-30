/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLayoutUtil.h"

static CUSLayoutUtil  *CUSLayoutInstance;
@implementation CUSLayoutUtil
@synthesize share_fillLayout_H;
@synthesize share_fillLayout_V;

@synthesize share_linearLayout_H;
@synthesize share_linearLayout_V;
@synthesize share_linearData;

@synthesize share_rowLayout_H;
@synthesize share_rowLayout_V;
@synthesize share_rowData;

@synthesize share_tableData;
- (id)init
{
    self = [super init];
    if (self) {
        self.share_fillLayout_H = [[CUSFillLayout alloc]init];
        self.share_fillLayout_V = [[CUSFillLayout alloc]init];
        self.share_fillLayout_V.type = CUSLayoutTypeVertical;
        
        self.share_rowLayout_H = [[CUSRowLayout alloc]init];
        self.share_rowLayout_V = [[CUSRowLayout alloc]init];
        self.share_rowLayout_V.type = CUSLayoutTypeVertical;
        
        self.share_rowData = [[CUSRowData alloc]init];
        
        self.share_linearLayout_H = [[CUSLinearLayout alloc]init];
        self.share_linearLayout_H.type = CUSLayoutTypeHorizontal;
        self.share_linearLayout_V = [[CUSLinearLayout alloc]init];

        self.share_linearData = [[CUSLinearData alloc]init];
        self.share_tableData =  [[CUSTableData alloc]init];
        
    }
    return self;
}

+(CUSLayoutUtil *)getShareInstance{
    if (!CUSLayoutInstance) {
        CUSLayoutInstance = [[CUSLayoutUtil alloc]init];
    }
    return CUSLayoutInstance;
}
@end
