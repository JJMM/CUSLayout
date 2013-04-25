//
//  CUSTableData.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-10.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSLayoutData.h"
#import "CUSLayoutConstant.h"

//不变对象，不能改变value，如果需要改变，请重新创建
@interface CUSValue : NSObject{
    CUSLayoutDataType dataType;
    CGFloat value;
}

- (id)initWithFloat:(CGFloat)floatValue;

- (id)initWithPercent:(CGFloat)percentValue;
-(CUSLayoutDataType)getDataType;
-(CGFloat)getValue;

+ (CUSValue *)valueWithFloat:(float)floatValue;
+ (CUSValue *)valueWithPercent:(float)percentValue;
+ (CUSValue *)valueWithDefault;
+ (CUSValue *)shareValue;

@end

@interface CUSTableData : CUSLayoutData
@property (nonatomic,strong) CUSValue *width;
@property (nonatomic,strong) CUSValue *height;
@property (nonatomic,assign) CGFloat horizontalIndent;
@property (nonatomic,assign) CGFloat verticalIndent;

@property (nonatomic,assign) CUSLayoutAlignmentType horizontalAlignment;
@property (nonatomic,assign) CUSLayoutAlignmentType verticalAlignment;

@end


