//
//  UIViewController+YCRootVC.h
//  ychat
//
//  Created by 孙俊 on 2017/12/16.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YCRootVC)

- (void)turnToMainTabBarViewController;

- (void)turnToLoginViewController;

+ (UIViewController *)currentViewController;

/// 移除导航中的某个控制器
- (void)removeNavigationControllersWithControllerName:(NSString *)controllerName;

/// 某个控制器是否在导航中
- (UIViewController *)navgationContainsViewController:(NSString *)controllerName;


- (void)showTabBar;

- (void)hideTabBar;

@end
