//
//  DateTimeLineChartViewController.m
//  NTChartViewDemo
//
//  Created by naoty on 2013/08/10.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "DateTimeLineChartViewController.h"

@implementation DateTimeLineChartViewController

#pragma mark - NTLineChartViewDataSource

- (NSInteger)numberOfLinesInLineChartView:(NTLineChartView *)lineChartView
{
    return 1;
}

- (NSArray *)lineChartView:(NTLineChartView *)lineChartView dataForLineAtIndex:(NSInteger)index
{
    // Get the beginning of day
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:components];
    
    // Make the pair of each hour and random value
    NSMutableArray *data = [@[] mutableCopy];
    for (int hour = 0; hour < 24; hour++) {
        NSDate *date = [today dateByAddingTimeInterval:hour * 60 * 60];
        NSArray *values = @[date, [NSNumber numberWithInt:(arc4random() % 100 + 1)]];
        [data addObject:values];
    }
    
    return data;
}

@end
