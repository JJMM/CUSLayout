//
//  UIVIew+CUSLayout.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-9.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CUSLayoutFrame;
@class CUSLayoutData;
/*
 对UIView进行改造，以适应托管布局机制
 */
@interface UIView(UIView_CUSLayout){

}
//布局对象
@property (nonatomic,strong,getter = getLayoutFrame) CUSLayoutFrame *layoutFrame;
//布局数据对象
@property (nonatomic,strong,getter = getLayoutData) CUSLayoutData *layoutData;

//视图可用布局范围，默认和当前视图同等大小，对于有边框的控件，可以复写此方便，以排除边框等不放置子控件的位置，达到规整布局的目的
-(CGRect)getClientArea;

/*
 通常情况，布局由系统托管，无需主动触发，当有下情况须主动调用：
 1、当UIView已经渲染后，再设置布局对象
 2、布局对象和布局数据对象改变
 3、添加、删除控件后
*/
-(void)CUSLayout;
-(void)CUSLayout:(BOOL)animate;
-(void)CUSLayout:(BOOL)animate withDuration:(NSTimeInterval)duration;
@end
