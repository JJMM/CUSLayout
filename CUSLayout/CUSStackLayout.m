//
//  CUSStackLayout.m
//  CUSLayout
//
//  Created by zhangyu on 13-5-22.
//
//

#import "CUSStackLayout.h"

@implementation CUSStackLayout
@synthesize showViewIndex;

- (id)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.showViewIndex = index;
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
	int count = [children count];
	if (count == 0) {
		return CGSizeMake(wHint != CUS_LAY_DEFAULT ? wHint : 0,
                          hHint != CUS_LAY_DEFAULT ? hHint : 0);
	} else {
		CGFloat maxWidth = 0, maxHeight = 0;
		for (int i=0; i<count; i++) {
			UIView *child = [children objectAtIndex:i];
			CGSize size = [self computeChildSize:child wHint:wHint hHint:hHint];
			maxWidth = MAX(maxWidth, size.width);
			maxHeight = MAX(maxHeight, size.height);
		}
		CGFloat width = 0, height = 0;
        
		width = maxWidth + marginWidth;
        height = maxHeight + marginHeight;
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
	int count = [children count];
	if (count == 0) return;
    int x = self.marginLeft;
    int y = self.marginTop;
    int width = rect.size.width - (self.marginLeft + self.marginRight);
	int height = rect.size.height - (self.marginTop + self.marginBottom) * 2;
    
    if(showViewIndex < 0 || showViewIndex >= [children count]){
        return;
    }
    
    for (int i = 0; i < [children count];i++) {
        UIView *child = [children objectAtIndex:i];
        CGRect childFrame = child.frame;
        if(childFrame.origin.x != x || childFrame.origin.y != y || childFrame.size.width != width || childFrame.size.height != height){
            [self setControlFrame:child withFrame:CGRectMake(x, y, width, height)];
        }
        if(i == showViewIndex){
            child.alpha = 1;
        }else{
            child.alpha = 0;
        }
    }
}
-(CGSize)computeChildSize:(UIView *)control wHint:(int)wHint hHint:(int)hHint{
    CGSize size = [control computeSize:CGSizeMake(wHint, hHint)];
    return size;
};
@end
