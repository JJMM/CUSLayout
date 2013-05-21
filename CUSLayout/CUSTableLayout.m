//
//  CUSTableLayout.m
//  CUSLayout
//
//  Created by zhangyu on 13-4-10.
//  Copyright (c) 2013年 zhangyu. All rights reserved.
//

#import "CUSTableLayout.h"
#import "CUSTableData.h"
#import "CUSLayoutObject+Util.h"
#define DEFAULT -1
#define PERCENT 0
#define INTEGER 1
#define BEST 2

@class TableCellInfo;
@interface TableCellInfo : NSObject
@property (nonatomic,assign) NSInteger column;// 列号
@property (nonatomic,assign) NSInteger row;// 行号
@property (nonatomic,assign) NSInteger columnSpan;// 合并列
@property (nonatomic,assign) NSInteger rowSpan;// 合并行
@property (nonatomic,strong) TableCellInfo *parent;// 所在的合并单元格： 如果为null，则为实际的单元格，否则为被合并单元格，不能实际使用
@property (nonatomic,assign) BOOL isSpan;// 是否合并
@property (nonatomic,assign) BOOL ignore;// 是否忽略

- (id)initWithColumn:(NSInteger)column column:(NSInteger)row;
@end;


@implementation TableCellInfo
@synthesize column;
@synthesize row;
@synthesize columnSpan;
@synthesize rowSpan;

@synthesize parent;
@synthesize isSpan;
@synthesize ignore;

#pragma API
- (id)init
{
    self = [super init];
    if (self) {
        column = 0;
        row = 0;
        columnSpan = 1;
        rowSpan = 1;
        parent = nil;
        isSpan = NO;
        ignore = NO;
    }
    return self;
}
/**
 * 表格单元格构造方法
 */
- (id)initWithColumn:(NSInteger)column_ column:(NSInteger)row_{
    self = [self init];
    if (self) {
        self.column = column_;
        self.row = row_;
    }
    return self;
}

-(NSString *)description{
    NSMutableString *des = [NSMutableString stringWithFormat:@"TableCellInfo:"];
    [des appendString:[NSString stringWithFormat:@"column:%i row:%i ",column ,row]];
    [des appendString:[NSString stringWithFormat:@"columnSpan:%i rowSpan:%i ",columnSpan ,rowSpan]];
    [des appendString:[NSString stringWithFormat:@"isSpan:%@ ignore:%@ ",isSpan?@"YES":@"NO" ,ignore?@"YES":@"NO"]];
    
    return des;
}

@end;

static CUSTableData *CUSTableDataInstance;
@interface CUSTableLayout ()
@property (nonatomic,strong) NSArray * columnWidths;
@property (nonatomic,strong) NSArray * rowHeights;
@property (nonatomic,strong) NSMutableArray * cellInfos;
@property (nonatomic,strong) NSMutableArray * realColumnWidths;
@property (nonatomic,strong) NSMutableArray * realRowHeights;

@end
@implementation CUSTableLayout
@synthesize pixelFirst;
@synthesize spacing;
@synthesize marginLeft;
@synthesize marginTop;
@synthesize marginRight;
@synthesize marginBottom;

@synthesize columnWidths;
@synthesize rowHeights;
@synthesize cellInfos;

@synthesize realColumnWidths;
@synthesize realRowHeights;
- (id)init
{
    self = [super init];
    if (self) {
        spacing = 5;
        marginLeft = 5;
        marginTop = 5;
        marginRight = 5;
        marginBottom = 5;
    }
    return self;
}

- (id)initWithcolumns:(NSArray *)columnWiths_ rows:(NSArray *)rowHeights_{
    self = [self init];
    if (self) {
        self.columnWidths = columnWiths_;
        self.rowHeights = rowHeights_;
        
        [self checkArrayAvailable:self.columnWidths];
        [self checkArrayAvailable:self.rowHeights];
        self.cellInfos = [NSMutableArray array];
        
		for (int i = 0; i < [self getRowCount]; i++) {
            NSMutableArray *rowArray = [NSMutableArray array];
			for (int j = 0; j < [self getColumnCount]; j++) {
                TableCellInfo *cell = [[TableCellInfo alloc]initWithColumn:j column:i];
                [rowArray addObject:cell];
			}
            [self.cellInfos addObject:rowArray];
		}
    }
    return self;
}

