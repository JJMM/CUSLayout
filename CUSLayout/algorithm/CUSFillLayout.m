/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSFillLayout.h"

@implementation CUSFillLayout
@synthesize type;
@synthesize spacing;

- (id)init
{
    self = [super init];
    if (self) {
        [self setMargin:0];
        self.type = CUSLayoutTypeHorizontal;
        self.spacing = 5.0;
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
		NSInteger child_wHint = wHint, child_hHint = hHint;
		if (type == CUSLayoutTypeHorizontal && wHint != CUS_LAY_DEFAULT) {
			child_wHint = round(MAX(0,
                                              (wHint - (count - 1) * spacing - marginWidth * 2) / count));
		}
		if (type == CUSLayoutTypeVertical && hHint != CUS_LAY_DEFAULT) {
			child_hHint = round(MAX(0,
							(hHint - (count - 1) * spacing - marginHeight * 2)
                            / count));
		}
		CGFloat maxWidth = 0, maxHeight = 0;
		for (int i=0; i<count; i++) {
			UIView *child = [children objectAtIndex:i];
			CGSize size = [self computeChildSize:child wHint:wHint hHint:hHint];
			maxWidth = MAX(maxWidth, size.width);
			maxHeight = MAX(maxHeight, size.height);
		}
		CGFloat width = 0, height = 0;
		if (type == CUSLayoutTypeHorizontal) {
			width = count * maxWidth + (count - 1) * spacing + marginWidth * 2;
			height = maxHeight + marginHeight * 2;
		} else {
			width = maxWidth + marginWidth * 2;
			height = count * maxHeight + (count - 1) * spacing + marginHeight
            * 2;
		}
		if (wHint != CUS_LAY_DEFAULT) {
			width = wHint;
		}
		if (hHint != CUS_LAY_DEFAULT) {
			height = hHint;
		}
		return CGSizeMake(width, height);
	}
};
-(void)layout:(UIView *)composite{
    CGRect rect = [composite getClientArea];
	NSArray *children = [self getUsealbeChildren:composite];
	NSInteger count = [children count];
	if (count == 0) return;
	NSInteger width = rect.size.width - (self.marginLeft + self.marginRight);
	NSInteger height = rect.size.height - (self.marginTop + self.marginBottom);
	if (type == CUSLayoutTypeHorizontal) {
		width -= (count - 1) * spacing;
		NSInteger x = rect.origin.x + self.marginLeft, extra = width % count;
		NSInteger y = rect.origin.y + self.marginTop, cellWidth = width / count;
		for (int i=0; i<count; i++) {
			UIView *child = [children objectAtIndex:i];
			NSInteger childWidth = cellWidth;
			if (i == 0) {
				childWidth += extra / 2;
			} else {
				if (i == count - 1) childWidth += (extra + 1) / 2;
			}
            [self setControlFrame:child withFrame:CGRectMake(x, y, childWidth, height)];
			x += childWidth + spacing;
		}
	} else {
		height -= (count - 1) * spacing;
		NSInteger x = rect.origin.x + self.marginLeft, cellHeight = height / count;
		NSInteger y = rect.origin.y + self.marginTop, extra = height % count;
		for (int i=0; i<count; i++) {
			UIView *child = [children objectAtIndex:i];
			NSInteger childHeight = cellHeight;
			if (i == 0) {
				childHeight += extra / 2;
			} else {
				if (i == count - 1) childHeight += (extra + 1) / 2;
			}
            [self setControlFrame:child withFrame:CGRectMake(x, y, width, childHeight)];
			y += childHeight + spacing;
		}
	}
}

-(CGSize)computeChildSize:(UIView *)control wHint:(int)wHint hHint:(int)hHint{
    CGSize size = [control computeSize:CGSizeMake(wHint, hHint)];
    return size;
};
@end
