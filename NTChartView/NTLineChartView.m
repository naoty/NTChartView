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
    CGFloat areaWidth = CGRectGetWidth(self.frame) - kPaddingLeft - kPaddingRight;
    CGFloat areaHeight = CGRectGetHeight(self.frame) - kPaddingTop - kPaddingBottom;
    self.lineChartArea = [[NTLineChartArea alloc] initWithFrame:CGRectMake(kPaddingLeft, kPaddingTop, areaWidth, areaHeight)];
    [self addSubview:self.lineChartArea];
    
    NSInteger lineIndex;
    NSInteger numberOfLines = [self.dataSource numberOfLinesInLineChartView:self];
    for (lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        self.lineChartArea.points[lineIndex] = [@[] mutableCopy];
        NSArray *data = [self.dataSource lineChartView:self dataForLineAtIndex:lineIndex];
        for (NSArray *values in data) {
            float xValue = [values[0] floatValue];
            float yValue = [values[1] floatValue];
            
            // these values are used to determine coordinates of points.
            self.maxXValue = MAX(xValue, self.maxXValue);
            self.minXValue = MIN(xValue, self.minXValue);
            self.maxYValue = MAX(yValue, self.maxYValue);
            self.minYValue = MIN(yValue, self.minYValue);
            
            NTPoint *point = [[NTPoint alloc] initWithXValue:xValue yValue:yValue];
            [self.lineChartArea.points[lineIndex] addObject:point];
        }
    }
    
    [self addLabels];
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

@end
