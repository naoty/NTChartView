//
//  DateLineChartViewController.m
//  NTChartViewDemo
//
//  Created by naoty on 2013/08/10.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "DateLineChartViewController.h"

@implementation DateLineChartViewController

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
    
    NSMutableArray *data = [@[] mutableCopy];
    for (int day = 0; day < 7; day++) {
        NSDate *date = [today dateByAddingTimeInterval:day * 24 * 60 * 60];
        NSArray *values = @[date, [NSNumber numberWithInt:(arc4random() % 100 + 1)]];
        [data addObject:values];
    }
    
    return data;
}

@end
