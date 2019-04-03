//
//  MZYUITextField.m
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/5.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "MZYTextField.h"

@implementation MZYTextField

/**
 重写左视图 leftView 的 x 位置
 */
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += kRealValue(10);
    return textRect;
}

/**
 重写文本视图的 x 位置
 */
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += kRealValue(10);
    return textRect;
}

/**
 重写文本视图编辑时的 x 位置
 */
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += kRealValue(10);
    return textRect;
}

@end
