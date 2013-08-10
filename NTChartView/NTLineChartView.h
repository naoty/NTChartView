//
//  NTLineChartView.h
//  NTChartView
//
//  Created by naoty on 2013/07/31.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTChartView.h"

@protocol NTLineChartViewDataSource;

typedef NS_ENUM(NSInteger, NTLineChartXAxisDataType) {
    NTLineChartXAxisDataTypeNumber,
    NTLineChartXAxisDataTypeDate
};

@interface NTLineChartView : NTChartView

@property (nonatomic, weak) id <NTLineChartViewDataSource> dataSource;
@property (nonatomic) double minXValue;
@property (nonatomic) double maxXValue;
@property (nonatomic) double minYValue;
@property (nonatomic) double maxYValue;

- (void)refreshWithFrame:(CGRect)frame;

@end

@protocol NTLineChartViewDataSource <NSObject>

- (NSInteger)numberOfLinesInLineChartView:(NTLineChartView *)lineChartView;
- (NSArray *)lineChartView:(NTLineChartView *)lineChartView dataForLineAtIndex:(NSInteger)index;

@end
