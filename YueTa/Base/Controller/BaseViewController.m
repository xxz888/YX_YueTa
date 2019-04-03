//
//  BaseViewController.m
//  ManZhiYan3
//
//  Created by 姚兜兜 on 2018/5/4.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (IS_IOS_VERSION_11)  {
        [self.view setNeedsLayout];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = kWhiteBackgroundColor;
}


- (void)setNavigationBarTitle:(NSString *)title{
    self.navigationItem.title = title;
}

- (void)setNavigationBarTitleColor:(UIColor *)titleColor {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
}

- (void)viewDidLayoutSubviews {
    if (!IS_IOS_VERSION_11) return;
    UINavigationItem * item = self.navigationItem;
    NSArray * array = item.leftBarButtonItems;
    if (array && array.count != 0){
        //这里需要注意,你设置的第一个leftBarButtonItem的customeView不能是空的,也就是不要设置UIBarButtonSystemItemFixedSpace这种风格的item
        UIBarButtonItem * buttonItem = array[0];
        UIView * view = [[[buttonItem.customView superview] superview] superview];
        NSArray * arrayConstraint = view.constraints;
        for (NSLayoutConstraint * constant in arrayConstraint) {
            //在plus上这个值为20
            if (fabs(constant.constant) == 16) {
                constant.constant = 0;
            }else if (fabs(constant.constant) == 20) {
                constant.constant = 0;
            }
        }
    }
}

#pragma mark -- 禁用边缘返回
-(void)forbiddenSideBack {
    self.isCanBack = NO;
    //关闭ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}
#pragma mark -- 恢复边缘返回
- (void)resetSideBack {
    self.isCanBack=YES;
    //开启ios右滑返回
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

@end
