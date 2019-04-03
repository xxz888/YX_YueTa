//
//  BaseNavigationController.m
//  ManZhiYan3
//
//  Created by 姚兜兜 on 2018/5/4.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureNav];
}

- (void)configureNav {
    //导航背景色和字体颜色
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:kSystemFont18}];
    if (kDevice_Is_iPhoneX) {
        UIImage *bgImage = [[UIImage imageNamed:@"navigation_bg_x"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
        [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    } else {
        UIImage *bgImage = [[UIImage imageNamed:@"navigation_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
        [[UINavigationBar appearance] setBackgroundImage:KimageName(@"navigation_bg") forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) { // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        if ([self.childViewControllers lastObject] == viewController) {
            return;
        }
        
        //自定义返回按钮
        if (IS_IOS_VERSION_11) {
            if ([viewController isKindOfClass:[BaseViewController class]]) {
                BaseViewController *baseVc = (BaseViewController *)viewController;
                baseVc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"navigation_back" target:self action:@selector(back)];
            } else {
                viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"navigation_back" target:self action:@selector(back)];
            }
        } else {
            if ([viewController isKindOfClass:[BaseViewController class]]) {
                BaseViewController *baseVc = (BaseViewController *)viewController;
                baseVc.navigationItem.leftBarButtonItems = @[[UIBarButtonItem fixItemSpace:-6], [[UIBarButtonItem alloc] initWithImage:@"navigation_back" target:self action:@selector(back)]];
            } else {
                viewController.navigationItem.leftBarButtonItems = @[[UIBarButtonItem fixItemSpace:-6], [[UIBarButtonItem alloc] initWithImage:@"navigation_back" target:self action:@selector(back)]];
            }
        }
        //如果自定义返回按钮后, 滑动返回可能失效, 需要添加下面的代码
        self.interactivePopGestureRecognizer.enabled = YES;
        __weak typeof(viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - **************** Events
- (void)back {
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self popViewControllerAnimated:YES];
    }
}


#pragma mark - 子导航与父导航配置相同
- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return self.topViewController.prefersStatusBarHidden;
}


@end
