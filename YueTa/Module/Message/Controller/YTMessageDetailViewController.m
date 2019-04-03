//
//  YTMessageDetailViewController.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/31.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMessageDetailViewController.h"

@implementation YTMessageDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

@end
