//
//  UIView+YCScreenShoot.h
//  ychat
//
//  Created by 孙俊 on 2017/12/21.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YCScreenShoot)

/**
 *  截屏
 *
 *  线程安全的
 */
- (UIImage *)captureImage;


@end
