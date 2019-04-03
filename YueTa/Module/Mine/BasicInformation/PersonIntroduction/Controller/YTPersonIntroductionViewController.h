//
//  YTPersonIntroductionViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/10.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PersonIntroductionSaveBlock)(NSString *text);

@interface YTPersonIntroductionViewController : BaseViewController

@property (nonatomic, strong) NSArray *personalaArr;

@property (nonatomic, copy) PersonIntroductionSaveBlock personIntroductionSaveBlock;

@end

NS_ASSUME_NONNULL_END
