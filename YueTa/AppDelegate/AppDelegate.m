//
//  AppDelegate.m
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/20.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Services.h"
#import "UserInterface.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initAmapSDK];
    
    [self initWindow];
    
    [self initMainViewController];
    
    EMOptions *option = [EMOptions optionsWithAppkey:HUANXINAPPKEY];
//    option.apnsCertName = APNSNAME;
    
    __block EMError *error = [[EMClient sharedClient]initializeSDKWithOptions:option];
    if (!error) {
        NSLog(@"初始化成功");
    }
    
    if ([UserInfoManager sharedInstance].token.length) {
        [UserInterface getHuanXinInfoByAimId:[UserInfoManager sharedInstance].ID andBlock:^(ResponseMessage * _Nonnull rspStatusAndMessage, NSString * _Nonnull ID, NSString * _Nonnull password) {
            if (ID.length
                && password.length) {
                error = [[EMClient sharedClient]loginWithUsername:ID password:password];
                if (!error) {
                    NSLog(@"登录成功");
                } else {
                    NSLog(@"%@",error.errorDescription);
                }
            }
        }];
    }
    return YES;
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


@end
