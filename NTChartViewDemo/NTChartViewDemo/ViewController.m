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
    return 8;
}

- (NSArray *)lineChartView:(NTLineChartView *)lineChartView dataForLineAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return @[@[@0, @0], @[@1, @1], @[@2, @2]];
            break;
        case 1:
            return @[@[@0, @0], @[@1, @2], @[@2, @4]];
            break;
        case 2:
            return @[@[@0, @0], @[@1, @3], @[@2, @6]];
            break;
        case 3:
            return @[@[@0, @0], @[@1, @4], @[@2, @8]];
            break;
        case 4:
            return @[@[@0, @0], @[@1, @5], @[@2, @10]];
            break;
        case 5:
            return @[@[@0, @0], @[@1, @6], @[@2, @12]];
            break;
        case 6:
            return @[@[@0, @0], @[@1, @7], @[@2, @14]];
            break;
        case 7:
            return @[@[@0, @0], @[@1, @8], @[@2, @16]];
            break;
            
        default:
            return @[];
            break;
    }
}

@end
