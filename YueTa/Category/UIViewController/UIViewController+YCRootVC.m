//
//  UIViewController+YCRootVC.m
//  ychat
//
//  Created by 孙俊 on 2017/12/16.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIViewController+YCRootVC.h"
#import "BaseTabBarController.h"
#import "YTLoginController.h"
#import "BaseNavigationController.h"

@implementation UIViewController (YCRootVC)

- (void)turnToMainTabBarViewController {
    if ([kAppWindow.rootViewController isKindOfClass:[BaseTabBarController class]]) {
        BaseTabBarController *main = (BaseTabBarController *)kAppWindow.rootViewController;
        NSInteger index = main.selectedIndex;
        BaseNavigationController *selectedVC = main.childViewControllers[index];
        [selectedVC.topViewController.navigationController popViewControllerAnimated:YES];
    }else {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[BaseTabBarController alloc] init];
        CATransition * transition = [[CATransition alloc] init];
        transition.type = @"fade";
        transition.duration = 0.3;
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:nil];
    }
}

- (void)turnToLoginViewController {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[BaseNavigationController alloc] initWithRootViewController:[[YTLoginController alloc] init]];
    CATransition * transition = [[CATransition alloc] init];
    transition.type = @"fade";
    transition.duration = 0.3;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:nil];
}

- (void)removeNavigationControllersWithControllerName:(NSString *)controllerName {
    NSMutableArray *marr = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    for (UIViewController * controller in self.navigationController.viewControllers) {
        NSString *className =NSStringFromClass([controller class]);
        NSLog(@"--class--%@",className);
        if([controller isKindOfClass:NSClassFromString(controllerName)]){
            [marr removeObject:controller];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
}

- (UIViewController *)navgationContainsViewController:(NSString *)controllerName {
//    NSMutableArray *marr = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    for (UIViewController * controller in self.navigationController.viewControllers) {
        NSString *className =NSStringFromClass([controller class]);
        NSLog(@"--class--%@",className);
        if([controller isKindOfClass:NSClassFromString(controllerName)]){
            return controller;
        }
    }
    return nil;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)currentViewController {
    
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;

    
//    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    
//    if ([viewController isKindOfClass:[UITabBarController class]]) {
//        if ( [(UITabBarController *)viewController selectedViewController].presentedViewController) {
//            return [(UITabBarController *)viewController selectedViewController].presentedViewController;
//        }
//        return [(UITabBarController *)viewController selectedViewController];
//    }else if ([viewController isKindOfClass:[UINavigationController class]]) {
//        return [(UINavigationController *)viewController topViewController];
//    }else {
//        return viewController;
//    }
}

#pragma mark -隐藏TabBar
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

#pragma mark -显示TabBar
- (void)showTabBar {
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}

@end
