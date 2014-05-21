/**
 @version 1.00 2013/4/9 Creation
 @copyright Copyright (c) 2013 zhangyu. All rights reserved.
 */

#import "CUSGridLayout.h"
#import "CUSLayoutObject+Util.h"
#import "CUSGridData.h"
#import "CUSLayoutConstant.h"

@implementation CUSGridLayout{
    
}
@synthesize numColumns;
@synthesize makeColumnsEqualWidth;
@synthesize horizontalSpacing;
@synthesize verticalSpacing;
- (id)init
{
    self = [super init];
    if (self) {
        self.numColumns = 1;
        self.makeColumnsEqualWidth = YES;
        self.horizontalSpacing = 5;
        self.verticalSpacing = 5;
        
        self.marginLeft = 5;
        self.marginTop = 5;
        self.marginRight = 5;
        self.marginBottom = 5;
    }
    return self;
}

- (id)initWithNumColumns:(NSInteger)numColumns_
{
    self = [self init];
    if (self) {
        self.numColumns = numColumns_;
    }
    return self;
}

-(CGSize)computeSize:(UIView *)composite wHint:(CGFloat)wHint hHint:(CGFloat)hHint{
	CGSize size = [self _advancedLayout:composite move:NO rect:CGRectMake(0, 0, wHint, hHint)];
	if (wHint != CUS_LAY_DEFAULT) {
		size.width = wHint;
	}
	if (hHint != CUS_LAY_DEFAULT) {
		size.height = hHint;
	}
	return size;
}

-(CGSize)computeChildSize:(UIView *)control wHint:(int)wHint hHint:(int)hHint{
	CUSGridData *data = [self getLayoutDataByControll:control];
    CGSize size = [control computeSize:CGSizeMake(wHint, hHint)];
    
    if (data != nil) {
		if(data.widthHint != CUS_LAY_DEFAULT){
            size.width = data.widthHint;
        }
        if(data.heightHint != CUS_LAY_DEFAULT){
            size.height = data.heightHint;
        }
	}
    
    return size;
}

-(CUSGridData *)getLayoutDataByControll:(UIView *)control{
    CUSGridData *data = (CUSGridData *)[control getLayoutData];
    if (data) {
        if([data isKindOfClass:[CUSGridData class]]){
            return (CUSGridData *)data;
        }
    }
    data = [[CUSGridData alloc]init];
    control.layoutData = data;
    return data;
}


-(BOOL) flushCache:(UIView *)control{
	CUSGridData * data = [self getLayoutDataByControll:control];
	if (data != nil) [data flushCache];
	return YES;
}
-(CUSGridData *) getData:(CUS2DArray *)grid row:(int)row column:(int)column rowCount:(int)rowCount columnCount:(int)columnCount first:(BOOL)first{
	UIView *control = [grid objectAtRow:row atColumn:column];
	if (control != nil) {
		CUSGridData * data = [self getLayoutDataByControll:control]; 
		int hSpan = MAX (1, MIN (data.horizontalSpan, columnCount));
		int vSpan = MAX (1, data.verticalSpan);
		int i = first ? row + vSpan - 1 : row - vSpan + 1;
		int j = first ? column + hSpan - 1 : column - hSpan + 1;
		if (0 <= i && i < rowCount) {
			if (0 <= j && j < columnCount) {
				if (control == [grid objectAtRow:i atColumn:j]) return data;
			}
		}
	}
	return nil;
}


-(void)layout:(UIView *)composite{
	CGRect rect = [composite getClientArea];
    [self _advancedLayout:composite move:YES rect:rect];
}

