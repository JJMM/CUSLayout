//
//  CUSGridLayout.h
//  CUSLayout
//
//  Created by zhangyu on 13-7-17.
//
//

#import "CUSLayoutFrame.h"

@interface CUSGridLayout : CUSLayoutFrame
@property (nonatomic,assign) NSInteger numColumns;
@property (nonatomic,assign) BOOL makeColumnsEqualWidth;
@property (nonatomic,assign) CGFloat horizontalSpacing;
@property (nonatomic,assign) CGFloat verticalSpacing;

- (id)initWithNumColumns:(NSInteger)numColumns;
@end
