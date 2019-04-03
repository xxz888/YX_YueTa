//
//  UIButton+Utils.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Utils)

+ (UIButton *)buttonWithBackgroundImage:(NSString *)imageName taget:(id)taget action:(SEL)action;

+ (UIButton *)buttonWithImage:(NSString *)imageName taget:(id)taget action:(SEL)action;

+ (UIButton *)buttonWithTitle:(NSString *)title taget:(id)taget action:(SEL)action font:(UIFont *)titleFont titleColor:(UIColor *)titleColor;

//竖排，图片在上，文字在下
- (void)verticalImageAndTitle:(CGFloat)spacing;

//横排，图片在右，文字在左
- (void)horizontalTitleAndImage:(CGFloat)spacing;

//横排，图片在左，文字在又
- (void)horizontalImageAndTitle:(CGFloat)spacing;

@end