-(CGSize)_advancedLayout:(UIView *)composite move:(BOOL)move rect:(CGRect)rect{
	CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
	if (self.numColumns < 1) {
//		if (move) {
//			if (self.widths == nil) {
//				self.widths = [NSMutableArray array];
//			}
//			if (self.heights == nil) {
//				self.heights = [NSMutableArray array];
//			}
//		}
		return CGSizeMake(self.marginLeft + self.marginRight, self.marginTop + self.marginBottom);
	}
	NSArray *children = [self getUsealbeChildren:composite];
	int count = [children count];
	if (count == 0) {
//		if (move) {
//			if (self.widths == nil) {
//				self.widths = [NSMutableArray array];
//			}
//			if (self.heights == nil) {
//				self.heights = [NSMutableArray array];
//			}
//		}
		return CGSizeMake(self.marginLeft + self.marginRight, self.marginTop + self.marginBottom);
	}
	for (int i=0; i<count; i++) {
		UIView *child = [children objectAtIndex:i];
		CUSGridData * data= [self getLayoutDataByControll:child];
        [data computeSize:child wHint:data.widthHint hHint:data.heightHint flushCache:YES];
		if (data.grabExcessHorizontalSpace && data.minimumWidth > 0) {
			if (data.cacheWidth < data.minimumWidth) {
				int trim = 0;
				data.cacheWidth = data.cacheHeight = CUS_LAY_DEFAULT;
                [data computeSize:child wHint:MAX (0, data.minimumWidth - trim) hHint:data.heightHint flushCache:NO];
			}
		}
		if (data.grabExcessVerticalSpace && data.minimumHeight > 0) {
			data.cacheHeight = MAX (data.cacheHeight, data.minimumHeight);
		}
	}
    
	/* Build the grid */
	int row = 0, column = 0, rowCount = 0, columnCount = numColumns;
    CUS2DArray *grid = [[CUS2DArray alloc]init:4 atColumnCount:columnCount];
	for (int i=0; i<count; i++) {
		UIView *child = [children objectAtIndex:i];
		CUSGridData * data= [self getLayoutDataByControll:child];
		int hSpan = MAX (1, MIN (data.horizontalSpan, columnCount));
		int vSpan = MAX (1, data.verticalSpan);
		while (YES) {
			int lastRow = row + vSpan;
			if (lastRow >= grid.rowCount) {
				grid.rowCount = lastRow + 4;
			}
			while (column < columnCount && [grid objectAtRow:row atColumn:column] != nil) {
				column++;
			}
			int endCount = column + hSpan;
			if (endCount <= columnCount) {
				int index = column;
				while (index < endCount && [grid objectAtRow:row atColumn:index] == nil) {
					index++;
				}
				if (index == endCount) break;
				column = index;
			}
			if (column + hSpan >= columnCount) {
				column = 0;
				row++;
			}
		}

		for (int j=0; j<vSpan; j++) {
			for (int k=0; k<hSpan; k++) {
                [grid addObject:child atRow:row + j atColumn:column + k];
			}
		}
		rowCount = MAX (rowCount, row + vSpan);
		column += hSpan;
	}
    
	/* Column widths */
	int availableWidth = width - horizontalSpacing * (columnCount - 1) - (self.marginLeft + self.marginRight);
    
	int expandCount = 0;
    int *widths = malloc(columnCount * sizeof(int));
    for (int i = 0; i < columnCount; i++) {
        widths[i] = 0;
    }
    int *minWidths = malloc(columnCount * sizeof(int));
    for (int i = 0; i < columnCount; i++) {
        minWidths[i] = 0;
    }
    BOOL *expandColumn = malloc(columnCount * sizeof(BOOL));
    for (int i = 0; i < columnCount; i++) {
        expandColumn[i] = NO;
    }
    
	for (int j=0; j<columnCount; j++) {
		for (int i=0; i<rowCount; i++) {
        
                
			CUSGridData *data = [self getData:(CUS2DArray *)grid row:i column:j rowCount:rowCount columnCount:columnCount first:YES];
			if (data != nil) {
				int hSpan = MAX (1, MIN (data.horizontalSpan, columnCount));
				if (hSpan == 1) {
					int w = data.cacheWidth + data.horizontalIndent;
					widths [j] = MAX (widths [j], w);
					if (data.grabExcessHorizontalSpace) {
						if (!expandColumn[j]) expandCount++;
                        expandColumn[j] = YES;
					}
					if (!data.grabExcessHorizontalSpace || data.minimumWidth != 0) {
						w = !data.grabExcessHorizontalSpace || data.minimumWidth == CUS_LAY_DEFAULT ? data.cacheWidth : data.minimumWidth;
						w += data.horizontalIndent;
						minWidths [j] = MAX (minWidths [j], w);
					}
				}
			}
		}
		for (int i=0; i<rowCount; i++) {
            CUSGridData *data = [self getData:(CUS2DArray *)grid row:i column:j rowCount:rowCount columnCount:columnCount first:NO];
			if (data != nil) {
				int hSpan = MAX (1, MIN (data.horizontalSpan, columnCount));
				if (hSpan > 1) {
					int spanWidth = 0, spanMinWidth = 0, spanExpandCount = 0;
					for (int k=0; k<hSpan; k++) {
						spanWidth += widths [j-k];
						spanMinWidth += minWidths [j-k];
						if (expandColumn [j-k]) spanExpandCount++;
					}
					if (data.grabExcessHorizontalSpace && spanExpandCount == 0) {
						expandCount++;
						expandColumn [j] = YES;
					}
					int w = data.cacheWidth + data.horizontalIndent - spanWidth - (hSpan - 1) * horizontalSpacing;
					if (w > 0) {
						if (makeColumnsEqualWidth) {
							int equalWidth = (w + spanWidth) / hSpan;
							int remainder = (w + spanWidth) % hSpan, last = -1;
							for (int k = 0; k < hSpan; k++) {
								widths [last=j-k] = MAX (equalWidth, widths [j-k]);
							}
							if (last > -1) widths [last] += remainder;
						} else {
							if (spanExpandCount == 0) {
								widths [j] += w;
							} else {
								int delta = w / spanExpandCount;
								int remainder = w % spanExpandCount, last = -1;
								for (int k = 0; k < hSpan; k++) {
									if (expandColumn [j-k]) {
										widths [last=j-k] += delta;
									}
								}
								if (last > -1) widths [last] += remainder;
							}
						}
					}
					if (!data.grabExcessHorizontalSpace || data.minimumWidth != 0) {
						w = !data.grabExcessHorizontalSpace || data.minimumWidth == CUS_LAY_DEFAULT ? data.cacheWidth : data.minimumWidth;
						w += data.horizontalIndent - spanMinWidth - (hSpan - 1) * horizontalSpacing;
						if (w > 0) {
							if (spanExpandCount == 0) {
								minWidths [j] += w;
							} else {
								int delta = w / spanExpandCount;
								int remainder = w % spanExpandCount, last = -1;
								for (int k = 0; k < hSpan; k++) {
									if (expandColumn [j-k]) {
										minWidths [last=j-k] += delta;
									}
								}
								if (last > -1) minWidths [last] += remainder;
							}
						}
					}
				}
			}
		}
	}
	if (makeColumnsEqualWidth) {
		int minColumnWidth = 0;
		int columnWidth = 0;
		for (int i=0; i<columnCount; i++) {
			minColumnWidth = MAX (minColumnWidth, minWidths [i]);
			columnWidth = MAX (columnWidth, widths [i]);
		}
		columnWidth = width == CUS_LAY_DEFAULT || expandCount == 0 ? columnWidth : MAX (minColumnWidth, availableWidth / columnCount);
		for (int i=0; i<columnCount; i++) {
			expandColumn [i] = expandCount > 0;
			widths [i] = columnWidth;
		}
	} else {
		if (width != CUS_LAY_DEFAULT && expandCount > 0) {
			int totalWidth = 0;
			for (int i=0; i<columnCount; i++) {
				totalWidth += widths [i];
			}
			int c = expandCount;
			int delta = (availableWidth - totalWidth) / c;
			int remainder = (availableWidth - totalWidth) % c;
			int last = -1;
			while (totalWidth != availableWidth) {
				for (int j=0; j<columnCount; j++) {
					if (expandColumn [j]) {
						if (widths [j] + delta > minWidths [j]) {
							widths [last = j] = widths [j] + delta;
						} else {
							widths [j] = minWidths [j];
							expandColumn [j] = NO;
							c--;
						}
					}
				}
				if (last > -1) widths [last] += remainder;
				
				for (int j=0; j<columnCount; j++) {
					for (int i=0; i<rowCount; i++) {
                        CUSGridData *data = [self getData:(CUS2DArray *)grid row:i column:j rowCount:rowCount columnCount:columnCount first:NO];
						if (data != nil) {
							int hSpan = MAX (1, MIN (data.horizontalSpan, columnCount));
							if (hSpan > 1) {
								if (!data.grabExcessHorizontalSpace || data.minimumWidth != 0) {
									int spanWidth = 0, spanExpandCount = 0;
									for (int k=0; k<hSpan; k++) {
										spanWidth += widths [j-k];
										if (expandColumn [j-k]) spanExpandCount++;
									}
									int w = !data.grabExcessHorizontalSpace || data.minimumWidth == CUS_LAY_DEFAULT ? data.cacheWidth : data.minimumWidth;
									w += data.horizontalIndent - spanWidth - (hSpan - 1) * horizontalSpacing;
									if (w > 0) {
										if (spanExpandCount == 0) {
											widths [j] += w;
										} else {
											int delta2 = w / spanExpandCount;
											int remainder2 = w % spanExpandCount, last2 = -1;
											for (int k = 0; k < hSpan; k++) {
												if (expandColumn [j-k]) {
													widths [last2=j-k] += delta2;
												}
											}
											if (last2 > -1) widths [last2] += remainder2;
										}
									}
								}
							}
						}
					}
				}
				if (c == 0) break;
				totalWidth = 0;
				for (int i=0; i<columnCount; i++) {
					totalWidth += widths [i];
				}
				delta = (availableWidth - totalWidth) / c;
				remainder = (availableWidth - totalWidth) % c;
				last = -1;
			}
		}
	}
    
	/* Wrapping */
    NSMutableArray *flush = [NSMutableArray array];
    
	int flushLength = 0;
	if (width != CUS_LAY_DEFAULT) {
		for (int j=0; j<columnCount; j++) {
			for (int i=0; i<rowCount; i++) {
                CUSGridData *data = [self getData:(CUS2DArray *)grid row:i column:j rowCount:rowCount columnCount:columnCount first:NO];
				if (data != nil) {
					if (data.heightHint == CUS_LAY_DEFAULT) {
						UIView *child = [grid objectAtRow:i atColumn:j];
						//TEMPORARY CODE
						int hSpan = MAX (1, MIN (data.horizontalSpan, columnCount));
						int currentWidth = 0;
						for (int k=0; k<hSpan; k++) {
							currentWidth += widths [j-k];
						}
						currentWidth += (hSpan - 1) * horizontalSpacing - data.horizontalIndent;
						if ((currentWidth != data.cacheWidth && data.horizontalAlignment == CUSLayoutAlignmentFill) || (data.cacheWidth > currentWidth)) {
							int trim = 0;

							data.cacheWidth = data.cacheHeight = CUS_LAY_DEFAULT;
                            [data computeSize:child wHint:MAX (0, currentWidth - trim) hHint:data.heightHint flushCache:NO];
							if (data.grabExcessVerticalSpace && data.minimumHeight > 0) {
								data.cacheHeight = MAX (data.cacheHeight, data.minimumHeight);
							}
//							if (flush == nil) flush = malloc(count * sizeof(CUSGridData *));
//							flush [flushLength++] = data;
                            flushLength++;
                            [flush addObject:data];
						}
					}
				}
			}
		}
	}
    
	/* Row heights */
	int availableHeight = height - verticalSpacing * (rowCount - 1) - (self.marginTop  + self.marginBottom);
	expandCount = 0;
    int *heights = malloc(rowCount * sizeof(int));
    for (int i = 0; i < rowCount; i++) {
        heights[i] = 0;
    }
	int *minHeights = malloc(rowCount * sizeof(int));
    for (int i = 0; i < rowCount; i++) {
        minHeights[i] = 0;
    }
	BOOL *expandRow = malloc(rowCount * sizeof(BOOL));
    for (int i = 0; i < rowCount; i++) {
        expandRow[i] = NO;
    }
	for (int i=0; i<rowCount; i++) {
		for (int j=0; j<columnCount; j++) {
            CUSGridData *data = [self getData:(CUS2DArray *)grid row:i column:j rowCount:rowCount columnCount:columnCount first:YES];
			if (data != nil) {
				int vSpan = MAX (1, MIN (data.verticalSpan, rowCount));
				if (vSpan == 1) {
					int h = data.cacheHeight + data.verticalIndent;
                    
					heights [i] = MAX (heights [i], h);
					if (data.grabExcessVerticalSpace) {
						if (!expandRow [i]) expandCount++;
						expandRow [i] = YES;
					}
					if (!data.grabExcessVerticalSpace || data.minimumHeight != 0) {
						h = !data.grabExcessVerticalSpace || data.minimumHeight == CUS_LAY_DEFAULT ? data.cacheHeight : data.minimumHeight;
						h += data.verticalIndent;
						minHeights [i] = MAX (minHeights [i], h);
					}
				}
			}
		}
		for (int j=0; j<columnCount; j++) {
			CUSGridData *data = [self getData:(CUS2DArray *)grid row:i column:j rowCount:rowCount columnCount:columnCount first:NO];
			if (data != nil) {
				int vSpan = MAX (1, MIN (data.verticalSpan, rowCount));
				if (vSpan > 1) {
					int spanHeight = 0, spanMinHeight = 0, spanExpandCount = 0;
					for (int k=0; k<vSpan; k++) {
						spanHeight += heights [i-k];
						spanMinHeight += minHeights [i-k];
						if (expandRow [i-k]) spanExpandCount++;
					}
					if (data.grabExcessVerticalSpace && spanExpandCount == 0) {
						expandCount++;
						expandRow [i] = YES;
					}
					int h = data.cacheHeight + data.verticalIndent - spanHeight - (vSpan - 1) * verticalSpacing;
					if (h > 0) {
						if (spanExpandCount == 0) {
							heights [i] += h;
						} else {
							int delta = h / spanExpandCount;
							int remainder = h % spanExpandCount, last = -1;
							for (int k = 0; k < vSpan; k++) {
								if (expandRow [i-k]) {
									heights [last=i-k] += delta;
								}
							}
							if (last > -1) heights [last] += remainder;
						}
					}
					if (!data.grabExcessVerticalSpace || data.minimumHeight != 0) {
						h = !data.grabExcessVerticalSpace || data.minimumHeight == CUS_LAY_DEFAULT ? data.cacheHeight : data.minimumHeight;
						h += data.verticalIndent - spanMinHeight - (vSpan - 1) * verticalSpacing;
						if (h > 0) {
							if (spanExpandCount == 0) {
								minHeights [i] += h;
							} else {
								int delta = h / spanExpandCount;
								int remainder = h % spanExpandCount, last = -1;
								for (int k = 0; k < vSpan; k++) {
									if (expandRow [i-k]) {
										minHeights [last=i-k] += delta;
									}
								}
								if (last > -1) minHeights [last] += remainder;
							}
						}
					}
				}
			}
		}
	}
	if (height != CUS_LAY_DEFAULT && expandCount > 0) {
		int totalHeight = 0;
		for (int i=0; i<rowCount; i++) {
			totalHeight += heights [i];
		}
		int c = expandCount;
		int delta = (availableHeight - totalHeight) / c;
		int remainder = (availableHeight - totalHeight) % c;
		int last = -1;
		while (totalHeight != availableHeight) {
			for (int i=0; i<rowCount; i++) {
				if (expandRow [i]) {
					if (heights [i] + delta > minHeights [i]) {
						heights [last = i] = heights [i] + delta;
					} else {
						heights [i] = minHeights [i];
						expandRow [i] = NO;
						c--;
					}
				}
			}
			if (last > -1) heights [last] += remainder;
			
			for (int i=0; i<rowCount; i++) {
				for (int j=0; j<columnCount; j++) {
					CUSGridData *data = [self getData:(CUS2DArray *)grid row:i column:j rowCount:rowCount columnCount:columnCount first:NO];
					if (data != nil) {
						int vSpan = MAX (1, MIN (data.verticalSpan, rowCount));
						if (vSpan > 1) {
							if (!data.grabExcessVerticalSpace || data.minimumHeight != 0) {
								int spanHeight = 0, spanExpandCount = 0;
								for (int k=0; k<vSpan; k++) {
									spanHeight += heights [i-k];
									if (expandRow [i-k]) spanExpandCount++;
								}
								int h = !data.grabExcessVerticalSpace || data.minimumHeight == CUS_LAY_DEFAULT ? data.cacheHeight : data.minimumHeight;
								h += data.verticalIndent - spanHeight - (vSpan - 1) * verticalSpacing;
								if (h > 0) {
									if (spanExpandCount == 0) {
										heights [i] += h;
									} else {
										int delta2 = h / spanExpandCount;
										int remainder2 = h % spanExpandCount, last2 = -1;
										for (int k = 0; k < vSpan; k++) {
											if (expandRow [i-k]) {
												heights [last2=i-k] += delta2;
											}
										}
										if (last2 > -1) heights [last2] += remainder2;
									}
								}
							}
						}
					}
				}
			}
			if (c == 0) break;
			totalHeight = 0;
			for (int i=0; i<rowCount; i++) {
				totalHeight += heights [i];
			}
			delta = (availableHeight - totalHeight) / c;
			remainder = (availableHeight - totalHeight) % c;
			last = -1;
		}
	}

	/* Position the controls */
	if (move) {
		CGFloat gridY = y + self.marginTop;
		for (int i=0; i<rowCount; i++) {
			CGFloat gridX = x + self.marginLeft;
			for (int j=0; j<columnCount; j++) {
				CUSGridData *data = [self getData:(CUS2DArray *)grid row:i column:j rowCount:rowCount columnCount:columnCount first:YES];
				if (data != nil) {
					int hSpan = MAX (1, MIN (data.horizontalSpan, columnCount));
					int vSpan = MAX (1, data.verticalSpan);
					CGFloat cellWidth = 0, cellHeight = 0;
					for (int k=0; k<hSpan; k++) {
						cellWidth += widths [j+k];
					}
					for (int k=0; k<vSpan; k++) {
						cellHeight += heights [i+k];
					}
					cellWidth += horizontalSpacing * (hSpan - 1);
					CGFloat childX = gridX + data.horizontalIndent;
					CGFloat childWidth = MIN (data.cacheWidth, cellWidth);
                    if (data.horizontalAlignment == CUSLayoutAlignmentCenter) {
                        childX += MAX (0, (cellWidth - data.horizontalIndent - childWidth) / 2);
                    }else if (data.horizontalAlignment == CUSLayoutAlignmentRight) {
                        childX += MAX (0, cellWidth - data.horizontalIndent - childWidth);
                    }else if (data.horizontalAlignment == CUSLayoutAlignmentFill) {
                        childWidth = cellWidth - data.horizontalIndent;
                    }
					
					cellHeight += verticalSpacing * (vSpan - 1);
                    
					CGFloat childY = gridY + data.verticalIndent;
					CGFloat childHeight = MIN (data.cacheHeight, cellHeight);
                    if (data.verticalAlignment == CUSLayoutAlignmentCenter) {
                        childY += MAX (0, (cellHeight - data.verticalIndent - childHeight) / 2);
                    }else if (data.verticalAlignment == CUSLayoutAlignmentRight) {
                        childY += MAX (0, cellHeight - data.verticalIndent - childHeight);
                    }else if (data.verticalAlignment == CUSLayoutAlignmentFill) {
                        childHeight = cellHeight - data.verticalIndent;
                    }
                    
					UIView *child = [grid objectAtRow:i atColumn:j];
					if (child != nil) {
                        child.frame = CGRectMake(childX, childY, childWidth, childHeight);
					}
				}
				gridX += widths [j] + horizontalSpacing;
			}
			gridY += heights [i] + verticalSpacing;
		}
	}
    
	// clean up cache
	for (int i = 0; i < flushLength; i++) {
        CUSGridData *data = [flush objectAtIndex:i];
		data.cacheWidth = data.cacheHeight = -1;
	}
    
	int totalDefaultWidth = 0;
	int totalDefaultHeight = 0;
	for (int i=0; i<columnCount; i++) {
		totalDefaultWidth += widths [i];
	}
	for (int i=0; i<rowCount; i++) {
		totalDefaultHeight += heights [i];
	}
	totalDefaultWidth += self.horizontalSpacing * (columnCount - 1) + self.marginLeft + self.marginRight;
	totalDefaultHeight += self.verticalSpacing * (rowCount - 1) + self.marginTop + self.marginBottom;
    
    
    free(widths);
    free(minWidths);
    free(expandColumn);
    
    free(heights);
    free(minHeights);
    free(expandRow);
    
	return CGSizeMake(totalDefaultWidth, totalDefaultHeight);
}

@end
