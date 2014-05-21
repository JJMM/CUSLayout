/**
 @header CUSRealSingleton.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 @class CUSRealSingleton
 @abstract
 */
@interface CUSRealSingleton : NSObject
@property (atomic,assign) BOOL sValue;
+(CUSRealSingleton*)shareInstance;
@end
