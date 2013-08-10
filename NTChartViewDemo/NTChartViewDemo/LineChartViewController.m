//
//  LineChartViewController.m
//  NTChartViewDemo
//
//  Created by naoty on 2013/08/10.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "LineChartViewController.h"

@interface LineChartViewController ()

@property (nonatomic) NTLineChartView *lineChartView;

@end

@implementation LineChartViewController

CGFloat const kStatusBarHeight = 20.0;
CGFloat const kNavigationBarHeight = 44.0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat lineChartViewHeight = CGRectGetHeight(screenRect) - kStatusBarHeight - kNavigationBarHeight;
    CGRect lineChartViewRect = CGRectMake(0, 0, CGRectGetWidth(screenRect),  lineChartViewHeight);
    
    self.lineChartView = [[NTLineChartView alloc] initWithFrame:lineChartViewRect];
    self.lineChartView.dataSource = self;
    [self.view addSubview:self.lineChartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.lineChartView refreshWithFrame:self.view.bounds];
}

#pragma mark - NTLineChartViewDataSource

- (NSInteger)numberOfLinesInLineChartView:(NTLineChartView *)lineChartView
{
    return 1;
}

- (NSArray *)lineChartView:(NTLineChartView *)lineChartView dataForLineAtIndex:(NSInteger)index
{
    return @[];
}

@end
