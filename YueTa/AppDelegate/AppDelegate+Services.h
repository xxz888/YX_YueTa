//
//  AppDelegate+Services.h
//  YueTa
//
//  Created by 姚兜兜 on 2018/12/20.
//  Copyright © 2018 姚兜兜. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Services)

/**
 初始化 window
 */
- (void)initWindow;

/**
 初始化 viewController
 */
- (void)initMainViewController;

/**
 初始化 高德地图
 */
- (void)initAmapSDK;


@end

NS_ASSUME_NONNULL_END
