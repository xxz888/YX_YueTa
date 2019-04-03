//
//  AppDelegate+Services.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/20.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "AppDelegate+Services.h"
#import "BaseTabBarController.h"
#import "YTLoginController.h"
#import "BaseNavigationController.h"

#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation AppDelegate (Services)

- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (void)initMainViewController {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([UserInfoManager sharedInstance].token.length) {
        BaseTabBarController *tabbarVc = [BaseTabBarController shareInstance];
        self.window.rootViewController = tabbarVc;
    } else {
        YTLoginController *loginVc = [[YTLoginController alloc] init];
        BaseNavigationController *navLogin = [[BaseNavigationController alloc] initWithRootViewController:loginVc];
        self.window.rootViewController = navLogin;
    }  
}

- (void)initAmapSDK {
    [[AMapServices sharedServices] setApiKey:kAmapApiKey];
}

@end
