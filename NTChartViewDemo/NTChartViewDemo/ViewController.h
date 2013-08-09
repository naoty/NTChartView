//
//  ViewController.h
//  NTChartViewDemo
//
//  Created by naoty on 2013/07/31.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTLineChartView.h"

@interface ViewController : UIViewController <NTLineChartViewDataSource>

@property (nonatomic) NTLineChartView *lineChartView;

@end
