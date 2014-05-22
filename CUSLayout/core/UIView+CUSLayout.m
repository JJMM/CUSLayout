/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "UIView+CUSLayout.h"
#import <objc/runtime.h>
#import "CUSLayoutFrame.h"
#import "CUSLayoutConstant.h"
static NSString *UIView_CUSLayoutFrame;
static NSString *UIView_CUSLayoutData;
static NSString *UIView_ChildFrameChanged;

@implementation UIView(UIView_CUSLayout)
@dynamic layoutFrame;
@dynamic layoutData;

//#pragma CUSLayout working mechanism
//CUSLayout 工作机制：通过当前View大小变化触发layoutSubviews方法，layoutSubviews中调用布局算法
//重新设置所有子控件Frame，当子控件大小发生变化时，循环触发此机制，达到递归调用布局算法的目的.

-(void)layoutSubviewsExt{
    CUSLayoutFrame *layoutFrame = [self getLayoutFrame];
    if(layoutFrame){
        NSNumber * ChildFrameChanged = objc_getAssociatedObject(self, &UIView_ChildFrameChanged);
        
        if(ChildFrameChanged == nil){
            [layoutFrame layout:self];
        }else{
            if([ChildFrameChanged boolValue]){
                [self clearChildFrameChanged];
            }else{
                [layoutFrame layout:self];
            }
        }
    }
    //此方法已和layoutSubviews方法互换，并非调用自身，实际上是调用[super layoutSubviews]，所以不会引起死循环
    [self layoutSubviewsExt];
}

-(void)clearChildFrameChanged{
    objc_setAssociatedObject(self, &UIView_ChildFrameChanged,
                             nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)setFrameExt:(CGRect)frame{
//    if(self.superview){
//        objc_setAssociatedObject(self.superview, &UIView_ChildFrameChanged,
//                                 [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
    [self setFrameExt:frame];
    
}

#pragma implement API
-(CGRect)getClientArea{
    return self.bounds;
}
-(CGSize)computeSize:(CGSize)size{
    if (size.width != CUS_LAY_DEFAULT && size.height != CUS_LAY_DEFAULT) {
		return size;
	}
    CGSize s = CGSizeMake(size.width, size.height);
    if(self.layoutFrame == nil){
        s = [self sizeThatFits:size];
    }else{
        s = [self.layoutFrame computeSize:self wHint:size.width hHint:size.height];
    }
    
    if (s.width <= 0 || s.height <= 0) {
        CGFloat maxWidth = s.width;
        CGFloat maxHeight = s.height;
        for (UIView *subView in self.subviews) {
            maxWidth = MAX(maxWidth, subView.frame.origin.x + subView.frame.size.width);
            maxHeight = MAX(maxHeight, subView.frame.origin.y + subView.frame.size.height);
        }
        s = CGSizeMake(maxWidth, maxHeight);
    }
    
    if(size.width != CUS_LAY_DEFAULT){
        s.width = size.width;
    }
    if(size.height != CUS_LAY_DEFAULT){
        s.height = size.height;
    }
    return s;
}
-(void)setLayoutFrame:(CUSLayoutFrame *)layoutFrame{
    objc_setAssociatedObject(self, &UIView_CUSLayoutFrame,
                             layoutFrame, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(CUSLayoutFrame *)getLayoutFrame{
    CUSLayoutFrame * layoutFrame = objc_getAssociatedObject(self, &UIView_CUSLayoutFrame);
    return layoutFrame;
}

-(void)setLayoutData:(CUSLayoutData *)layoutData{
    objc_setAssociatedObject(self, &UIView_CUSLayoutData,
                             layoutData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CUSLayoutData *)getLayoutData{
    CUSLayoutData * layoutData = objc_getAssociatedObject(self, &UIView_CUSLayoutData);
    return layoutData;
}

-(void)CUSLayout{
    [self clearChildFrameChanged];
    [self layoutSubviews];
}

-(void)CUSLayout:(BOOL)animate{
    [self CUSLayout:animate withDuration:0.5];
}

-(void)CUSLayout:(BOOL)animate withDuration:(NSTimeInterval)duration{
    [self CUSLayout:animate withDuration:duration completion:nil];
}

-(void)CUSLayout:(BOOL)animate withDuration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion {
    if(animate){
        [UIView animateWithDuration:duration animations:^{
            [self CUSLayout];
        } completion:completion];
    }else{
        [self CUSLayout];
        if (completion) {
            completion(YES);
        }
    }
}
//IOS6中autoresizesSubviews的View必须调用UIView中的layoutSubviews，而Catogory覆盖的方法不能调用super中的方法
//因此将布局递归机制通过交换方法实现
+ (void) load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(layoutSubviewsExt)), class_getInstanceMethod([self class], @selector(layoutSubviews)));
        method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(setFrameExt:)), class_getInstanceMethod([self class], @selector(setFrame:)));
    });
}
@end


@implementation UIScrollView(UIScrollView_CUSLayout)
-(CGRect)getClientArea{
    if(self.contentSize.width == 0 && self.contentSize.height == 0){
        return self.bounds;
    }else{
        return CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    }
}
@end
