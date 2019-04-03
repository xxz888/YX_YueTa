//
//  UIView+YCScreenShoot.m
//  ychat
//
//  Created by 孙俊 on 2017/12/21.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIView+YCScreenShoot.h"

@implementation UIView (YCScreenShoot)

- (UIImage *)captureImage
{
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

@end
