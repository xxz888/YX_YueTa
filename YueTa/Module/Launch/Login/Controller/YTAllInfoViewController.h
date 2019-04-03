//
//  YTAllInfoViewController.h
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTAllInfoViewController : BaseViewController

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger age;

@end

NS_ASSUME_NONNULL_END