-(void)showError:(NSString *)message{
    NSLog(@"CUSTableLayout Exception:%@", message);
}

-(void)checkArrayAvailable:(NSArray *)array{
    if(!array){
        [self showError:@"数组不能为空"];
    }
    for (int i = 0; i < [array count]; i++) {
        id obj = [array objectAtIndex:i];
        if(![obj isKindOfClass:[CUSValue class]]){
            [self showError:[NSString stringWithFormat:@"数组中第[%i]个参数不是CUSValue类型",i]];
        }
    }
}

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
-(void) merge:(NSInteger)column row:(NSInteger)row colspan:(NSInteger) colspan rowspan:(NSInteger) rowspan {
    int ltx = column;
    int lty = row;
    int rbx = column + colspan - 1;
    int rby = row + rowspan - 1;
    for (int i = lty; i <= rby; i++) {
        for (int j = ltx; j <= rbx; j++) {
            TableCellInfo *cell = [self getTableCellInfo:j row:i];
            if (i == lty && j == ltx) {
                cell.columnSpan = rbx - ltx + 1;
                cell.rowSpan = rby - lty + 1;
                cell.parent = nil;
            } else {
                cell.columnSpan = 1;
                cell.rowSpan = 1;
                cell.parent = [self getTableCellInfo:ltx row:lty original:NO];
                cell.isSpan = YES;
            }
        }
    }
}

/**
 * 拆分单元格
 *
 * @param column
 *            列序号
 * @param row
 *            行序号
 */
-(void)unmerge:(NSInteger)column row:(NSInteger)row{
    TableCellInfo *selfCell = [self getTableCellInfo:column row:row];
    int ltx = column;
    int lty = row;
    int rbx = column + selfCell.columnSpan - 1;
    int rby = row + selfCell.rowSpan - 1;
    for (int i = lty; i <= rby; i++) {
        for (int j = ltx; j <= rbx; j++) {
            TableCellInfo *cell = [self getTableCellInfo:j row:i];
            cell.columnSpan = 1;
            cell.rowSpan = 1;
            cell.parent = nil;
            cell.isSpan = NO;
        }
    }
}

/**
 * 取得列数
 */
-(NSInteger)getColumnCount {
    return self.columnWidths != nil ? [self.columnWidths count] : 0;
}

/**
 * 取得行数
 */
-(NSInteger)getRowCount {
    return self.rowHeights != nil ? [self.rowHeights count] : 0;
}

-(TableCellInfo *)getTableCellInfo:(int)column row:(int)row{
    return [self getTableCellInfo:column row:row original:YES];
}
-(TableCellInfo *)getTableCellInfo:(int)column row:(int)row original:(BOOL) original {
    if (column < 0 || column >= [self getColumnCount] || row < 0
        || row >= [self getRowCount]) {
        return nil;
    }
    
    NSArray *rowArray = [self.cellInfos objectAtIndex:row];
    TableCellInfo *cell = [rowArray objectAtIndex:column];
    if (original) {
        return cell;
    }
    while (cell.parent != nil) {
        cell = cell.parent;
    }
    return cell;
}




#pragma 算法＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
-(CUSTableData *)getLayoutDataByControll:(UIView *)control{
    CUSLayoutData *data = [control getLayoutData];
    if (data) {
        if([data isKindOfClass:[CUSTableData class]]){
            return (CUSTableData *)data;
        }
    }
    return nil;
}

-(CGSize)computeSize:(UIView *)control{
    int wHint = CUS_LAY_DEFAULT, hHint = CUS_LAY_DEFAULT;
    CGSize size = CGSizeMake(0, 0);
	CUSTableData *data = [self getLayoutDataByControll:control];
	if (data != nil) {
        if([data.width getDataType] == CUSLayoutDataTypeFloat){
            wHint = [data.width getValue];
        }
        if([data.height getDataType] == CUSLayoutDataTypeFloat){
            hHint = [data.height getValue];
        }
	}
    size = [control sizeThatFits:CGSizeMake(wHint, hHint)];
    if (data != nil) {
        if([data.width getDataType] == CUSLayoutDataTypeFloat){
            if([data.width getValue]!= CUS_LAY_DEFAULT){
                size.width = [data.width getValue];
            }
        }
		if([data.height getDataType] == CUSLayoutDataTypeFloat){
            if([data.height getValue]!= CUS_LAY_DEFAULT){
                size.height = [data.height getValue];
            }
        }
	}
    return size;
}


