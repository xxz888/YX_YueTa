//
//  BaseViewController.h
//  ManZhiYan3
//
//  Created by 姚兜兜 on 2018/5/4.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, assign) BOOL isCanBack;


/** 设置导航标题*/
- (void)setNavigationBarTitle:(NSString *)title;

/** 设置navigation文字颜色 */
- (void)setNavigationBarTitleColor:(UIColor *)color;

/**禁用边缘返回*/
-(void)forbiddenSideBack;
/**恢复边缘返回*/
- (void)resetSideBack;


@end
