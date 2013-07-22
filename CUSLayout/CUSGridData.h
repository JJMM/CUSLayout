//
//  CUSGridData.h
//  CUSLayout
//
//  Created by zhangyu on 13-7-17.
//
//

#import "CUSLayoutData.h"
#import "CUSLayoutConstant.h"
@interface CUSGridData : CUSLayoutData
@property (nonatomic,assign) CUSLayoutAlignmentType  horizontalAlignment;
@property (nonatomic,assign) CUSLayoutAlignmentType  verticalAlignment;
@property (nonatomic,assign) NSInteger  horizontalIndent;
@property (nonatomic,assign) NSInteger  verticalIndent;
@property (nonatomic,assign) NSInteger  horizontalSpan;//default:1
@property (nonatomic,assign) NSInteger  verticalSpan;//default:1
@property (nonatomic,assign) NSInteger  widthHint;
@property (nonatomic,assign) NSInteger  heightHint;
@property (nonatomic,assign) BOOL grabExcessHorizontalSpace;
@property (nonatomic,assign) BOOL grabExcessVerticalSpace;
@property (nonatomic,assign) CGFloat minimumWidth;
@property (nonatomic,assign) CGFloat minimumHeight;

//===========internel
@property (nonatomic,assign) int cacheWidth;
@property (nonatomic,assign) int cacheHeight;
-(void) computeSize:(UIView *)control wHint:(int)wHint hHint:(int)hHint flushCache:(BOOL)flushCache;
-(void) flushCache;
@end


@interface CUSGridData(Factory)
+(CUSGridData *)createWithWidth:(CGFloat)width withHeight:(CGFloat)height;
+(CUSGridData *)createGrab;
@end