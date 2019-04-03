//
//  UIBarButtonItem+YCBack.m
//  ychat
//
//  Created by 孙俊 on 2017/12/14.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIBarButtonItem+YCBack.h"

@implementation UIBarButtonItem (YCBack)

+ (id)fixItemSpace:(CGFloat)space
{
    UIBarButtonItem *fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fix.width = space;
    return fix;
}

- (id)initWithBackTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *view = [[UIButton alloc] init];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:kWhiteTextColor forState:UIControlStateNormal];
    view.titleLabel.font = kSystemFont15;
    [view setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
//    [view setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    if (self = [self initWithCustomView:view]) {
        if (IS_IOS_VERSION_11) {
            [view setFrame:CGRectMake(0, 0, 50, 34)];
        }else {
            view.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [view sizeToFit];
            CGRect frame = view.frame;
            frame.size.width = frame.size.width + kRealValue(10);
            view.frame = frame;
        }
    }
    return self;
}

- (id)initWithBlackBackTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *view = [[UIButton alloc] init];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view setImage:[UIImage imageNamed:@"back02_icon"] forState:UIControlStateNormal];
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:kBlackTextColor forState:UIControlStateNormal];
    view.titleLabel.font = kSystemFont15;
    [view setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 4)];
    [view setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    if (self = [self initWithCustomView:view]) {
        if (IS_IOS_VERSION_11) {
            [view setFrame:CGRectMake(0, 0, 75, 34)];
        }else {
            [view sizeToFit];
            CGRect frame = view.frame;
            frame.size.width = frame.size.width + kRealValue(10);
            view.frame = frame;
        }
    }
    return self;
}

- (id)initWithImage:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *view = [[UIButton alloc] init];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    view.backgroundColor = [UIColor yellowColor];
    if (self = [self initWithCustomView:view]) {
        if (IS_IOS_VERSION_11) {
            [view setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [view setFrame:CGRectMake(0, 0, 40, 40)];
        }else {
            [view sizeToFit];
        }
    }
    return self;
}

- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)color target:(id)target action:(SEL)action {
    UIButton *view = [[UIButton alloc] init];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    view.titleLabel.font = kSystemFont15;
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:color forState:UIControlStateNormal];
    [view sizeToFit];
    if (self = [self initWithCustomView:view]) {
        if (IS_IOS_VERSION_11) {
            [view setFrame:CGRectMake(0, 0, kRealValue(80), 44)];
            [view setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, kRealValue(10))];
        }
    }
    return self;
}


- (id)initWithareaBackTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *view = [[UIButton alloc] init];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [view setImage:[UIImage imageNamed:@"area_down"] forState:UIControlStateNormal];
    [view setTitle:title forState:UIControlStateNormal];
    [view setTitleColor:kWhiteTextColor forState:UIControlStateNormal];
    view.titleLabel.font = kSystemFont14;
    [view setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 4)];
    [view setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
    if (self = [self initWithCustomView:view]) {
        if (IS_IOS_VERSION_11) {
            [view setFrame:CGRectMake(0, 0, 75, 30)];
        }else {
            [view sizeToFit];
            CGRect frame = view.frame;
            frame.size.width = frame.size.width + kRealValue(10);
            view.frame = frame;
        }
    }
    return self;
}


@end
