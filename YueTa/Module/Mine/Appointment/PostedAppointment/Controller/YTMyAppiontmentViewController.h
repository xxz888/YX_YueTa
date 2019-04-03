//
//  YTPostedAppointmentViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTMyAppiontmentViewController : BaseViewController

//约会类型 own,apply,all,other  我的发布/我的报名/我的约会/Ta的约会
@property (nonatomic, copy) NSString *type;

// type = other 的时候 需要传ID
@property (nonatomic, assign) NSInteger ID;

@end

NS_ASSUME_NONNULL_END