/**
 * 是否存在百分比形式
 *
 * @param array
 * @return <code>true</code>:存在 <code>false</code>:不存在
 */
-(BOOL)hasPercent:(NSArray*) array{
    for (CUSValue *value in array) {
        if ([value getDataType] == CUSLayoutDataTypePercent) {
            return YES;
        }
    }
    return NO;
}

/**
 * 是否存在整数形式
 *
 * @param array
 * @return <code>true</code>:存在 <code>false</code>:不存在
 */
-(BOOL)hasInteger:(NSArray*) array{
    for (CUSValue *value in array) {
        if ([value getDataType] == CUSLayoutDataTypeFloat) {
            return YES;
        }
    }
    return NO;
}

/**
 * 是否存在默认形式
 *
 * @param array
 * @return <code>true</code>:存在 <code>false</code>:不存在
 */
-(BOOL)hasDefault:(NSArray*) array{
    for (CUSValue *value in array) {
        if ([value getDataType] == CUSLayoutDataTypeDefault) {
            return YES;
        }
    }
    return NO;
}

-(void)layout:(UIView *)composite{
    CGRect rect = [composite getClientArea];
	NSArray *children = [self getUsealbeChildren:composite];
	int count = [children count];
	if (count == 0) return;
	int width = rect.size.width - marginLeft - marginRight;
	int height = rect.size.height - marginTop - marginBottom;
    CGRect tableRect = CGRectMake(rect.origin.x + marginLeft, rect.origin.y + marginTop, width, height);

    NSInteger allWidth = tableRect.size.width - (([self getColumnCount] - 1)*spacing);
    NSInteger allHeight = tableRect.size.height - (([self getRowCount] - 1)*spacing);
    self.realColumnWidths = [self computeValueByCurrent:allWidth userSet:self.columnWidths composite:composite isComputingHeight:NO];
    self.realRowHeights = [self computeValueByCurrent:allHeight userSet:self.rowHeights composite:composite isComputingHeight:YES];

    [self setControlsBounds:children clientArea:tableRect];
}

/**
 * 计算容器大小，如果返回为负值，表示由子控件的大小来决定容器大小
 * @param clientRect
 * @return
 */
-(CGRect)computeTableBounds:(CGRect) rect {
	int width = rect.size.width - marginLeft - marginRight;
	int height = rect.size.height - marginTop - marginBottom;
    CGRect tableRect = CGRectMake(rect.origin.x + marginLeft, rect.origin.y + marginTop, width, height);

    return tableRect;
}

/**
 * 计算<b>各列宽度</b>
 */
/**
 * @param allWidth
 * @param composite
 * @return
 */
-(NSMutableArray *)computeValueByCurrent:(NSInteger)allWidth userSet:(NSArray *)userSet composite:(UIView *)composite isComputingHeight:(BOOL)isComputingHeight{
    NSMutableArray *localRealColumnWidths = [NSMutableArray array];
    NSNumber *number = [NSNumber numberWithFloat:0];
    for (CUSValue *value in userSet) {
        [localRealColumnWidths addObject:number];
    }
    
    int integerWidth = 0;
    int percentWidth = 0;
    if (self.pixelFirst) {
        integerWidth = [self computeInteger:localRealColumnWidths userSet:userSet remainNum:allWidth parent:composite isComputingHeight:isComputingHeight];
        percentWidth = [self computePercent:localRealColumnWidths userSet:userSet allNum:allWidth remainNum:allWidth - integerWidth];
        
    } else {
        percentWidth = [self computePercent:localRealColumnWidths userSet:userSet allNum:allWidth remainNum:allWidth];
        integerWidth = [self computeInteger:localRealColumnWidths userSet:userSet remainNum:allWidth - percentWidth parent:composite isComputingHeight:isComputingHeight];
    }
    
    int defaultWidth = [self computeDefault:localRealColumnWidths userSet:userSet remainNum:allWidth - percentWidth - integerWidth];
    
    int remainWidth = allWidth - percentWidth - integerWidth - defaultWidth;
    if (remainWidth > 0 && [localRealColumnWidths count] > 0) {
        NSInteger lastIndex = [localRealColumnWidths count] - 1;
        CGFloat f = [localRealColumnWidths floatAtIndex:lastIndex];
        [localRealColumnWidths replaceFloatAtIndex:lastIndex withFloat:(f + remainWidth)];
    }
    
    return localRealColumnWidths;
}

