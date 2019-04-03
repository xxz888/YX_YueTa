//
//  UIView+Line.h
//  CJYP
//
//  Created by 王吧 on 2018/5/26.
//  Copyright © 2018年 林森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Line)

/**
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/

- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;


/**
 边框虚线

 @param lineLength 虚线宽度
 @param lineSpacing 虚线间距
 @param lineColor 虚线颜色
 */
- (void)drawCircleDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end
