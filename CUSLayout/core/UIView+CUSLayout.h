/**
 @header UIVIew+CUSLayout.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import <UIKit/UIKit.h>
@class CUSLayoutFrame;
@class CUSLayoutData;

/**
 @class CUSGridData(Factory)
 @abstract
    add layoutFrame,layoutData.
 */
@interface UIView(UIView_CUSLayout){

}
@property (nonatomic,strong,getter = getLayoutFrame) CUSLayoutFrame *layoutFrame;
@property (nonatomic,strong,getter = getLayoutData) CUSLayoutData *layoutData;

/**
 @abstract 视图可用布局范围，默认和当前视图同等大小，对于有边框的控件，可以复写此方便，以排除边框等不放置子控件的位置，达到规整布局的目的
 @param margin
 */
-(CGRect)getClientArea;

/**
 @abstract 最佳大小,一般的控件和sizeThatFits相同，容器类控件，通过布局计算
 @param margin
 */
-(CGSize)computeSize:(CGSize)size;

/**
 @abstract 通常情况，布局由系统托管，无需主动触发，当有下情况须主动调用：
 1、当UIView已经渲染后，再设置布局对象
 2、布局对象和布局数据对象改变
 3、添加、删除控件后
*/
-(void)CUSLayout;
-(void)CUSLayout:(BOOL)animate;
-(void)CUSLayout:(BOOL)animate withDuration:(NSTimeInterval)duration;
@end

/**
 @class UIScrollView(UIScrollView_CUSLayout)
 @abstract
 */
@interface UIScrollView(UIScrollView_CUSLayout){
}
@end