/**
 * 计算出所有格子中是否有控件，</br>
 * 如果格子中没有控件，则对应数组中值为-1；</br>
 * 如果有控件，记录下控件的index值（从0开始）;</br>
 * 如果是被合并的格子，则对应数组中值为-2</br>
 * 如下数组表示 值为-1的格子没有摆放控件，值大于-1的格子摆放了控件，值为-2的格子为被合并了的格子</br>
 * [					</br>
 * 		[0, -1, -1],	</br>
 * 		[-2, 1, 2],		</br>
 * 		[-1, 3, -1]		</br>
 * ]
 * @return
 */
-(NSArray *) computeTableCellsControlIndex{
    int colLen = [self getColumnCount];
    int rowLen = [self getRowCount];
    int controlIndex = 0;
    NSMutableArray *controlIndexArray = [NSMutableArray array];
//    int[][] controlIndexArray = new int[rowLen][colLen];
    for (int currentRow = 0; currentRow < rowLen; currentRow++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int currentCol = 0; currentCol < colLen; currentCol++) {
            TableCellInfo *cellInfo = [[cellInfos objectAtIndex:currentRow] objectAtIndex:currentCol];
        
            if (cellInfo.ignore) {
                [rowArray addObject:[NSNumber numberWithInt:-1]];
            } else if (cellInfo.isSpan) {
                [rowArray addObject:[NSNumber numberWithInt:-2]];
               
            } else {
                [rowArray addObject:[NSNumber numberWithInt:controlIndex++]];
            }
        }
        [controlIndexArray addObject:rowArray];
        
    }
    return controlIndexArray;
}

/**
 * 返回出指定cell位置对应的控件	</br>
 * 如下：cellIndex --> 	</br>
 * [				</br>
 * 		[0, 0, 0],	</br>
 *  	[1, 1, 1],	</br>
 *  	[0, 0, 0]	</br>
 * ]				</br>
 * 表示需要计算出第二行的所有控件的行高
 * @param parent
 * @param cellIndex
 * @return
 */
-(NSArray *)getControlsByCellIndex:(UIView *)parent cellIndex:(NSArray *)cellIndex {
    if (cellIndex == nil) {
        return nil;
    }
    NSArray *layoutChildren = [self getUsealbeChildren:parent];
    NSArray * controlIndexArray = [self computeTableCellsControlIndex];
    
    NSMutableArray * controlsList = [NSMutableArray array];
    
    for (int currentRow = 0; currentRow < [cellIndex count]; currentRow++) {
        for (int currentCol = 0; currentCol < [[cellIndex objectAtIndex:currentRow] count]; currentCol++) {
            NSNumber *cIndex = [[cellIndex objectAtIndex:currentRow] objectAtIndex:currentCol];
            int controlIndex = [[[controlIndexArray objectAtIndex:currentRow] objectAtIndex:currentCol] intValue];
            
            if ([cIndex boolValue] && controlIndex > -1) {
 
                if (controlIndex <= [layoutChildren count] -1) {
                    [controlsList addObject:[layoutChildren objectAtIndex:controlIndex]];
                }
            }
        }
    }
    return controlsList;
}

/**
 * 计算出指定控件的最佳大小，返回最佳大小最高的高度值
 * @param controls
 * @return
 */
