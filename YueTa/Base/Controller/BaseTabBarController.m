//
//  BaseTabBarController.m
//  ManZhiYan3
//
//  Created by 姚兜兜 on 2018/5/10.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "YDXTabBar.h"

#import "YTNearController.h"
#import "YTSquareController.h"
#import "YTPublishController.h"
#import "YTMessageController.h"
#import "YTMineController.h"
#import "YTPostAppointmentViewController.h"

@interface BaseTabBarController ()<YDXTabBarDelegate>

@property (nonatomic,strong) YDXTabBar * ydxTabbar;

@end

@implementation BaseTabBarController

+ (BaseTabBarController *)shareInstance {
    static BaseTabBarController *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载控制器
    [self confinViewController];
    
    //加载tabbar
    [self.tabBar addSubview:self.ydxTabbar];
}


- (void)confinViewController {
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"YTNearController",
                                                              @"YTSquareController",
                                                              @"YTPublishController",
                                                              @"YTMessageController",
                                                              @"YTMineController"]];
    
    for (NSInteger i = 0; i < array.count; i ++) {
        NSString * vcName = array[i];
        
        UIViewController * vc = [[NSClassFromString(vcName) alloc] init];
        
        BaseNavigationController * nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [array replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers = array;
}

#pragma mark - setter
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    if (selectedIndex == self.ydxTabbar.lastItem.tag-YDXBarItemNear) {
        return;
    }
    for (UIView *view in _ydxTabbar.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag == YDXBarItemNear+selectedIndex) {
            UIButton *button = (UIButton *)view;
            [self.ydxTabbar setupNextItemStyle:button];
        }
    }
}


#pragma mark - YDXTabBarDelegate
- (void)tabBar:(YDXTabBar *)tabBar clickButton:(YDXBarItemType)index {
    /*
     选中中间的发布，不做tabbar的切换的，选择当前的tabbar的页面 推出发布页面
     */
    if (index == YDXBarItemPublish) {
        YTPostAppointmentViewController *vc = [[YTPostAppointmentViewController alloc] init];
        [[UIViewController currentViewController].navigationController pushViewController:vc animated:YES];
    } else {
        self.selectedIndex = index - YDXBarItemNear;
    }
}

#pragma mark - lazy init
- (YDXTabBar *)ydxTabbar {
    if (!_ydxTabbar) {
        _ydxTabbar = [[YDXTabBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTabBarHeight)];
        _ydxTabbar.delegate = self;
    }
    return _ydxTabbar;
}



@end
