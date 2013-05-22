//
//  CUSLinnerLayout.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-10.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSLinnerLayout.h"
#import "CUSLinnerData.h"
@implementation CUSLinnerLayout
@synthesize type;
@synthesize alignment;
@synthesize spacing;

- (id)init
{
    self = [super init];
    if (self) {
        type = CUSLayoutTypeVertical;
        alignment = CUSLayoutAlignmentFill;
        spacing = 5;
        
        self.marginLeft = 5;
        self.marginTop = 5;
        self.marginRight = 5;
        self.marginBottom = 5;
    }
    return self;
}

-(void)layout:(UIView *)composite{
    CGRect rect = [composite getClientArea];
	NSArray *children = [self getUsealbeChildren:composite];
	int count = [children count];
	if (count == 0) return;
	int width = rect.size.width - self.marginLeft - self.marginRight;
	int height = rect.size.height - self.marginTop - self.marginBottom;
    CGRect areaRect;
    //调换坐标，通过调换，仅一种布局算法，即可支持水平垂直2中方向的布局
    if(self.type == CUSLayoutTypeHorizontal){
        areaRect = CGRectMake(rect.origin.x + self.marginLeft, rect.origin.y + self.marginTop, width, height);
    }else{
        areaRect = CGRectMake(rect.origin.y + self.marginTop,rect.origin.x + self.marginLeft ,height, width);
    }
    NSMutableArray *boudns = [self computeSizes:children clientAreaSize:areaRect];
    
    if(self.type != CUSLayoutTypeHorizontal){
        //x，y坐标调换，width，height调换
        for (int i = 0; i<[boudns count]; i++) {
            NSValue *value = [boudns objectAtIndex:i];
            CGRect rect = [value CGRectValue];
            NSInteger t = rect.origin.x;
            rect.origin.x = rect.origin.y;
            rect.origin.y = t;
            
            t = rect.size.width;
            rect.size.width = rect.size.height;
            rect.size.height = t;
            
            value = [NSValue valueWithCGRect:rect];
            [boudns replaceObjectAtIndex:i withObject:value];
        }
    }
    [self setControlsBounds:children bounds:boudns];
}


-(NSMutableArray *)computeSizes:(NSArray *)children clientAreaSize:(CGRect)areaRect{
    NSMutableArray *boudns = [NSMutableArray array];
    int count = [children count];
	NSInteger width = areaRect.size.width - (count - 1) * spacing;
    NSInteger fillControllCounter = 0;
    //计算unfill的大小
    for (int i=0; i<[children count]; i++) {
        UIView *child = [children objectAtIndex:i];
        if(![self isFillControl:child]){
            CGSize childSize = [self computeSize:child];
            CGRect rect = CGRectMake(0, 0, childSize.width, childSize.height);
            
            if(self.alignment == CUSLayoutAlignmentFill){
                rect.size.height = areaRect.size.height;
            }
            width -= childSize.width;
            NSValue *value = [NSValue valueWithCGRect:rect];
            [boudns addObject:value];
        }else{
            fillControllCounter++;
            CGSize childSize = [self computeSize:child];
            CGRect rect = CGRectMake(0, 0, childSize.width, childSize.height);
            if(self.alignment == CUSLayoutAlignmentFill){
                rect.size.height = areaRect.size.height;
            }
            NSValue *value = [NSValue valueWithCGRect:rect];
            [boudns addObject:value];
        }
    }
    if(fillControllCounter > 0){
        NSInteger perFillWidth = width/fillControllCounter;
        if(perFillWidth<0){
            perFillWidth = 0;
        }
        //计算fill的大小
        for (int i=0; i<[children count]; i++) {
            UIView *child = [children objectAtIndex:i];
            if([self isFillControl:child]){
                NSValue *value = [boudns objectAtIndex:i];
                CGRect rect = [value CGRectValue];
                rect.size.width = perFillWidth;
                value = [NSValue valueWithCGRect:rect];
                [boudns replaceObjectAtIndex:i withObject:value];
            }
        }
    }
    
    
    NSInteger startX = areaRect.origin.x;
    NSInteger startY = areaRect.origin.y;
    //重新计算location
    for (int i = 0; i<[boudns count]; i++) {
        NSValue *value = [boudns objectAtIndex:i];
        CGRect rect = [value CGRectValue];
        rect.origin.x = startX;
        startX += rect.size.width + spacing;

        if(self.alignment == CUSLayoutAlignmentLeft){
            rect.origin.y = startY;
        }else if(self.alignment == CUSLayoutAlignmentCenter){
            rect.origin.y = startY + (areaRect.size.height - rect.size.height)/2 ;
        }else if(self.alignment == CUSLayoutAlignmentRight){
            rect.origin.y = startY + (areaRect.size.height - rect.size.height) ;
        }else if(self.alignment == CUSLayoutAlignmentFill){
            rect.origin.y = startY;
        }
        
        value = [NSValue valueWithCGRect:rect];
        [boudns replaceObjectAtIndex:i withObject:value];
    }
    return boudns;
}

-(BOOL)isFillControl:(UIView *)control{
    if(!control){
        return NO;
    }
    CUSLinnerData *data = [self getLayoutDataByControll:control];
    if(data){
        if(data.fill){
            return YES;
        }
    }
    return NO;
}

-(CGSize)computeSize:(UIView *)control{
    int wHint = CUS_LAY_DEFAULT, hHint = CUS_LAY_DEFAULT;
    CGSize size = CGSizeMake(0, 0);
	CUSLinnerData *data = [self getLayoutDataByControll:control];
	if (data != nil) {
		wHint = data.width;
		hHint = data.height;
	}
    size = [control sizeThatFits:CGSizeMake(wHint, hHint)];
    if (data != nil) {
		if(data.width != CUS_LAY_DEFAULT){
            size.width = data.width;
        }
        if(data.height != CUS_LAY_DEFAULT){
            size.height = data.height;
        }
	}
    if(self.type != CUSLayoutTypeHorizontal){
        NSInteger t = size.width;
        size.width = size.height;
        size.height = t;
    }
    return size;
}
-(CUSLinnerData *)getLayoutDataByControll:(UIView *)control{
    CUSLayoutData *data = [control getLayoutData];
    if (data) {
        if([data isKindOfClass:[CUSLinnerData class]]){
            return (CUSLinnerData *)data;
        }
    }
    return nil;
}
-(void)setControlsBounds:(NSArray *)children bounds:(NSMutableArray *)bounds{
	for (int i = 0; i < [children count]; i++) {
		UIView * control = [children objectAtIndex:i];
        NSValue *listValue = [bounds objectAtIndex:i];
        CGRect rectangle = [listValue CGRectValue];
        control.frame = rectangle;
	}
};
@end
