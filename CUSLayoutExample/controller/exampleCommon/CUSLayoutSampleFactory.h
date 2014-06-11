//
//  CUSLayoutSampleFactory.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-24.
//
//
#import "CUSViewController.h"

@interface CUSLayoutSampleFactory : NSObject

+(UIView *)createControl;

+(UIView *)createControl:(NSString *)title;
+(UIColor *)randomLightingColor;
@end
