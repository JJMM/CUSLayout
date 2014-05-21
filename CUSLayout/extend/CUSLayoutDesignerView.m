/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLayoutDesignerView.h"

@implementation CUSLayoutDesignerView{
    UIView *pickedView;
    CGRect pickedViewFrame;
    CGPoint beganPoint;
    BOOL picked;
    UIView *placedView;
}
@synthesize dragAndDropEnable;
@synthesize dragScale;
- (id)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}


-(void)initView{
    self.dragAndDropEnable = YES;
    self.dragScale = 1.1;
    UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognizerHandle:)];
    [self addGestureRecognizer:gestureRecognizer];
}

-(void)dragBegan:(CGPoint)touchPoint{
    placedView = [[UIView alloc]init];
    placedView.alpha = 0;
    placedView.frame = pickedView.frame;
    [self addSubview:placedView];
    
    [self exchangeSubviewAtObject:placedView withSubview:pickedView];
    
    placedView.layoutData = pickedView.layoutData;
    
    CUSLayoutData *layoutData = [[CUSLayoutData alloc]init];
    layoutData.exclude = YES;
    pickedView.layoutData = layoutData;
    
    CGRect pickedFrame = [self getScaleRect:pickedView.frame withScale:self.dragScale];
    [UIView animateWithDuration:0.5 animations:^{
        pickedView.frame = pickedFrame;
    }];
    pickedViewFrame = pickedFrame;
}

-(void)dragChanged:(CGPoint)touchPoint{
    UIView *upperView = [self getUpperViewByPoint:touchPoint exceptView:pickedView];
    if(upperView!=nil && upperView != pickedView && upperView != placedView){
        
        [self exchangeSubviewAtObject:placedView withSubview:upperView];
        
        [self CUSLayout:YES];
        CGRect pickedFrame = [self getScaleRect:placedView.frame withScale:self.dragScale];
        [UIView animateWithDuration:0.5 animations:^{
            pickedView.frame = CGRectMake(pickedView.frame.origin.x, pickedView.frame.origin.y, pickedFrame.size.width, pickedFrame.size.height);
            pickedViewFrame.size.width = pickedFrame.size.width;
            pickedViewFrame.size.height = pickedFrame.size.height;
        }];
    }else{
        CGFloat x = pickedViewFrame.origin.x + (touchPoint.x - beganPoint.x);
        CGFloat y = pickedViewFrame.origin.y + (touchPoint.y - beganPoint.y);
        CGFloat width = pickedView.frame.size.width;
        CGFloat height = pickedView.frame.size.height;
        CGRect viewFrame = CGRectMake(x, y, width, height);
        [UIView animateWithDuration:0.5 animations:^{
            pickedView.frame = viewFrame;
        }];
    }
}

-(void)dragEnd{
    if(placedView){
        [self exchangeSubviewAtObject:placedView withSubview:pickedView];
        pickedView.layoutData = placedView.layoutData;
        
        [placedView removeFromSuperview];
        placedView = nil;
    }
    pickedView = nil;
    
    [self CUSLayout:YES];
}
-(void)longPressGestureRecognizerHandle:(UILongPressGestureRecognizer *)gestureRecognizer{
    CGPoint touchPoint = [gestureRecognizer locationInView:self];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if (!dragAndDropEnable) {
            return;
        }
        if(picked){
            return;
        }
        CGPoint touchPoint = [gestureRecognizer locationInView:self];
        UIView *pView = [self getViewByPoint:touchPoint];
        if (pView == nil) {
            return;
        }
        picked = YES;
        beganPoint = touchPoint;
        pickedView = pView;
        pickedViewFrame = pView.frame;
        
        [self dragBegan:touchPoint];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (picked) {
            [self dragChanged:touchPoint];
            
        }
    }
    else {
        if(!picked){
            return;
        }
        picked = NO;
        
        [self dragEnd];
    }
}

- (void)exchangeSubviewAtObject:(UIView *)view1 withSubview:(UIView *)view2{
    NSInteger index1 = [self.subviews indexOfObject:view1];
    NSInteger index2 = [self.subviews indexOfObject:view2];
    
    [self exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
}

-(CGRect)getScaleRect:(CGRect)frame withScale:(CGFloat)scale{
    CGFloat width = frame.size.width * scale;
    CGFloat height = frame.size.height * scale;
    CGFloat x = frame.origin.x + (frame.size.width - width)/2.0;
    CGFloat y = frame.origin.y + (frame.size.height - height)/2.0;
    return CGRectMake(x, y, width, height);
}
-(UIView *)getViewByPoint:(CGPoint)point{
    for (UIView *subView in self.subviews) {
         if ([self RectContainsPoint:subView.frame withCGPoint:point]) {
            return subView;
        }
    }
    return nil;
}

-(UIView *)getUpperViewByPoint:(CGPoint)point exceptView:(UIView *)exView{
    for (UIView *subView in self.subviews) {
        if (subView == exView) {
            continue;
        }
        CGRect upperFrame = subView.frame;
        upperFrame.origin.x += upperFrame.size.width/6.0;
        upperFrame.origin.y += upperFrame.size.height/6.0;
        
        upperFrame.size.width -= upperFrame.size.width/3.0;
        upperFrame.size.height -= upperFrame.size.height/3.0;
        
        if ([self RectContainsPoint:upperFrame withCGPoint:point]) {
            return subView;
        }
    }
    return nil;
}


//Don't need to import CoreGraphics Lib
//simple to bool CGRectContainsPoint(CGRect rect, CGPoint point)
-(BOOL)RectContainsPoint:(CGRect) rect withCGPoint:(CGPoint) point{
    if(point.x < rect.origin.x){
        return NO;
    }
    
    if(point.x > rect.origin.x + rect.size.width){
        return NO;
    }
    
    if(point.y < rect.origin.y){
        return NO;
    }
    
    if(point.y > rect.origin.y + rect.size.height){
        return NO;
    }
    
    return YES;
}
@end
