/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSRowLayout.h"
#import "CUSRowData.h"
#import "CUSLayoutObject+Util.h"
@implementation CUSRowLayout
@synthesize type;
@synthesize spacing;
@synthesize wrap;
@synthesize fill;
@synthesize pack;
@synthesize justify;


- (id)init
{
    self = [super init];
    if (self) {
        [self setMargin:5];
        self.type = CUSLayoutTypeHorizontal;
        self.spacing = 5;
        self.wrap = YES;
        self.pack = YES;
        self.justify = NO;
    }
    return self;
}

-(void)layout:(UIView *)composite{
    BOOL flushCache = NO;
    CGRect rect = [self computeUseSize:composite flushCache:flushCache];
	NSArray *children = [self getUsealbeChildren:composite];
	NSMutableArray *bounds = [NSMutableArray array];
    // fill = true, no warp
	if (self.fill) {
		[self processFill:children bounds:bounds rect:rect flushCache:flushCache];
	} else {
		if (self.wrap) {
            [self processWrap:children bounds:bounds rect:rect flushCache:flushCache];
		} else {
            [self proessNormal:children bounds:bounds rect:rect flushCache:flushCache];
		}
	}
	[self setControlsBounds:children bounds:bounds];
}

-(CGSize)computeSize:(UIView *)composite wHint:(CGFloat)wHint hHint:(CGFloat)hHint{
	NSArray *children = [self getUsealbeChildren:composite];
	NSMutableArray *bounds = [NSMutableArray array];
    BOOL flushCache = NO;
    
	CGSize size;
	if (wHint != CUS_LAY_DEFAULT && hHint != CUS_LAY_DEFAULT) {
		size = CGSizeMake(wHint, hHint);
	} else {
		CGRect rect = CGRectMake(0, 0, wHint, hHint);
		if (wHint != CUS_LAY_DEFAULT) {
			rect.size.width -= self.marginLeft + self.marginRight;
		}
		if (hHint != CUS_LAY_DEFAULT) {
			rect.size.height -= self.marginTop + self.marginBottom;
		}
		if (self.fill) {
			size = [self processFill:children bounds:bounds rect:rect flushCache:flushCache];
		} else {
			if (self.wrap) {
                size = [self processWrap:children bounds:bounds rect:rect flushCache:flushCache];
			} else {
                size = [self proessNormal:children bounds:bounds rect:rect flushCache:flushCache];
			}
		}
		if (wHint == CUS_LAY_DEFAULT) {
			size.width += self.marginLeft + self.marginRight;
		}
		if (hHint == CUS_LAY_DEFAULT) {
			size.height += self.marginTop + self.marginBottom;
		}
	}
	return size;
};

 

-(BOOL)flushCache:(UIView *)control{
	return true;
};

 
-(CGRect)computeUseSize:(UIView *)composite flushCache:(BOOL)flushCache{
	CGRect clientArea = [composite getClientArea];
	clientArea.origin.x += self.marginLeft;
	clientArea.origin.y += self.marginTop;
	clientArea.size.width -= self.marginLeft + self.marginRight;
	clientArea.size.height -= self.marginTop + self.marginBottom;
	return clientArea;
};

-(CGSize)processFill:(NSArray *)children bounds:(NSMutableArray *)bounds rect:(CGRect)rect flushCache:(BOOL)flushCache{
	NSMutableArray *firstList = [NSMutableArray array];
    [bounds addObject:firstList];
	CGSize preferSize = CGSizeMake(0, 0);
    
	CGRect all = CGRectMake(rect.origin.x, rect.origin.y, 0, 0);
	CGSize packSize = [self getPackSize:children flushCache:flushCache];
	for (int i = 0; i < [children count]; i++) {
		UIView *control = [children objectAtIndex:i];
		CGPoint location = CGPointMake(all.origin.x, all.origin.y);
		CGSize size = [self computeSize2:control flushCache:flushCache packSize:packSize];
		if (self.type == CUSLayoutTypeHorizontal) {
			size.height = rect.size.height;
            [firstList addRect:CGRectMake(location.x, location.y, size.width,size.height)];
            [firstList addRect:CGRectMake(0,0,0,0)];

			all.origin.x += size.width + self.spacing;

			preferSize.width = MAX(preferSize.width, location.x + size.width);
			preferSize.height = MAX(preferSize.height, location.y + size.height);
		} else {
			size.width = rect.size.width;
            [firstList addRect:CGRectMake(location.x, location.y, size.width,size.height)];
			all.origin.y += size.height + self.spacing;
			preferSize.width = MAX(preferSize.width, location.x + size.width);
			preferSize.height = MAX(preferSize.height, location.y + size.height);
		}
	}
    [self processJustify:bounds rectAll:rect];
	return preferSize;
};

