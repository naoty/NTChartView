//
//  NTLineChartView.m
//  NTChartView
//
//  Created by naoty on 2013/07/31.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTLineChartView.h"
#import "NTLineChartArea.h"
#import "NTPoint.h"

@implementation NTLineChartView

const CGFloat kLineChartViewPadding = 30.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect lineChartAreaRect = CGRectInset(rect, kLineChartViewPadding, kLineChartViewPadding);
    NSInteger numberOfLines = [self.dataSource numberOfLinesInLineChartView:self];
    NTLineChartArea *lineChartArea = [[NTLineChartArea alloc] initWithFrame:lineChartAreaRect numberOfLines:numberOfLines];
    
    NSInteger index;
    for (index = 0; index < numberOfLines; index++) {
        NSArray *data = [self.dataSource lineChartView:self dataForLineAtIndex:index];
        for (NSArray *values in data) {
            NTPoint *point = [[NTPoint alloc] initWithXValue:[values[0] floatValue] yValue:[values[1] floatValue]];
            [lineChartArea addPoint:point atLineIndex:index];
        }
    }
    
    // Draw lines after all points are added, because coordinates of points are determined by
    // the largest and smallest x/y value of all points.
    for (index = 0; index < numberOfLines; index++) {
        [lineChartArea drawLineAtIndex:index];
    }
    
    [self addSubview:lineChartArea];
}

- (void)drawLineFrom:(CGPoint)startPoint to:(CGPoint)endPoint width:(CGFloat)width color:(CGColorRef)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, width);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}

@end
