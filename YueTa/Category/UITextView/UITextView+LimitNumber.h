//
//  UITextView+LimitNumber.h
//  XLLife
//
//  Created by GDD on 2017/11/20.
//  Copyright © 2017年 jinqiangxinxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LimitNumber)

/**
 限制textfiled的字符长度
 @param LimitCharacter 长度最大值
 */
- (void)LimitCharacterWithInteger:(NSInteger )LimitCharacter;

@end
