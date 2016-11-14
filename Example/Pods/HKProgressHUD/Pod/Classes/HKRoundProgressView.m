//
//  HKRoundProgressView.m
//  HKProgressHUD
//
//  Created by Harley.xk on 15/12/15.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "HKRoundProgressView.h"

@implementation HKRoundProgressView

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{    
    UIColor *backgroundColor = self.lineBackgroundColor;
    UIColor *lineColor = self.tintColor;
    
    CGFloat lineWidth = 2.f;
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = lineWidth;
    processBackgroundPath.lineCapStyle = kCGLineCapRound;
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = (self.bounds.size.width - lineWidth)/2;
    CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [backgroundColor set];
    [processBackgroundPath stroke];
    // Draw progress
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapRound;
    processPath.lineWidth = lineWidth;
    endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [lineColor set];
    [processPath stroke];
}


@end
