//
//  NTLineChartArea.m
//  NTChartView
//
//  Created by 金子 直人 on 2013/08/01.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTLineChartArea.h"
#import "NTLineChartView.h"
#import "NTPoint.h"
#import "UIColor+Hex.h"

@interface NTLineChartArea ()

@property (nonatomic) NSArray *colors;

@end

@implementation NTLineChartArea

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.points = [@[] mutableCopy];
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
    [self drawRules];
    [self drawAxes];
    [self drawLines];
}

- (void)drawAxes
{
    CGPoint originPoint = CGPointMake(0, CGRectGetHeight(self.frame));
    CGPoint xAxisEdgePoint = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGPoint yAxisEdgePoint = CGPointMake(0, 0);
    
    UIColor *color = [UIColor blackColor];
    
    [self drawLineFrom:originPoint to:xAxisEdgePoint width:2.0 color:color.CGColor];
    [self drawLineFrom:originPoint to:yAxisEdgePoint width:2.0 color:color.CGColor];
}

- (void)drawRules
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    UIColor *color = [UIColor colorWithHexString:@"#CCCCCC"];
    
    for (int y = 0; y < 4; y++) {
        CGPoint startPoint = CGPointMake(0, height * y / 4);
        CGPoint endPoint = CGPointMake(width, height * y / 4);
        [self drawLineFrom:startPoint to:endPoint width:1.0 color:color.CGColor];
    }
    
    for (int x = 1; x <= 4; x++) {
        CGPoint startPoint = CGPointMake(width * x / 4, 0);
        CGPoint endPoint = CGPointMake(width * x / 4, height);
        [self drawLineFrom:startPoint to:endPoint width:1.0 color:color.CGColor];
    }
}

- (void)drawLines
{
    NTLineChartView *parentView = (NTLineChartView *)self.superview;
    float maxXValue = parentView.maxXValue;
    float minXValue = parentView.minXValue;
    float maxYValue = parentView.maxYValue;
    float minYValue = parentView.minYValue;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    for (NSArray *pointsForLine in self.points) {
        NSInteger lineIndex = [self.points indexOfObject:pointsForLine];
        UIColor *color = self.colors[lineIndex % self.colors.count];
        
        for (NTPoint *point in pointsForLine) {
            [point setXByWidth:width max:maxXValue min:minXValue];
            [point setYByHeight:height max:maxYValue min:minYValue];
            
            NSInteger pointIndex = [pointsForLine indexOfObject:point];
            if (pointIndex > 0) {
                NTPoint *startPoint = pointsForLine[pointIndex - 1];
                [self drawLineFrom:startPoint.CGPoint to:point.CGPoint width:2.0 color:color.CGColor];
            }
        }
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
