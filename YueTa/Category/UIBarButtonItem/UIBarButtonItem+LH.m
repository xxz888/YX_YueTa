//
//  UIBarButtonItem+LH.m
//  CJYP
//
//  Created by 蓝海 on 2018/9/15.
//  Copyright © 2018年 林森. All rights reserved.
//

#import "UIBarButtonItem+LH.h"

@implementation UIBarButtonItem (LH)

+ (instancetype)initWithImage:(UIImage *)normalImage SeletedImage:(UIImage *)selectedImage Target:(id)target Action:(SEL)action{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:normalImage forState:UIControlStateNormal];
    if (selectedImage) {
        
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
    
}
@end