-(NSInteger)getBestSizeByControls:(NSArray *)controls isComputeHeight:(BOOL) isComputeHeight {
    if (controls == nil || [controls count] == 0) {
        return 0;
    }
    int bestSize = 0;
    for (int i = 0; i < [controls count]; i++) {
        UIView * control = [controls objectAtIndex:i];
        CGSize p = [self computeSize:control];
        // 计算格子的最佳高或宽需将格子的位置偏移量计算在内
        CUSTableData *data = [self getLayoutDataByControll:control];
        bestSize = MAX(bestSize, isComputeHeight
                            ? p.height + (data != nil? data.verticalIndent : 0 )
                            : p.width + (data != nil? data.horizontalIndent : 0));
    }
    return bestSize;
}
/**
 * 计算百分比形式
 *
 * @param reals 计算完毕后行/列的值
 * @param types 各行/列的类型(包括INTEGER,DEFAULT,PERCENT,BEST)
 * @param userSet 用户设置的行/列的值
 * @param allNum 总大小
 * @param remainNum 剩余大小
 * @return
 */
-(NSInteger)computePercent:(NSMutableArray *)reals userSet:(NSArray *)userSet allNum:(NSInteger)allNum remainNum:(NSInteger)remainNum{
    BOOL hasPercent = [self hasPercent:userSet];
    BOOL hasDefault = [self hasDefault:userSet];
    BOOL hasInteger = [self hasInteger:userSet];
    int retWidth = 0;
    float sum = 0;
    for (int i = 0; i < [userSet count]; i++) {
        CUSValue *value = [userSet objectAtIndex:i];
        if ([value getDataType] == CUSLayoutDataTypePercent) {
            sum += [value getValue]; //计算比例和
        }
    }
    if (allNum <= 0) { // 总高或宽设置的负值，那么所有比例设置都无效，大小置为0
        for (int i = 0; i < [userSet count]; i++) {
            CUSValue *value = [userSet objectAtIndex:i];
            if ([value getDataType] == CUSLayoutDataTypePercent) {
                [reals replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:0]];
            }
        }
    } else {
        if (hasPercent) {
            for (int i = 0; i < [userSet count]; i++) {
                CUSValue *value = [userSet objectAtIndex:i];
                CGFloat fvalue=  [value getValue];
                if ([value getDataType] == CUSLayoutDataTypePercent) {
                    if (self.pixelFirst) { // userSet[i]为比例 且 像素优先
                        if (sum * (float) allNum > remainNum) { // 超出剩余大小，重新计算比例
                            CGFloat freal = (int) ((float) remainNum * (fvalue / sum));
                            [reals replaceFloatAtIndex:i withFloat:freal];
                            retWidth += freal;
                        } else {								// 剩余大小足够
                            if (hasDefault) {	// 有默认，优先设置比例的行或列，余下的给默认的行或列
                                CGFloat freal = (int) ((float) allNum * fvalue);
                                [reals replaceFloatAtIndex:i withFloat:freal];
                                retWidth += freal;
                            } else {			// 没有默认，余下的宽度都给比例行或列
                                CGFloat freal = (int) ((float) remainNum * (fvalue / sum));
                                [reals replaceFloatAtIndex:i withFloat:freal];
                                retWidth += freal;
                            }
                        }
                    } else { // userSet[i]为比例 且 比例优先
                        if (sum >= 1) { 						// 超出剩余大小，重新计算比例
                            CGFloat freal = (int) ((float) allNum * (fvalue / sum));
                            [reals replaceFloatAtIndex:i withFloat:freal];
                            retWidth += freal;
                        } else {								// 剩余大小足够
                            if (hasInteger || hasDefault) {
                                CGFloat freal = (int) ((float) allNum * fvalue);
                                [reals replaceFloatAtIndex:i withFloat:freal];
                                retWidth += freal;
                            } else {			// 没有默认或固定，余下的宽度都给比例行或列
                                CGFloat freal = (int) ((float) allNum * (fvalue / sum));
                                [reals replaceFloatAtIndex:i withFloat:freal];
                                retWidth += freal;
                            }
                        }
                    }
                }
            }
        }
    }
    
    return retWidth;
}
/**
 * 计算整形形式
 *
 * @param reals 计算完毕后行/列的值
 * @param types 各行/列的类型(包括INTEGER,DEFAULT,PERCENT,BEST)
 * @param userSet 用户设置的行/列的值
 * @param remainNum 剩余大小
 * @param parent
 * @param isComputingHeight 是否正在计算高度
 * @return
 */
