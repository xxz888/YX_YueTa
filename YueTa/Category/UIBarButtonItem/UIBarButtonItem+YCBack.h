//
//  UIBarButtonItem+YCBack.h
//  ychat
//
//  Created by 孙俊 on 2017/12/14.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YCBack)

+ (id)fixItemSpace:(CGFloat)space;

/** 带有返回图片的返回按钮*/
- (id)initWithBackTitle:(NSString *)title target:(id)target action:(SEL)action;
/** 带有返回图片的返回按钮*/
- (id)initWithBlackBackTitle:(NSString *)title target:(id)target action:(SEL)action;
/** 只有图片的返回按钮*/
- (id)initWithImage:(NSString *)imageName target:(id)target action:(SEL)action;
/** 只有返回文字的返回按钮*/
- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)action;

- (id)initWithareaBackTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
