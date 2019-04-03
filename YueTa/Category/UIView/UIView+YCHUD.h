//
//  UIView+YCHUD.h
//  ychat
//
//  Created by ydd on 2017/12/16.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface UIView (YCHUD)

/** hud */
@property (nonatomic,strong) MBProgressHUD *MBHUD;
/** 弹窗 自动消失文字*/
- (void) showAutoHideHudWithText:(NSString *)text;
/** 弹窗 菊花 不自动消失 */
- (void)showIndeterminateHudWithText:(NSString *)text;
/** 隐藏 */
- (void)hideHud;

@end
