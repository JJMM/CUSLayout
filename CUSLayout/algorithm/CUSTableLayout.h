/**
 @header CUSTableLayout.h
 @abstract
 @code
 
 @link
 https://github.com/JJMM/CUSLayout
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSLayoutFrame.h"
#import "CUSLayoutConstant.h"

/**
 @class CUSTableLayout
 @abstract
 表格布局：类似HTML中使用Table标签控制布局
 该布局功能强大，效率较低，适当控制该布局使用频率
 */
@interface CUSTableLayout : CUSLayoutFrame
@property (nonatomic,assign) BOOL pixelFirst;

//子控件间距
@property (nonatomic,assign) CGFloat spacing;

//构造方法，其中参数数组columnWiths、rowHeights中的对象必须是CUSValue类型
- (id)initWithcolumns:(NSArray *)columnWiths rows:(NSArray *)rowHeights;

/**
 * 合并单元格
 *
 * @param column
 *            列序号
 * @param row
 *            行序号
 * @param colspan
 *            列数
 * @param rowspan
 *            行数
 */
-(void) merge:(NSInteger)column row:(NSInteger)row colspan:(NSInteger) colspan rowspan:(NSInteger) rowspan;

/**
 * 拆分单元格
 *
 * @param column
 *            列序号
 * @param row
 *            行序号
 */
-(void)unmerge:(NSInteger)column row:(NSInteger)row;

//取得列数
-(NSInteger)getColumnCount;
//取得行数
-(NSInteger)getRowCount;

@end