-(NSInteger)computeInteger:(NSMutableArray *)reals userSet:(NSArray *)userSet remainNum:(NSInteger)remainNum parent:(UIView *)parent isComputingHeight:(BOOL)isComputingHeight{
    BOOL hasPercent = [self hasPercent:userSet];
    BOOL hasDefault = [self hasDefault:userSet];
    BOOL hasInteger = [self hasInteger:userSet];
    int retWidth = 0;

    if (remainNum <= 0) {
        for (int i = 0; i < [userSet count]; i++) {
            CUSValue *value = [userSet objectAtIndex:i];
            if ([value getDataType] == CUSLayoutDataTypeDefault && self.pixelFirst) { //如果该行或列是计算最佳 && 像素优先
                // 计算第i行行高或第i列列宽
                int totalRowCount = [self getRowCount];
                int totalColCount = [self getColumnCount];
                // 计算出一个二维数组，数组中为true的格子表示要计算该格子中控件的最佳大小
                NSMutableArray *compusteArray = [NSMutableArray array];
                
                
                for (int currentRow = 0; currentRow < totalRowCount; currentRow++) {
                    for (int currentCol = 0; currentCol < totalColCount; currentCol++) {
                        NSMutableArray *rwoArray = [NSMutableArray array];
                        int computeIndex = isComputingHeight ? currentRow : currentCol; // 判断是算行还是算列
                        if (computeIndex == i) {
                            [rwoArray addObject:[NSNumber numberWithBool:YES]];
                        } else {
                            [rwoArray addObject:[NSNumber numberWithBool:NO]];
                        }
                        [compusteArray addObject:rwoArray];
                        
                    }
                }
                NSArray *controls = [self getControlsByCellIndex:parent cellIndex:compusteArray];
                
                CGFloat freal = [self getBestSizeByControls:controls isComputeHeight:isComputingHeight];
                [reals replaceFloatAtIndex:i withFloat:freal];
                retWidth += freal;
            } else if ([value getDataType] == CUSLayoutDataTypeFloat) {
                CGFloat freal = [value getValue];
               [reals replaceFloatAtIndex:i withFloat:freal];
                retWidth += freal;
            }
        }
    } else { // 有余下大小
        if (hasInteger) {
            if (hasDefault || (hasPercent && pixelFirst)) { //  有设置负值 或者 (有比例且是像素优先)
                float sum = 0;
                for (int i = 0; i < [reals count]; i++) {
                    CUSValue *value = [userSet objectAtIndex:i];
                    CGFloat fvalue=  [value getValue];
                    if ([value getDataType] == CUSLayoutDataTypeFloat) {
                        sum += fvalue;
                    }
                }
                if (sum > remainNum) {  //余下的大小不够，平分给每行或没列
                    for (int i = 0; i < [reals count]; i++) {
                        CUSValue *value = [userSet objectAtIndex:i];
                        CGFloat fvalue=  [value getValue];
                        if ([value getDataType] == CUSLayoutDataTypeFloat) {
                            CGFloat freal = (fvalue / sum) * remainNum;
                            [reals replaceFloatAtIndex:i withFloat:freal];
                            retWidth += freal;
                        }
                    }
                } else {
                    for (int i = 0; i < [reals count]; i++) {
                        CUSValue *value = [userSet objectAtIndex:i];
                        CGFloat fvalue=  [value getValue];
                        if ([value getDataType] == CUSLayoutDataTypeFloat) {
                            CGFloat freal = fvalue;
                            [reals replaceFloatAtIndex:i withFloat:(freal)];
                            retWidth += freal;
                        }
                    }
                }
            } else { //  没有设置负值 且 (没有比例或比例优先)
                float sum = 0;
                for (int i = 0; i < [reals count]; i++) {
                    CUSValue *value = [userSet objectAtIndex:i];
                    CGFloat fvalue=  [value getValue];
                    if ([value getDataType] == CUSLayoutDataTypeFloat) {
                        sum += fvalue; //累和
                    }
                }
                for (int i = 0; i < [reals count]; i++) {
                    CUSValue *value = [userSet objectAtIndex:i];
                    CGFloat fvalue=  [value getValue];
                    if ([value getDataType] == CUSLayoutDataTypeFloat) { // 计算比例并分配
                        CGFloat freal = (fvalue / sum) * remainNum;
                        [reals replaceFloatAtIndex:i withFloat:freal];
                        retWidth += freal;
                    }
                }
            }
        }
    }
    return retWidth;
}

