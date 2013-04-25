//
//  CUSLayoutSampleFactory.h
//  CUSLayout
//
//  Created by zhangyu on 13-4-24.
//
//

@interface CUSLayoutSampleFactory : NSObject

+(UILabel *)createControl;

+(UILabel *)createControl:(NSString *)title;
+(UIColor *)randomLightingColor;
@end
