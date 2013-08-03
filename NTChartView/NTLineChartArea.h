//
//  NTLineChartArea.h
//  NTChartView
//
//  Created by 金子 直人 on 2013/08/01.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTLineChartView.h"

@class NTPoint;

@interface NTLineChartArea : NTLineChartView

- (id)initWithFrame:(CGRect)rect numberOfLines:(NSInteger)number;
- (void)addPoint:(NTPoint *)point atLineIndex:(NSInteger)index;
- (void)drawLineAtIndex:(NSInteger)index;
- (void)drawRules;

@end
