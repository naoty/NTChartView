//
//  NTLineChartView.m
//  NTChartView
//
//  Created by naoty on 2013/07/31.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTLineChartView.h"
#import "NTLineChartArea.h"

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
    NTLineChartArea *lineChartArea = [[NTLineChartArea alloc] initWithFrame:lineChartAreaRect];
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
