//
//  YTPostAppointmentViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTPostAppointmentViewController : BaseViewController

/** 指定用户id 不传则是公开 */
@property (nonatomic, assign) NSInteger dateUserId;

@end

NS_ASSUME_NONNULL_END
