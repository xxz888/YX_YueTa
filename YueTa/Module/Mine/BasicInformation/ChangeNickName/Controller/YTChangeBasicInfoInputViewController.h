//
//  YTChangeNickNameViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^BasicInfoCompleteInputBlock)(NSString *text);

@interface YTChangeBasicInfoInputViewController : BaseViewController

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, copy) BasicInfoCompleteInputBlock basicInfoCompleteInputBlock;

@end

NS_ASSUME_NONNULL_END
