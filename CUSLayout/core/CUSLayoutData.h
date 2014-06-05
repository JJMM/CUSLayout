/**
 @header CUSLayoutData.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 @class CUSLayoutData
 @abstract
    The layou helper data.Use it with LayoutFrame.
    Precise control the subview in view.
 */
@interface CUSLayoutData : NSObject

//ignore  If YES - the parent view will ignore the subview.
@property (nonatomic,assign) BOOL exclude;//ignore
@end
