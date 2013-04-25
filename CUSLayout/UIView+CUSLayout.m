//
//  UIVIew+CUSLayout.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "UIView+CUSLayout.h"
#import <objc/runtime.h>
#import "CUSLayoutFrame.h"

static NSString *UIView_CUSLayoutFrame;
static NSString *UIView_CUSLayoutData;
static BOOL UIView_CUSLayout_loaded;

@implementation UIView(UIView_CUSLayout)
@dynamic layoutFrame;
@dynamic layoutData;

//#pragma CUSLayout working mechanism
//CUSLayout 工作机制：通过当前View大小变化触发layoutSubviews方法，layoutSubviews中调用布局算法
//重新设置所有子控件Frame，当子控件大小发生变化时，循环触发此机制，达到递归调用布局算法的目的.

-(void)layoutSubviewsExt{
    CUSLayoutFrame *layoutFrame = [self getLayoutFrame];
    if(layoutFrame){
        [layoutFrame layout:self];
    }
    //此方法已和layoutSubviews方法互换，并非调用自身，实际上是调用[super layoutSubviews]，所以不会引起死循环
    [self layoutSubviewsExt];
}

#pragma implement API
-(CGRect)getClientArea{
    return self.bounds;
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
    [self layoutSubviews];
}

-(void)CUSLayout:(BOOL)animate{
    [self CUSLayout:animate withDuration:0.5];
}

-(void)CUSLayout:(BOOL)animate withDuration:(NSTimeInterval)duration{
    if(animate){
        [UIView animateWithDuration:duration animations:^{
            [self CUSLayout];
        }];
    }else{
        [self CUSLayout];
    }
}
//IOS6中autoresizesSubviews的View必须调用UIView中的layoutSubviews，而Catogory覆盖的方法不能调用super中的方法
//因此将布局递归机制通过交换方法实现
+ (void) load
{
    if(!UIView_CUSLayout_loaded){
        UIView_CUSLayout_loaded = YES;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(layoutSubviewsExt)), class_getInstanceMethod([self class], @selector(layoutSubviews)));
        });
    }
    
}


@end