-(CGSize)processWrap:(NSArray *)children bounds:(NSMutableArray *)bounds rect:(CGRect)rect flushCache:(BOOL)flushCache{
    NSMutableArray *thisList = [NSMutableArray array];
    [bounds addObject:thisList];
	CGSize preferSize = CGSizeMake(0, 0);
    
	CGRect all = CGRectMake(rect.origin.x, rect.origin.y, 0, 0);
	CGSize packSize = [self getPackSize:children flushCache:flushCache];
	for (int i = 0; i < [children count]; i++) {
        UIView *control = [children objectAtIndex:i];
		CGPoint location = CGPointMake(all.origin.x, all.origin.y);
		CGSize size = [self computeSize2:control flushCache:flushCache packSize:packSize];
 
		if (self.type == CUSLayoutTypeHorizontal) {
			all.size.height = MAX(all.size.height, size.height);
	
			if (rect.size.width > 0 && location.x + size.width > rect.origin.x + rect.size.width) {
				all.origin.x = rect.origin.x;
				all.origin.y += all.size.height + self.spacing;
				location.x = all.origin.x;
				location.y = all.origin.y;
                
				thisList = [NSMutableArray array];
                [bounds addObject:thisList];
			}
            
            [thisList addRect:CGRectMake(location.x, location.y, size.width,size.height)];
        
			all.origin.x += size.width + self.spacing;
			preferSize.width = MAX(preferSize.width, location.x + size.width);
			preferSize.height = MAX(preferSize.height, location.y + size.height);
		} else {
			all.size.width = MAX(all.size.width, size.width);

			if (rect.size.height > 0 && location.y + size.height > rect.origin.y + rect.size.height) {
				all.origin.x += all.size.width + self.spacing;
				all.origin.y = rect.origin.y;
				location.x = all.origin.x;
				location.y = all.origin.y;
                
				thisList = [NSMutableArray array];
                [bounds addObject:thisList];
			}
            
            [thisList addRect:CGRectMake(location.x, location.y, size.width,size.height)];
 
			all.origin.y += size.height + self.spacing;
			preferSize.width = MAX(preferSize.width, location.x + size.width);
			preferSize.height = MAX(preferSize.height, location.y + size.height);
		}
	}
	[self processJustify:bounds rectAll:rect];
	return preferSize;
};

-(CGSize)proessNormal:(NSArray *)children bounds:(NSMutableArray *)bounds rect:(CGRect)rect flushCache:(BOOL)flushCache{
    NSMutableArray *firstList = [NSMutableArray array];
    [bounds addObject:firstList];
	CGSize preferSize = CGSizeMake(0, 0);
    
	CGRect all = CGRectMake(rect.origin.x, rect.origin.y, 0, 0);
	CGSize packSize = [self getPackSize:children flushCache:flushCache];

	for (int i = 0; i < [children count]; i++) {
		UIView *control = [children objectAtIndex:i];
		CGPoint location = CGPointMake(all.origin.x, all.origin.y);
		CGSize size = [self computeSize2:control flushCache:flushCache packSize:packSize];
        
        [firstList addRect:CGRectMake(location.x, location.y, size.width,size.height)];
		if (self.type == CUSLayoutTypeHorizontal) {
			all.origin.x += size.width;
			all.size.height = MAX(all.size.height, size.height);
			preferSize.width =MAX(preferSize.width, location.x + size.width);
			preferSize.height = MAX(preferSize.height, location.y + size.height);
			all.origin.x += self.spacing;
		} else {
			all.origin.y += size.height + self.spacing;
			all.size.width = MAX(all.size.width, size.width);
			preferSize.width = MAX(preferSize.width, location.x + size.width);
			preferSize.height = MAX(preferSize.height, location.y + size.height);
		}
	}
	if (self.justify && [children count]  > 0) {
		[self processJustify:bounds rectAll:rect];
	}
	return preferSize;
};
/**
 * get the size of view
 *
 * @param children
 * @param flushCache
 * @return
 */
-(CGSize)getPackSize:(NSArray *)children flushCache:(BOOL)flushCache{
	CGSize packSize = CGSizeMake(CUS_LAY_EMPTY, CUS_LAY_EMPTY);
	if (!self.pack) {
		packSize.width = 0;
        packSize.height = 0;
        for (int i = 0; i < [children count]; i++) {
            UIView *control = [children objectAtIndex:i];
            CGSize size = [self computeSize1:control flushCache:flushCache];
			packSize.width = MAX(packSize.width, size.width);
			packSize.height = MAX(packSize.height, size.height);
		}
	}
	return packSize;
};
/**
 * reset the size on justify
 *
 * @param bounds
 * @param rectAll
 */
