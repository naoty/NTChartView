//
//  NTLineChartView.h
//  NTChartView
//
//  Created by naoty on 2013/07/31.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTChartView.h"

@protocol NTLineChartViewDataSource;

@interface NTLineChartView : NTChartView

@property (nonatomic, weak) id <NTLineChartViewDataSource> dataSource;
@property (nonatomic) float minXValue;
@property (nonatomic) float maxXValue;
@property (nonatomic) float minYValue;
@property (nonatomic) float maxYValue;

@end

@protocol NTLineChartViewDataSource <NSObject>

- (NSInteger)numberOfLinesInLineChartView:(NTLineChartView *)lineChartView;
- (NSArray *)lineChartView:(NTLineChartView *)lineChartView dataForLineAtIndex:(NSInteger)index;

@end