/**
 * 计算默认形式
 * @param reals 计算完毕后行/列的值
 * @param types 各行/列的类型(包括INTEGER,DEFAULT,PERCENT,BEST)
 * @param userSet 用户设置的行/列的值
 * @param remainNum 剩余大小
 * @return
 */
-(NSInteger)computeDefault:(NSMutableArray *)reals userSet:(NSArray *)userSet remainNum:(NSInteger)remainNum{
    int retWidth = 0;
    BOOL hasDefault = [self hasDefault:userSet];
    
    if (remainNum <= 0) {
        for (int i = 0; i < [reals count]; i++) {
            CUSValue *value = [userSet objectAtIndex:i];
            if ([value getDataType] == CUSLayoutDataTypeDefault) {
                [reals replaceFloatAtIndex:i withFloat:0];
            }
        }
    } else {
        if (hasDefault) {
            int defaultCount = 0;
            for (int i = 0; i < [reals count]; i++) {
                CUSValue *value = [userSet objectAtIndex:i];
                if ([value getDataType] == CUSLayoutDataTypeDefault) {
                    defaultCount++;
                }
            }
            for (int i = 0; i < [reals count]; i++) { //余下大小平分给default
                CUSValue *value = [userSet objectAtIndex:i];
                if ([value getDataType] == CUSLayoutDataTypeDefault) {
                    CGFloat freal = remainNum / defaultCount;
                    [reals replaceFloatAtIndex:i withFloat:freal];
                    retWidth += freal;
                }
            }
        }
    }
    return retWidth;
}

/**
 * 根据<b>各列宽度</b>和<b>各行高度</b>，设置<b>控件范围</b>
 *
 * @param grid
 * @param realRowHeights
 * @param realColumnWidths
 */

-(void)setControlsBounds:(NSArray *) children clientArea:(CGRect)clientArea{
    int childIndex = -1;
    for (int i = 0; i < [self getRowCount]; i++) {
        for (int j = 0; j < [self getColumnCount]; j++) {
            TableCellInfo *cellInfo = [self getTableCellInfo:j row:i];
            // 如果当前区域已被合并，则继续循环
            if (cellInfo.isSpan == YES) {
                continue;
            }
            // 如果当前区域被忽略，则继续循环
            if (cellInfo.ignore == YES) {
                continue;
            }
            childIndex++;
            // 所有控件设置结束，退出循环
            if (childIndex >= [children count]) {
                break;
            }
            int x = [self getXByColumn:j];
            int y = [self getYByRow:i];
            int w = [self getColumnSpanWidth:j columnSpan:cellInfo.columnSpan];
            int h = [self getRowSpanHeight:i rowSpan:cellInfo.rowSpan];

            CGRect rect = CGRectMake(x, y, w, h);
            UIView *control = [children objectAtIndex:childIndex];
            CGRect bounds = [self getControlBoundsByTableData:control rect:rect];
            control.frame = CGRectMake(clientArea.origin.x + bounds.origin.x, clientArea.origin.y + bounds.origin.y, bounds.size.width, bounds.size.height);
        }
    }
    
    // 行列较少，剩余控件隐藏
    if (childIndex + 1< [children count]) {
        for (int i = childIndex + 1; i < [children count]; i++) {
            CGRect rect = CGRectMake(-1, -1, 0, 0);
            UIView *control = [children objectAtIndex:i];
            control.frame = rect;
        }
    }
}

/**
 * 取得所在列的X坐标
 *
 * @param column
 * @return
 */
-(NSInteger) getXByColumn:(NSInteger) column{
    NSInteger beforeTheRowX = 0;
    for (int i = 0; i < column; i++) {
        beforeTheRowX += [self.realColumnWidths floatAtIndex:i];
        beforeTheRowX += spacing;
    }
    return beforeTheRowX;
}

/**
 * 取得所在行的Y坐标
 *
 * @param row
 * @return
 */
-(NSInteger) getYByRow:(NSInteger)row{
    NSInteger beforeTheRowY = 0;
    for (int i = 0; i < row; i++) {
        beforeTheRowY += [self.realRowHeights floatAtIndex:i];
        beforeTheRowY += spacing;
    }
    return beforeTheRowY;
}

