//
//  CUSStackLayout.m
//  CUSLayout
//
//  Created by zhangyu on 13-5-22.
//
//

#import "CUSStackLayout.h"

@implementation CUSStackLayout
@synthesize showViewIndex;

- (id)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.showViewIndex = index;
    }
    return self;
}
-(void)layout:(UIView *)composite{
    CGRect rect = [composite getClientArea];
	NSArray *children = [self getUsealbeChildren:composite];
	int count = [children count];
	if (count == 0) return;
    int x = self.marginLeft;
    int y = self.marginTop;
    int width = rect.size.width - (self.marginLeft + self.marginRight);
	int height = rect.size.height - (self.marginTop + self.marginBottom) * 2;
    
    if(showViewIndex < 0 || showViewIndex >= [children count]){
        return;
    }
    
    for (int i = 0; i < [children count];i++) {
        UIView *child = [children objectAtIndex:i];
        if(i == showViewIndex){
            child.frame = CGRectMake(x, y, width, height);
        }else{
            child.frame = CGRectMake(10000, 0, width, height);
        }
    }
}

@end
