//
//  UIView+YCHUD.m
//  ychat
//
//  Created by ydd on 2017/12/16.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "UIView+YCHUD.h"
#import <objc/runtime.h>
#import <MBProgressHUD.h>

static char YC_HUDKey;

@implementation UIView (YCHUD)

- (void)setMBHUD:(MBProgressHUD *)MBHUD {
    objc_setAssociatedObject(self, &YC_HUDKey, MBHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)MBHUD {
    return objc_getAssociatedObject(self, &YC_HUDKey);
}

- (void)showAutoHideHudWithText:(NSString *)text {
    if (self.MBHUD) {
        [self hideHud];
    }
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
//    hud.labelText = text;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = kSystemFont15;
    hud.layer.opacity = 0.8;
    hud.margin = 10.0;
    hud.removeFromSuperViewOnHide = YES;
    NSTimeInterval time;
    if (text.length < 5) {
        time = 2;
    }else if(text.length < 10){
        time = 3;
    }else if (text.length < 15){
        time = 4;
    }else{
        time = 5;
    }
    [hud hideAnimated:YES afterDelay:time];
    self.MBHUD = hud;
}

- (void)showIndeterminateHudWithText:(NSString *)text {
    if (self.MBHUD) {
        [self hideHud];
    }
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    hud.layer.opacity = 0.8;
    hud.margin = 10.0;
    hud.removeFromSuperViewOnHide = YES;
    self.MBHUD = hud;
}

- (void)hideHud {
    [self.MBHUD hideAnimated:YES];
    self.MBHUD = nil;
}

@end
