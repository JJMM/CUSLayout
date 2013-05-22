//
//  CUSRealSingleton.m
//  CUSLayout
//
//  Created by zhangyu on 13-5-22.
//
//

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
