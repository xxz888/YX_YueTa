//
//  NSObject+YCAlert.m
//  ychat
//
//  Created by 孙俊 on 2017/12/17.
//  Copyright © 2017年 Sun. All rights reserved.
//

#import "NSObject+YCAlert.h"
#import "UIViewController+YCRootVC.h"

@implementation NSObject (YCAlert)

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle {
    
    [self showAlertViewWithTitle:title message:message confirmTitle:confirmTitle confirmAction:nil];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmAction:(void(^)(void))confirmAction {
    
    [self showAlertViewWithTitle:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:confirmAction cancelAction:NULL];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(void(^)(void))confirmAction cancelAction:(void(^)(void))cancelAction {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    /// 左边按钮
    if(cancelTitle.length > 0){
        UIAlertAction *cancel= [UIAlertAction actionWithTitle:cancelTitle?cancelTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !cancelAction?:cancelAction(); }];
        [alertController addAction:cancel];
    }
    
    if (confirmTitle.length > 0) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle?confirmTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !confirmAction?:confirmAction();}];
        [alertController addAction:confirm];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIViewController currentViewController] presentViewController:alertController animated:YES completion:NULL];
    });
}



@end
