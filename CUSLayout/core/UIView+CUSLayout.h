/**
 @header UIVIew+CUSLayout.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import <Foundation/Foundation.h>
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
 @abstract get useable layout size from view.It is used to remove the border.
 @param margin
 */
-(CGRect)getClientArea;

/**
 @abstract compte the best size by the UIView and subViews.Sometimes,it's equal to sizeThatFits.Container view compute by layoutframe.
 @param margin
 */
-(CGSize)computeSize:(CGSize)size;

/**
 @abstract Do not need to call the method.except：
 1.view has rendered,then change the value of layoutFrame or layoutData
 2.add or remove view from parentView
*/
-(void)CUSLayout;

/**
 @abstract Do not need to call the method.
 @param animate
 */
-(void)CUSLayout:(BOOL)animate;

/**
 @abstract Do not need to call the method.
 @param animate
 @param duration default value is 0.5s
 */
-(void)CUSLayout:(BOOL)animate withDuration:(NSTimeInterval)duration;
@end


/**
 @class UIScrollView(UIScrollView_CUSLayout)
 @abstract compute clientArea size by contentSize
 */
@interface UIScrollView(UIScrollView_CUSLayout){
}
@end