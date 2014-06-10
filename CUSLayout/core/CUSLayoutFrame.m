/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLayoutFrame.h"
#import "CUSLayoutData.h"
#import "CUSLayoutConstant.h"


@implementation CUSLayoutFrame
@synthesize marginLeft;
@synthesize marginTop;
@synthesize marginRight;
@synthesize marginBottom;

-(void)setMargin:(CGFloat)margin{
    [self setMarginWidth:margin];
    [self setMarginHeight:margin];
}

-(void)setMarginWidth:(CGFloat)margin{
    self.marginLeft = self.marginRight = margin;
}

-(void)setMarginHeight:(CGFloat)margin{
    self.marginTop = self.marginBottom = margin;
}

-(NSArray *)getUsealbeChildren:(UIView *)view{
    NSMutableArray * array = [NSMutableArray array];
    if(!view){
        return array;
    }
    
    for (UIView *subView in view.subviews) {
        //ScrollView has two default UIImageView scroller
        if ([view isKindOfClass:[UIScrollView class]]) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                UIImage *image = ((UIImageView *)subView).image;
                if ([image isKindOfClass:NSClassFromString(@"_UIResizableImage")]) {
                    if (image.size.width == 3.5 || image.size.height == 3.5) {
                        continue;
                    }
                }
            }
        }
        
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
