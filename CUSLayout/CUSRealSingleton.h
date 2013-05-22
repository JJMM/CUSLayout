//
//  CUSRealSingleton.h
//  CUSLayout
//
//  Created by zhangyu on 13-5-22.
//
//

#import <Foundation/Foundation.h>

@interface CUSRealSingleton : NSObject
@property (atomic,assign) BOOL sValue;
+(CUSRealSingleton*)shareInstance;
@end
