//
//  CUSGridData.m
//  CUSLayout
//
//  Created by zhangyu on 13-7-17.
//
//

#import "CUSGridData.h"
#import "UIView+CUSLayout.h"
#import <Availability.h>
@implementation CUSGridData{
    int defaultWhint, defaultHhint, defaultWidth, defaultHeight;
    int currentWhint, currentHhint, currentWidth, currentHeight;
    
}
@synthesize verticalAlignment;
@synthesize horizontalAlignment;
@synthesize horizontalIndent;
@synthesize verticalIndent;
@synthesize horizontalSpan;
@synthesize verticalSpan;
@synthesize widthHint;
@synthesize heightHint;
@synthesize grabExcessHorizontalSpace;
@synthesize grabExcessVerticalSpace;
@synthesize minimumWidth;
@synthesize minimumHeight;

@synthesize cacheWidth;
@synthesize cacheHeight;
- (id)init
{
    self = [super init];
    if (self) {
        self.horizontalAlignment = CUSLayoutAlignmentFill;
        self.verticalAlignment = CUSLayoutAlignmentFill;
        self.horizontalIndent = 0;
        self.verticalIndent = 0;
        self.horizontalSpan = 1;
        self.verticalSpan = 1;
        self.widthHint = CUS_LAY_DEFAULT;
        self.heightHint = CUS_LAY_DEFAULT;
        
        self.grabExcessHorizontalSpace = NO;
        self.grabExcessVerticalSpace = NO;
        self.minimumWidth = 0;
        self.minimumHeight = 0;
        
        self.cacheWidth = -1;
        self.cacheHeight = -1;
    }
    return self;
}
-(void) computeSize:(UIView *)control wHint:(int)wHint hHint:(int)hHint flushCache:(BOOL)flushCache {
	if (cacheWidth != -1 && cacheHeight != -1) return;
	if (wHint == self.widthHint && hHint == self.heightHint) {
		if (defaultWidth == -1 || defaultHeight == -1 || wHint != defaultWhint || hHint != defaultHhint) {
			CGSize size = [control computeSize:CGSizeMake(wHint, hHint)];
			defaultWhint = wHint;
			defaultHhint = hHint;
			defaultWidth = size.width;
			defaultHeight = size.height;
		}
		cacheWidth = defaultWidth;
		cacheHeight = defaultHeight;
		return;
	}
	if (currentWidth == -1 || currentHeight == -1 || wHint != currentWhint || hHint != currentHhint) {
		CGSize size = [control computeSize:CGSizeMake(wHint, hHint)];
		currentWhint = wHint;
		currentHhint = hHint;
		currentWidth = size.width;
		currentHeight = size.height;
	}
	cacheWidth = currentWidth;
	cacheHeight = currentHeight;
}
-(void) flushCache{
	cacheWidth = cacheHeight = -1;
}


@end

@implementation CUSGridData(Factory)
+(CUSGridData *)createWithWidth:(CGFloat)width withHeight:(CGFloat)height{
    CUSGridData *data = [[CUSGridData alloc]init];
    data.widthHint = width;
    data.heightHint = height;
    return data;
}
+(CUSGridData *)createGrab{
    CUSGridData *data = [[CUSGridData alloc]init];
    data.grabExcessHorizontalSpace = YES;
    data.grabExcessVerticalSpace = YES;
    return data;
}
@end