-(void)processJustify:(NSMutableArray *)bounds rectAll:(CGRect)rectAll{
	if (!self.justify) {
		return;
	}
	if (!bounds || [bounds count] <= 0) {
		return;
	}
	for (int i = 0; i < [bounds count]; i++) {
		NSMutableArray *list = [bounds objectAtIndex:i];
        NSInteger listLength = [list count];
		if (listLength < 1) {
			continue;
		}
		NSInteger remain = 0;
        CGRect rectValue = [list CGRectAtIndex:listLength - 1];
		if (self.type == CUSLayoutTypeHorizontal) {
			remain = rectAll.size.width - (rectValue.origin.x + rectValue.size.width);
		} else {
			remain = rectAll.size.height - (rectValue.origin.y + rectValue.size.height);
		}
		if (remain > 1) {
			NSInteger spare = remain / (listLength + 1);
			NSInteger addNow = 0;
			for (int j = 0; j < listLength; j++) {
                CGRect rectangle = [list CGRectAtIndex:j];
                
				addNow += ceil(spare);
				if (addNow > remain) {
					break;
				}
				if (self.type == CUSLayoutTypeHorizontal) {
					rectangle.origin.x += addNow;
				} else {
					rectangle.origin.y += addNow;
				}
                [list replaceRectAtIndex:j withRect:rectangle];
			}
		}
	}
};

-(void)setControlsBounds:(NSArray *)children bounds:(NSMutableArray *)bounds{
	NSInteger index = 0;
	for (int i = 0; i < [bounds count]; i++) {
		NSMutableArray *list = [bounds objectAtIndex:i];
        NSInteger listLength = [list count];
		NSInteger max = 0;
		if (self.type == CUSLayoutTypeHorizontal) {
			for (int j = 0; j < listLength; j++) {
                CGRect rectangle = [list CGRectAtIndex:j];
				max = MAX(max, rectangle.size.height);
			}
			for (int j = 0; j < listLength; j++) {
                CGRect rectangle = [list CGRectAtIndex:j];
				UIView * control = [children objectAtIndex:index++];
                CUSRowData *data = [self getLayoutDataByControll:control];
                
				if (data != nil && data.alignment != CUSLayoutAlignmentLeft) {
					if (data.alignment == CUSLayoutAlignmentCenter) {
                        [self setControlFrame:control withFrame:CGRectMake(rectangle.origin.x, rectangle.origin.y + (max - rectangle.size.height) / 2,
                                                                           rectangle.size.width, rectangle.size.height)];
                    } else if (data.alignment == CUSLayoutAlignmentRight) {
                        [self setControlFrame:control withFrame:CGRectMake(rectangle.origin.x, rectangle.origin.y + max
                                                                           - rectangle.size.height, rectangle.size.width,
                                                                           rectangle.size.height)];
					} else if (data.alignment == CUSLayoutAlignmentFill) {
                        [self setControlFrame:control withFrame:CGRectMake(rectangle.origin.x, rectangle.origin.y,
                                                                           rectangle.size.width, max)];
					}
				} else {
                    [self setControlFrame:control withFrame:rectangle];
				}
			}
		} else if (self.type == CUSLayoutTypeVertical) {
            for (int j = 0; j < listLength; j++) {
                CGRect rectangle = [list CGRectAtIndex:j];
				max = MAX(max, rectangle.size.width);
			}
			for (int j = 0; j < listLength; j++) {
                CGRect rectangle = [list CGRectAtIndex:j];
				UIView * control = [children objectAtIndex:index++];
                CUSRowData *data = [self getLayoutDataByControll:control];
                
				if (data != nil && data.alignment != CUSLayoutAlignmentLeft) {
					if (data.alignment == CUSLayoutAlignmentCenter) {
                        [self setControlFrame:control withFrame:CGRectMake(rectangle.origin.x + (max - rectangle.size.width)
                                                                           / 2, rectangle.origin.y, rectangle.size.width,
                                                                           rectangle.size.height)];
                        
					} else if (data.alignment == CUSLayoutAlignmentRight) {
                        [self setControlFrame:control withFrame:CGRectMake(rectangle.origin.x + max - rectangle.size.width,
                                                                           rectangle.origin.y, rectangle.size.width, rectangle.size.height)];

					} else if (data.alignment == CUSLayoutAlignmentFill) {
                        [self setControlFrame:control withFrame:CGRectMake(rectangle.origin.x, rectangle.origin.y, max,
                                                                           rectangle.size.height)];
					}
				} else {
                    [self setControlFrame:control withFrame:rectangle];
				}
			}
		}
	}
};

-(CGSize)computeSize1:(UIView *)control flushCache:(BOOL)flushCache{
    int wHint = CUS_LAY_DEFAULT, hHint = CUS_LAY_DEFAULT;
    CGSize size = CGSizeMake(0, 0);
	CUSRowData *data = [self getLayoutDataByControll:control];
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

-(CUSRowData *)getLayoutDataByControll:(UIView *)control{
    CUSLayoutData *data = [control getLayoutData];
    if (data) {
        if([data isKindOfClass:[CUSRowData class]]){
            return (CUSRowData *)data;
        }
    }
    return nil;
}

-(CGSize)computeSize2:(UIView *)control flushCache:(BOOL)flushCache packSize:(CGSize)packSize{
    if(packSize.width == CUS_LAY_EMPTY &&packSize.height == CUS_LAY_EMPTY){
        return [self computeSize1:control flushCache:flushCache];
    }else{
        return CGSizeMake(packSize.width, packSize.height);
    }
};

@end
