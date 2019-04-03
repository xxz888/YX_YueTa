//
//  UIView+Line.m
//  CJYP
//
//  Created by 王吧 on 2018/5/26.
//  Copyright © 2018年 林森. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (Line)

- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)drawCircleDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.strokeColor = RGB(187, 187, 187).CGColor;
    borderLayer.fillColor = nil;
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:3].CGPath;
    borderLayer.frame = self.frame;
    borderLayer.lineWidth = 1.f;
    borderLayer.lineCap = @"square";
    borderLayer.lineDashPattern = @[@1, @5];
    
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:borderLayer];
}

@end
