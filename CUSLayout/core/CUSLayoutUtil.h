/**
 @header CUSLayoutUtil.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "CUSLayoutFrame.h"
#import "CUSLayoutData.h"

#import "CUSFillLayout.h"
#import "CUSLinnerLayout.h"
#import "CUSLinnerData.h"
#import "CUSRowLayout.h"
#import "CUSRowData.h"
#import "CUSTableLayout.h"
#import "CUSTableData.h"

/**
 @class CUSLayoutUtil
 @abstract
 静态工具类
 注意，此类中提供的对象是全局共用对象，不能修改任何成员变量，否则会影响到共用此对象的布局
 */
@class CUSLayoutUtil;
@interface CUSLayoutUtil : NSObject
@property (nonatomic,strong) CUSFillLayout *share_fillLayout_H;
@property (nonatomic,strong) CUSFillLayout *share_fillLayout_V;

@property (nonatomic,strong) CUSLinnerLayout *share_linnerLayout_H;
@property (nonatomic,strong) CUSLinnerLayout *share_linnerLayout_V;
@property (nonatomic,strong) CUSLinnerData *share_linnerData;

@property (nonatomic,strong) CUSRowLayout *share_rowLayout_H;
@property (nonatomic,strong) CUSRowLayout *share_rowLayout_V;
@property (nonatomic,strong) CUSRowData *share_rowData;

@property (nonatomic,strong) CUSTableData *share_tableData;

+(CUSLayoutUtil *)getShareInstance;
@end

