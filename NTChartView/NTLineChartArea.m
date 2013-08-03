//
//  NTLineChartArea.m
//  NTChartView
//
//  Created by 金子 直人 on 2013/08/01.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTLineChartArea.h"
#import "NTPoint.h"
#import "UIColor+Hex.h"

@interface NTLineChartArea ()

@property (nonatomic) CGPoint originPoint;
@property (nonatomic) NSMutableArray *points;
@property (nonatomic) float minXValue;
@property (nonatomic) float maxXValue;
@property (nonatomic) float minYValue;
@property (nonatomic) float maxYValue;
@property (nonatomic) NSArray *colors;

@end

@implementation NTLineChartArea

- (id)initWithFrame:(CGRect)frame numberOfLines:(NSInteger)number
{
    self = [super initWithFrame:frame];
    if (self) {
        self.points = [@[] mutableCopy];
        for (int i = 0; i < number; i++) {
            [self.points addObject:[@[] mutableCopy]];
        }
        
        self.minXValue = 0;
        self.maxXValue = 0;
        self.minYValue = 0;
        self.maxYValue = 0;
        
        self.colors = @[
            [UIColor colorWithHexString:@"#3366CC"],
            [UIColor colorWithHexString:@"#DC3912"],
            [UIColor colorWithHexString:@"#FF9900"],
            [UIColor colorWithHexString:@"#990099"],
            [UIColor colorWithHexString:@"#0099C6"],
            [UIColor colorWithHexString:@"#DD4477"],
            [UIColor colorWithHexString:@"#316395"]
        ];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.originPoint = CGPointMake(0, CGRectGetMaxY(rect));
    [self drawAxes];
    [self drawRules];
}

- (void)drawAxes
{
    CGPoint xAxisEdgePoint = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGPoint yAxisEdgePoint = CGPointMake(0, 0);
    
    UIColor *color = [UIColor blackColor];
    
    [self drawLineFrom:self.originPoint to:xAxisEdgePoint width:2.0f color:color.CGColor];
    [self drawLineFrom:self.originPoint to:yAxisEdgePoint width:2.0f color:color.CGColor];
}

- (void)drawRules
{
    UIColor *color = [UIColor colorWithHexString:@"#CCCCCC"];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    for (int i = 0; i < 4; i++) {
        CGPoint startPoint = CGPointMake(0, height * i / 4);
        CGPoint endPoint = CGPointMake(width, height * i / 4);
        [self drawLineFrom:startPoint to:endPoint width:1.0f color:color.CGColor];
    }
    
    for (int i = 1; i <= 4; i++) {
        CGPoint startPoint = CGPointMake(width * i / 4, height);
        CGPoint endPoint = CGPointMake(width * i / 4, 0);
        [self drawLineFrom:startPoint to:endPoint width:1.0f color:color.CGColor];
    }
}

- (void)addPoint:(NTPoint *)point atLineIndex:(NSInteger)index
{
    [self.points[index] addObject:point];
    
    // these values are used to convert values of data into coordinates of points.
    self.minXValue = MIN(point.xValue, self.minXValue);
    self.maxXValue = MAX(point.xValue, self.maxXValue);
    self.minYValue = MIN(point.yValue, self.minYValue);
    self.maxYValue = MAX(point.yValue, self.maxYValue);
}

- (void)drawLineAtIndex:(NSInteger)index
{
    UIColor *color = self.colors[index % self.colors.count];
    
    NSMutableArray *pointsForLine = self.points[index];
    for (NTPoint *point in pointsForLine) {
        // convert data into coordinate
        [point setXByWidth:CGRectGetWidth(self.frame) max:self.maxXValue min:self.minXValue];
        [point setYByHeight:CGRectGetHeight(self.frame) max:self.maxYValue min:self.minYValue];
        
        NSInteger pointIndex = [pointsForLine indexOfObject:point];
        if (pointIndex > 0) {
            NTPoint *startPoint = pointsForLine[pointIndex - 1];
            [self drawLineFrom:startPoint.CGPoint to:point.CGPoint width:2.0f color:color.CGColor];
        }
    }
}

@end
