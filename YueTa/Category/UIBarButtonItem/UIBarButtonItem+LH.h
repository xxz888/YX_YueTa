//
//  UIBarButtonItem+LH.h
//  CJYP
//
//  Created by 蓝海 on 2018/9/15.
//  Copyright © 2018年 林森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LH)
+ (instancetype)initWithImage:(UIImage *)normalImage SeletedImage:(UIImage *)selectedImage Target:(id)target Action:(SEL)action;
@end
