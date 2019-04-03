//
//  UIView+HXRedPoint.m
//  HXBaseProjectDemo
//
//  Created by GDD on 2017/7/19.
//  Copyright © 2017年 盖丹丹. All rights reserved.
//

#import "UIView+HXRedPoint.h"

@implementation UIView (HXRedPoint)

//添加显示
- (void)showRedAtOffSetX:(float)offsetX AndOffSetY:(float)offsetY OrValue:(NSString *)value labelFont:(UIFont *)labelfont pointWideth:(CGFloat)pointWidth{
    [self removeRedPoint];//添加之前先移除，避免重复添加
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 998;
    
    CGFloat viewWidth;
    
    if (pointWidth == 0) {
        viewWidth = 12;
    }else{
        viewWidth = pointWidth;
    }
    
    
    if (value) {
       // viewWidth = 18;
        UILabel *valueLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
        valueLbl.text = value;
        valueLbl.font = labelfont;
        valueLbl.textColor = [UIColor whiteColor];
        valueLbl.textAlignment = NSTextAlignmentCenter;
        valueLbl.clipsToBounds = YES;
        [badgeView addSubview:valueLbl];
    }
    
    badgeView.layer.cornerRadius = viewWidth / 2;
    badgeView.backgroundColor = kRedBackgroundColor;
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    if (offsetX == 0) {
        offsetX = 1;
    }
    
    if (offsetY == 0) {
        offsetY = 0.05;
    }
    CGFloat x = ceilf(tabFrame.size.width + offsetX);
    CGFloat y = ceilf(offsetY);
    
    badgeView.frame = CGRectMake(x, y, viewWidth, viewWidth);
    [self addSubview:badgeView];
}

//隐藏
- (void)hideRedPoint{
    [self removeRedPoint];
}

//移除
- (void)removeRedPoint{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 998) {
            [subView removeFromSuperview];
        }
    }
}
- (BOOL)isHaveRedPoint{
    for (UIView *subView in self.subviews) {
        if (subView.tag == 998) {
            return YES;
        }
    }
    return NO;
}
@end
