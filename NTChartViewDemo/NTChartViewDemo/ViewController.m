//
//  ViewController.m
//  NTChartViewDemo
//
//  Created by naoty on 2013/07/31.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NTLineChartView *lineChartView = [[NTLineChartView alloc] initWithFrame:self.view.bounds];
    lineChartView.dataSource = self;
    [self.view addSubview:lineChartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - NTLineChartViewDataSource

- (NSInteger)numberOfLinesInLineChartView:(NTLineChartView *)lineChartView
{
    return 2;
}

- (NSArray *)lineChartView:(NTLineChartView *)lineChartView dataForLineAtIndex:(NSInteger)index
{
    if (index == 0) {
        return @[@[@0, @50], @[@1, @150], @[@2, @300], @[@3, @0], @[@4, @200], @[@5, @500], @[@6, @300]];
    } else {
        return @[@[@0, @200], @[@1, @50], @[@2, @100], @[@3, @400], @[@4, @50], @[@5, @300], @[@6, @750]];
    }
}

@end
