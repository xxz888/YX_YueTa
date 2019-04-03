//
//  UIButton+Utils.m
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)

+ (UIButton *)buttonWithBackgroundImage:(NSString *)imageName taget:(id)taget action:(SEL)action{
    UIButton * button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithImage:(NSString *)imageName taget:(id)taget action:(SEL)action {
    UIButton * button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title taget:(id)taget action:(SEL)action font:(UIFont *)titleFont titleColor:(UIColor *)titleColor {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//竖排，图片在上，文字在下
- (void)verticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

//横排，图片在右，文字在左
- (void)horizontalTitleAndImage:(CGFloat)spacing{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width+spacing), 0, imageSize.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width, 0, -titleSize.width);
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

//横排，图片在左，文字在又
- (void)horizontalImageAndTitle:(CGFloat)spacing{
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

@end
