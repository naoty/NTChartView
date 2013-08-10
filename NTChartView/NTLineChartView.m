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
@property (nonatomic) NTLineChartXAxisDataType xAxisDataType;
@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation NTLineChartView

const CGFloat kPaddingTop = 20.0;
const CGFloat kPaddingRight = 20.0;
const CGFloat kPaddingBottom = 30.0;
const CGFloat kPaddingLeft = 50.0;
const CGFloat kLabelHeight = 15.0;
NSString * const kLabelName = @"NTLineChartViewLabel";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.maxXValue = -INFINITY;
        self.minXValue = INFINITY;
        self.maxYValue = -INFINITY;
        self.minYValue = INFINITY;
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
        [self setXAxisDataTypeWithData:data];
        for (NSArray *values in data) {
            double xValue = [self correctValue:values[0]];
            double yValue = [self correctValue:values[1]];
            
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

- (void)refreshWithFrame:(CGRect)frame
{
    self.frame = frame;
    
    // Remove lineChartArea and labels.
    NSArray *sublayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer *sublayer in sublayers) {
        if ([sublayer.name compare:kLabelName] == NSOrderedSame) {
            [sublayer removeFromSuperlayer];
        }
    }
    [self.lineChartArea removeFromSuperview];
    
    [self setNeedsDisplay];
}

#pragma mark - Local methods

- (void)addLabels
{
    for (int y = 0; y <= 4; y++) {
        float value = self.maxYValue * (4 - y) / 4 + self.minYValue;
        
        CATextLayer *labelLayer = [CATextLayer layer];
        labelLayer.name = kLabelName;
        labelLayer.contentsScale = [[UIScreen mainScreen] scale];
        labelLayer.string = [NSString stringWithFormat:@"%.1f", value];
        labelLayer.fontSize = 13;
        labelLayer.foregroundColor = [UIColor blackColor].CGColor;
        labelLayer.alignmentMode = kCAAlignmentRight;
        labelLayer.frame = CGRectMake(0, CGRectGetHeight(self.lineChartArea.frame) * y / 4 + kPaddingTop - kLabelHeight / 2, kPaddingLeft - 10, kLabelHeight);
        [self.layer addSublayer:labelLayer];
    }
    
    for (int x = 0; x <= 4; x++) {
        CATextLayer *labelLayer = [CATextLayer layer];
        labelLayer.name = kLabelName;
        labelLayer.contentsScale = [[UIScreen mainScreen] scale];
        labelLayer.fontSize = 13;
        labelLayer.foregroundColor = [UIColor blackColor].CGColor;
        labelLayer.alignmentMode = kCAAlignmentCenter;
        labelLayer.frame = CGRectMake(CGRectGetWidth(self.lineChartArea.frame) * x / 4 + kPaddingLeft - kPaddingLeft / 2, CGRectGetHeight(self.frame) - kPaddingBottom + 5, kPaddingLeft, kLabelHeight);
        
        if (self.xAxisDataType == NTLineChartXAxisDataTypeDate) {
            double value = (self.maxXValue - self.minXValue) * x / 4 + self.minXValue;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:value];
            labelLayer.string = [self.dateFormatter stringFromDate:date];
        } else {
            float value = self.maxXValue * x / 4 + self.minXValue;
            labelLayer.string = [NSString stringWithFormat:@"%.1f", value];
        }
        
        [self.layer addSublayer:labelLayer];
    }
}

- (void)setXAxisDataTypeWithData:(NSArray *)data
{
    id xValue = data[0][0];
    if ([xValue isKindOfClass:[NSDate class]]) {
        self.xAxisDataType = NTLineChartXAxisDataTypeDate;
        
        NSDate *xValue1 = (NSDate *)xValue;
        NSDate *xValue2 = (NSDate *)data[1][0];
        NSTimeInterval interval = [xValue2 timeIntervalSinceDate:xValue1];
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        if (interval > 1 * 60 * 60) {
            self.dateFormatter.dateFormat = @"MM/dd";
        } else {
            self.dateFormatter.dateFormat = @"HH:mm";
        }
    } else {
        self.xAxisDataType = NTLineChartXAxisDataTypeNumber;
    }
}

- (double)correctValue:(id)value
{
    if ([value isKindOfClass:[NSDate class]]) {
        return [value timeIntervalSince1970];
    } else {
        return [value floatValue];
    }
}

@end
