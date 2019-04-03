//
//  UIView+HXRedPoint.h
//  HXBaseProjectDemo
//
//  Created by GDD on 2017/7/19.
//  Copyright © 2017年 黄轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXRedPoint)

- (void)showRedAtOffSetX:(float)offsetX AndOffSetY:(float)offsetY OrValue:(NSString *)value labelFont:(UIFont *)labelfont pointWideth:(CGFloat)pointWidth;

- (void)hideRedPoint;

- (BOOL)isHaveRedPoint;
@end
