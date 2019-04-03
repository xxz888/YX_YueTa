//
//  YDXTabBar.h
//  ydx-inke
//
//  Created by LIN on 16/10/23.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,YDXBarItemType) {
    YDXBarItemNear = 100,    //附近
    YDXBarItemSquare = 101,  //广场
    YDXBarItemPublish = 102, //发布
    YDXBarItemMessage = 103, //消息
    YDXBarItemMine = 104,    //我的
};

@class YDXTabBar;

@protocol YDXTabBarDelegate <NSObject>

- (void)tabBar:(YDXTabBar *)tabBar clickButton:(YDXBarItemType)index;

@end

@interface YDXTabBar : UIView

@property (nonatomic, weak) id<YDXTabBarDelegate> delegate;

@property (nonatomic, strong) UIButton *lastItem;//上一个被点击的item
@property (nonatomic, strong) UIView *redPoint;//消息上的红点

- (void)clickItem:(UIButton *)button;

- (void)setupNextItemStyle:(UIButton *)nextBTn;

@end
