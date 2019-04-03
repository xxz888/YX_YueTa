//
//  YTPerfectInfoController.h
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTCompleteInfoController : BaseViewController

/**
 必须穿手机过来
 */
@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *password;

@end

NS_ASSUME_NONNULL_END
