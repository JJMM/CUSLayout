//
//  CUSLayoutFrame.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSLayoutFrame.h"
#import "CUSLayoutData.h"
#import "CUSLayoutConstant.h"
@implementation CUSLayoutFrame
@synthesize marginLeft;
@synthesize marginTop;
@synthesize marginRight;
@synthesize marginBottom;

-(NSArray *)getUsealbeChildren:(UIView *)view{
    NSMutableArray * array = [NSMutableArray array];
    if(!view){
        return array;
    }
    
    for (UIView *subView in view.subviews) {
        CUSLayoutData *layoutData = subView.layoutData;
        if(layoutData && layoutData.exclude){
            continue;
        }
        [array addObject:subView];
    }
    return array;
}
-(void)layout:(UIView *)view{
    NSLog(@"super layout");
}
-(CGSize)computeSize:(UIView *)view{
    CGSize size = [self computeSize:view wHint:CUS_LAY_DEFAULT hHint:CUS_LAY_DEFAULT];
    return size;
}

-(CGSize)computeSize:(UIView *)view wHint:(CGFloat)wHint hHint:(CGFloat)hHint{
    CGSize size;
	if (wHint != CUS_LAY_DEFAULT && hHint != CUS_LAY_DEFAULT) {
		size = CGSizeMake(wHint, hHint);
	} else {
        if (view) {
            size = [view sizeThatFits:CGSizeMake(wHint, hHint)];
        }else{
            size = CGSizeMake(32, 32);
        }
    }
    return size;
}
-(void)setControlFrame:(UIView *)view withFrame:(CGRect)frame{
    view.frame = frame;
}

@end
