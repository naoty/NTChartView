//
//  NTLineChartArea.m
//  NTChartView
//
//  Created by 金子 直人 on 2013/08/01.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTLineChartArea.h"

@implementation NTLineChartArea

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    _originPoint = CGPointMake(0, self.frame.size.height);
    [self drawAxis];
}

- (void)drawAxis
{
    CGPoint xAxisEdgePoint = CGPointMake(self.frame.size.width, self.frame.size.height);
    CGPoint yAxisEdgePoint = CGPointMake(0, 0);
    
    UIColor *color = [UIColor blackColor];
    
    [self drawLineFrom:_originPoint to:xAxisEdgePoint width:1.0f color:color.CGColor];
    [self drawLineFrom:_originPoint to:yAxisEdgePoint width:1.0f color:color.CGColor];
}

@end
