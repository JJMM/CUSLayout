//
//  CUSLayoutUtil.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-10.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSLayoutUtil.h"

static CUSLayoutUtil  *CUSLayoutInstance;
@implementation CUSLayoutUtil
@synthesize share_fillLayout_H;
@synthesize share_fillLayout_V;

@synthesize share_linnerLayout_H;
@synthesize share_linnerLayout_V;
@synthesize share_linnerData;

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
        self.share_rowLayout_H = [[CUSRowLayout alloc]init];
        self.share_rowLayout_H.type = CUSLayoutTypeVertical;
        
        self.share_rowData = [[CUSRowData alloc]init];
        
        self.share_linnerLayout_H = [[CUSLinnerLayout alloc]init];
        self.share_linnerLayout_H.type = CUSLayoutTypeHorizontal;
        self.share_linnerLayout_V = [[CUSLinnerLayout alloc]init];

        self.share_linnerData = [[CUSLinnerData alloc]init];
        self.share_tableData =  [[CUSTableData alloc]init];
        
    }
    return self;
}

+(CUSLayoutUtil *)getShareInstance{
    return CUSLayoutInstance;
}

+(void)load{
    //初始化，仅须有初始化一次，以后不要重复调用
    if (!CUSLayoutInstance) {
        CUSLayoutInstance = [[CUSLayoutUtil alloc]init];
    }
}
@end
