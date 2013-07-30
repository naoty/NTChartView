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
        return @[@[@1, @20], @[@2, @10], @[@3, @50], @[@4, @80]];
    } else {
        return @[@[@1, @50], @[@2, @60], @[@3, @30], @[@4, @40]];
    }
}

@end