-(NSInteger) getColumnSpanWidth:(NSInteger)column columnSpan:(NSInteger)columnSpan{
    int spanWidth = 0;
    for (int i = column; i < column + columnSpan && i < [self.columnWidths count]; i++) {
        spanWidth += [self.realColumnWidths floatAtIndex:i] ;
        if(i > column){
            spanWidth += spacing;
        }
    }
    return spanWidth;
}

-(NSInteger) getRowSpanHeight:(NSInteger)row rowSpan:(NSInteger)rowSpan{
    int spanHeight = 0;
    for (int i = row; i < row + rowSpan && i < [self.rowHeights count]; i++) {
        spanHeight += [self.realRowHeights floatAtIndex:i];
        if(i > row){
            spanHeight += spacing;
        }
    }
    return spanHeight;
}
 
/**
 * 根据单元格范围和TabelData计算控件范围
 * 
 * @param control
 *            单元格内控件
 * @param x
 *            单元格起始X坐标
 * @param y
 *            单元格起始Y坐标
 * @param width
 *            单元格宽度
 * @param height
 *            单元格高度
 * @return
 */
-(CGRect) getControlBoundsByTableData:(UIView *)control rect:(CGRect)rect{
    CUSTableData *data = [self getLayoutDataByControll:control];
    if (data == nil) {
        data = [CUSTableLayout shareTableDataInstance];
    }
//    CGSize size = [self comupteControlSize:control width:rect.size.width height:rect.size.height];
    
    CGSize size = [self computeSize:control];
    CGRect bounds = CGRectMake(rect.origin.x, rect.origin.y, 0, 0);
    
    // 列方向
    if (data.horizontalAlignment == CUSLayoutAlignmentLeft) {
        bounds.origin.x += data.horizontalIndent;
        bounds.size.width = MIN(rect.size.width - data.horizontalIndent, size.width);
    } else if (data.horizontalAlignment == CUSLayoutAlignmentCenter) {
        int realWidth = MIN(rect.size.width - data.horizontalIndent, size.width);
        bounds.origin.x += data.horizontalIndent + (rect.size.width - data.horizontalIndent - realWidth) / 2;
        bounds.size.width += realWidth;
    } else if (data.horizontalAlignment == CUSLayoutAlignmentRight) {
        bounds.origin.x += rect.size.width - MIN(rect.size.width, size.width);
        bounds.size.width = MIN(rect.size.width, size.width);
    } else if (data.horizontalAlignment == CUSLayoutAlignmentFill) {
        bounds.origin.x += data.horizontalIndent;
        bounds.size.width = rect.size.width - data.horizontalIndent;
    }
    
    // 行方向
    if (data.verticalAlignment == CUSLayoutAlignmentLeft) {
        bounds.origin.y += data.verticalIndent;
        bounds.size.height = MIN(rect.size.height - data.verticalIndent, size.height);
    } else if (data.verticalAlignment == CUSLayoutAlignmentCenter) {
        int realHeight = MIN(rect.size.height - data.verticalIndent, size.height);
        bounds.origin.y += data.verticalIndent + (rect.size.height - data.verticalIndent - realHeight) / 2;
        bounds.size.height += realHeight;
    } else if (data.verticalAlignment == CUSLayoutAlignmentRight) {
        bounds.origin.y += rect.size.height - MIN(rect.size.height, size.height);
        bounds.size.height = MIN(rect.size.height, size.height);
    } else if (data.verticalAlignment == CUSLayoutAlignmentFill) {
        bounds.origin.y += data.verticalIndent;
        bounds.size.height = rect.size.height - data.verticalIndent;
    }
    return bounds;
}

/**
 * 计算控件大小
 * 
 * @param control
 * @param width
 * @param height
 * @return
 */
-(CGSize)comupteControlSize:(UIView *)control width:(NSInteger)width height:(NSInteger)height{
    if (width <= 0) {
        width = -1;
    }
    if (height <= 0) {
        height = -1;
    }
    if (width != -1 && height != -1) {
        return CGSizeMake(width, height);
    } else {
        return [self computeSize:control];
    }
}

+(CUSTableData *)shareTableDataInstance{
    if (!CUSTableDataInstance) {
        CUSTableDataInstance = [[CUSTableData alloc]init];
    }
    return CUSTableDataInstance;
}
@end
