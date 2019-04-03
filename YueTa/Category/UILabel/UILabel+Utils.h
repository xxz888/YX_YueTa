//
//  UILabel+Utils.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)

/**
 *  设置label
 *
 *  @param labelName label.text
 *  @param font font
 *  @param color color
 *  @param textAlignment textAlignment
 */
+ (UILabel *)labelWithName:(NSString *)labelName Font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;

//两端对齐
- (void)textAlignmentLeftAndRight;

//指定Label的width两端对齐
- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth;

- (void)changeLineSpaceWithSpace:(CGFloat)space textAlignment:(NSTextAlignment)textAlignment;

@end
