//
//  NTPoint.m
//  NTChartView
//
//  Created by naoty on 2013/08/02.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import "NTPoint.h"

@implementation NTPoint

- (id)initWithXValue:(float)xValue yValue:(float)yValue
{
    self = [super init];
    if (self) {
        self.xValue = xValue;
        self.yValue = yValue;
    }
    return self;
}

- (CGPoint)CGPoint
{
    return CGPointMake(self.x, self.y);
}

- (void)setXByWidth:(CGFloat)width margin:(float)margin max:(float)max min:(float)min
{
    _x = [self map:self.xValue fromMax:max fromMin:min toMax:width + margin toMin:margin];
}

- (void)setYByHeight:(CGFloat)height margin:(float)margin max:(float)max min:(float)min
{
    _y = [self map:self.yValue fromMax:max fromMin:min toMax:margin toMin:height + margin];
}

- (CGFloat)map:(CGFloat)value fromMax:(CGFloat)fromMax fromMin:(CGFloat)fromMin toMax:(CGFloat)toMax toMin:(CGFloat)toMin
{
    return (value - fromMin) * (toMax - toMin) / (fromMax - fromMin) + toMin;
}

@end
