//
//  UtilsMacro.h
//  ychat
//
//  Created by 孙俊 on 2017/12/3.
//  Copyright © 2017年 Sun. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

///IOS版本判断
#define IOSAVAILABLEVERSION(version)    ([[UIDevice currentDevice]availableVersion:version]< 0)
#define kCurrentBoudleName              [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleName"]
#define kCurrentBuildVersion            [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]
#define kCurrentVersion                 [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
//当前系统版本
#define kCurrentSystemVersion           [[UIDevice currentDevice].systemVersion doubleValue]
//是否是iOS11
#define IS_IOS_VERSION_11 (([[[UIDevice currentDevice]systemVersion]floatValue] >= 11.0)? (YES):(NO))

//是否是iPhoneX
#define SafeArea_Top UIApplication.sharedApplication.windows[0].safeAreaInsets.top
#define SafeArea_Bottom UIApplication.sharedApplication.windows[0].safeAreaInsets.bottom
//#define kDevice_Is_iPhoneX  (@available(iOS 11.0, *) ? (SafeArea_Top == 44 && SafeArea_Bottom == 34) : NO)
#define kDevice_Is_iPhoneX ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0 ? YES : NO)

//StatusBar高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//在其他型号的iPhone上StatusBar是20 在iPhone X上StatusBar的高度是44，
#define kNavBarHeight (kDevice_Is_iPhoneX ? 88 : 64)
#define kTabBarHeight (kDevice_Is_iPhoneX ? 83 : 49)

//获取屏幕宽高
#define kMainScreen_width [[UIScreen mainScreen] bounds].size.width
#define kMainScreen_height [[UIScreen mainScreen] bounds].size.height
#define kMainScreen_Bounds [UIScreen mainScreen].bounds

//根据ip6的屏幕来拉伸
#define kRealValue(with)                ((with)*(kMainScreen_width/375.0f))

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

//字体
#define SystemFont(float)               [UIFont systemFontOfSize:(float)]
//字体加粗
#define SystemFontBold(float)           [UIFont boldSystemFontOfSize:(float)]

//图片相关
#define KimageName(name)                [UIImage imageNamed:name]


//-------------------打印日志-------------------------
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#endif /* UtilsMacro_h */
