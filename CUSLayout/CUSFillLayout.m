//
//  CUSFillLayout.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSFillLayout.h"

@implementation CUSFillLayout
@synthesize type;
@synthesize spacing;

- (id)init
{
    self = [super init];
    if (self) {
        type = CUSLayoutTypeHorizontal;
//        marginHeight = 0.0;
//        marginWidth = 0.0;
        spacing = 5.0;
    }
    return self;
}
-(void)layout:(UIView *)composite{
    CGRect rect = [composite getClientArea];
	NSArray *children = [self getUsealbeChildren:composite];
	int count = [children count];
	if (count == 0) return;
	int width = rect.size.width - (self.marginLeft + self.marginRight);
	int height = rect.size.height - (self.marginTop + self.marginBottom) * 2;
	if (type == CUSLayoutTypeHorizontal) {
		width -= (count - 1) * spacing;
		int x = rect.origin.x + self.marginLeft, extra = width % count;
		int y = rect.origin.y + self.marginTop, cellWidth = width / count;
		for (int i=0; i<count; i++) {
			UIView *child = [children objectAtIndex:i];
			int childWidth = cellWidth;
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
		int x = rect.origin.x + self.marginLeft, cellHeight = height / count;
		int y = rect.origin.y + self.marginTop, extra = height % count;
		for (int i=0; i<count; i++) {
			UIView *child = [children objectAtIndex:i];
			int childHeight = cellHeight;
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



@end
