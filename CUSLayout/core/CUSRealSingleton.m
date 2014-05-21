/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSRealSingleton.h"
static CUSRealSingleton* CUSRealSingletonInstance;
@implementation CUSRealSingleton
@synthesize sValue;

+(CUSRealSingleton *)shareInstance{
    if(CUSRealSingletonInstance == nil){
        CUSRealSingletonInstance = [[CUSRealSingleton alloc]init];
    }
    return CUSRealSingletonInstance;
}
@end
