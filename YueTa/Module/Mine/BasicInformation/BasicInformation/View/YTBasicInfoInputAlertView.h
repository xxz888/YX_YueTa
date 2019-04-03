//
//  YTAgeInputAlertView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BasicInfoInputBlock)(NSString *inputText);

@interface YTBasicInfoInputAlertView : UIView

+ (void)showAlertViewWithPlaceHolder:(NSString *)placeholder
                   inputConfirmBlock:(BasicInfoInputBlock)block;

@end

NS_ASSUME_NONNULL_END
