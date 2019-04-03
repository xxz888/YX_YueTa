//
//  YTSetPasswordController.h
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, YTPasswordVCType) {
    YTPasswordVCForget = 0,      // 忘记密码
    YTPasswordVCReset = 1,       // 重置密码
};

NS_ASSUME_NONNULL_BEGIN

@interface YTSetPasswordController : BaseViewController

@property (nonatomic, assign) YTPasswordVCType type;

@property (nonatomic, copy) NSString *phoneStr;

@end

NS_ASSUME_NONNULL_END
