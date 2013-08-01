//
//  NTPoint.h
//  NTChartView
//
//  Created by naoty on 2013/08/02.
//  Copyright (c) 2013年 Naoto Kaneko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NTPoint : NSObject

@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic) float xValue;
@property (nonatomic) float yValue;
@property (nonatomic, readonly) CGPoint CGPoint;

- (id)initWithXValue:(float)xValue yValue:(float)yValue;
- (void)setXByWidth:(CGFloat)width max:(float)max min:(float)min;
- (void)setYByHeight:(CGFloat)height max:(float)max min:(float)min;

@end
