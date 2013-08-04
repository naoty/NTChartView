//
//  NTLineChartView.m
//  NTChartView
//
//  Created by naoty on 2013/07/31.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NTLineChartView.h"
#import "NTLineChartArea.h"
#import "NTPoint.h"

@interface NTLineChartView ()

@property (nonatomic) NTLineChartArea *lineChartArea;

@property (nonatomic) float minXValue;
@property (nonatomic) float maxXValue;
@property (nonatomic) float minYValue;
@property (nonatomic) float maxYValue;

@end

@implementation NTLineChartView

const CGFloat kPaddingTop = 20.0;
const CGFloat kPaddingRight = 20.0;
const CGFloat kPaddingBottom = 30.0;
const CGFloat kPaddingLeft = 50.0;
const CGFloat kLabelHeight = 15.0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.maxXValue = 0;
        self.minXValue = 0;
        self.maxYValue = 0;
        self.minYValue = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect lineChartAreaRect = CGRectMake(kPaddingLeft, kPaddingTop, CGRectGetWidth(self.frame) - kPaddingLeft - kPaddingRight, CGRectGetHeight(self.frame) - kPaddingTop - kPaddingBottom);
    NSInteger numberOfLines = [self.dataSource numberOfLinesInLineChartView:self];
    self.lineChartArea = [[NTLineChartArea alloc] initWithFrame:lineChartAreaRect numberOfLines:numberOfLines];
    
    NSInteger index;
    for (index = 0; index < numberOfLines; index++) {
        NSArray *data = [self.dataSource lineChartView:self dataForLineAtIndex:index];
        for (NSArray *values in data) {
            float xValue = [values[0] floatValue];
            float yValue = [values[1] floatValue];
            
            self.maxXValue = MAX(xValue, self.maxXValue);
            self.minXValue = MIN(xValue, self.minXValue);
            self.maxYValue = MAX(yValue, self.maxYValue);
            self.minYValue = MIN(yValue, self.minYValue);
            
            NTPoint *point = [[NTPoint alloc] initWithXValue:xValue yValue:yValue];
            [self.lineChartArea addPoint:point atLineIndex:index];
        }
    }
    
    // Draw lines after all points are added, because coordinates of points are determined by
    // the largest and smallest x/y value of all points.
    for (index = 0; index < numberOfLines; index++) {
        [self.lineChartArea drawLineAtIndex:index];
    }
    
    [self addLabels];
    
    [self addSubview:self.lineChartArea];
}

- (void)addLabels
{
    for (int y = 0; y <= 4; y++) {
        float value = self.maxYValue * (4 - y) / 4 + self.minYValue;
        
        CATextLayer *labelLayer = [CATextLayer layer];
        labelLayer.contentsScale = [[UIScreen mainScreen] scale];
        labelLayer.string = [NSString stringWithFormat:@"%.1f", value];
        labelLayer.fontSize = 13;
        labelLayer.foregroundColor = [UIColor blackColor].CGColor;
        labelLayer.alignmentMode = kCAAlignmentRight;
        labelLayer.frame = CGRectMake(0, CGRectGetHeight(self.lineChartArea.frame) * y / 4 + kPaddingTop - kLabelHeight / 2, kPaddingLeft - 10, kLabelHeight);
        [self.layer addSublayer:labelLayer];
    }
    
    for (int x = 0; x <= 4; x++) {
        float value = self.maxXValue * x / 4 + self.minXValue;
        
        CATextLayer *labelLayer = [CATextLayer layer];
        labelLayer.contentsScale = [[UIScreen mainScreen] scale];
        labelLayer.string = [NSString stringWithFormat:@"%.1f", value];
        labelLayer.fontSize = 13;
        labelLayer.foregroundColor = [UIColor blackColor].CGColor;
        labelLayer.alignmentMode = kCAAlignmentCenter;
        labelLayer.frame = CGRectMake(CGRectGetWidth(self.lineChartArea.frame) * x / 4 + kPaddingLeft - kPaddingLeft / 2, CGRectGetHeight(self.frame) - kPaddingBottom + 5, kPaddingLeft, kLabelHeight);
        [self.layer addSublayer:labelLayer];
    }
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
