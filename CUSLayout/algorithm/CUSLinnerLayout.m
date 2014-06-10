/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

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
        [self setMargin:5];
        self.type = CUSLayoutTypeVertical;
        self.alignment = CUSLayoutAlignmentFill;
        self.spacing = 5;
    }
    return self;
}

-(CGSize)computeSize:(UIView *)composite wHint:(CGFloat)wHint hHint:(CGFloat)hHint{
	CGFloat marginWidth = self.marginLeft + self.marginRight;
	CGFloat marginHeight = self.marginTop + self.marginBottom;
    
	if (wHint != CUS_LAY_DEFAULT && hHint != CUS_LAY_DEFAULT) {
		return CGSizeMake(wHint, hHint);
	}
	NSArray *children = [self getUsealbeChildren:composite];
	NSInteger count = [children count];
	if (count == 0) {
		return CGSizeMake(wHint != CUS_LAY_DEFAULT ? wHint : 0,
                          hHint != CUS_LAY_DEFAULT ? hHint : 0);
	} else {
		CGFloat width = 0, height = 0;
		for (int i=0; i<count; i++) {
			UIView *child = [children objectAtIndex:i];
			CGSize size = [self computeChildSize:child wHint:CUS_LAY_DEFAULT hHint:CUS_LAY_DEFAULT];
            width += size.width;
            height += size.height;
            
            if (i != 0) {
                if (type == CUSLayoutTypeHorizontal) {
                    width +=spacing;
                }else{
                    height +=spacing;
                }
            }
		}
		
		if (wHint != CUS_LAY_DEFAULT) {
			width = wHint;
		}
		if (hHint != CUS_LAY_DEFAULT) {
			height = hHint;
		}
        width += marginWidth;
        height += marginHeight;
		return CGSizeMake(width, height);
	}
};

-(void)layout:(UIView *)composite{
    CGRect rect = [composite getClientArea];
	NSArray *children = [self getUsealbeChildren:composite];
	NSInteger count = [children count];
	if (count == 0) return;
	NSInteger width = rect.size.width - self.marginLeft - self.marginRight;
	NSInteger height = rect.size.height - self.marginTop - self.marginBottom;
    CGRect areaRect;
    //Replace the coordinates, through the exchange, only a layout algorithm, can support for horizontal and vertical direction in the layout
    if(self.type == CUSLayoutTypeHorizontal){
        areaRect = CGRectMake(rect.origin.x + self.marginLeft, rect.origin.y + self.marginTop, width, height);
    }else{
        areaRect = CGRectMake(rect.origin.y + self.marginTop,rect.origin.x + self.marginLeft ,height, width);
    }
    NSMutableArray *boudns = [self computeSizes:children clientAreaSize:areaRect];
    
    if(self.type != CUSLayoutTypeHorizontal){
        //Replacex,y.   width,height
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
    NSInteger count = [children count];
	NSInteger width = areaRect.size.width - (count - 1) * spacing;
    NSInteger fillControllCounter = 0;
    //compute unfill size
    for (int i=0; i<[children count]; i++) {
        UIView *child = [children objectAtIndex:i];
        if(![self isFillControl:child]){
            CGSize childSize = [self computeChildSizeWithDirection:child wHint:-1 hHint:-1];
            CGRect rect = CGRectMake(0, 0, childSize.width, childSize.height);
            
            if(self.alignment == CUSLayoutAlignmentFill){
                rect.size.height = areaRect.size.height;
            }
            width -= childSize.width;
            NSValue *value = [NSValue valueWithCGRect:rect];
            [boudns addObject:value];
        }else{
            fillControllCounter++;
            CGSize childSize = [self computeChildSizeWithDirection:child wHint:-1 hHint:-1];
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
        //compute fill
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
    //recompute location
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

-(CGSize)computeChildSizeWithDirection:(UIView *)control wHint:(CGFloat)wHint hHint:(CGFloat)hHint{
    CGSize size = [self computeChildSize:control wHint:wHint hHint:hHint];
    if(self.type != CUSLayoutTypeHorizontal){
        NSInteger t = size.width;
        size.width = size.height;
        size.height = t;
    }
    return size;
}

-(CGSize)computeChildSize:(UIView *)control wHint:(CGFloat)wHint hHint:(CGFloat)hHint{
    CGSize size = CGSizeMake(0, 0);
	CUSLinnerData *data = [self getLayoutDataByControll:control];
	if (data != nil) {
		wHint = data.width;
		hHint = data.height;
	}
    size = [control computeSize:CGSizeMake(wHint, hHint)];
    if (data != nil) {
		if(data.width != CUS_LAY_DEFAULT){
            size.width = data.width;
        }
        if(data.height != CUS_LAY_DEFAULT){
            size.height = data.height;
        }
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
        [self setControlFrame:control withFrame:rectangle];
	}
};
@end
