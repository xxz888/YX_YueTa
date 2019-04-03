//
//  YTPostedAppointmentDetailViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/17.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"
#import "YTMyDateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTMyAppointmentDetailViewController : BaseViewController

@property (nonatomic, strong) YTMyDateModel *myDateModel;
//约会类型 own,apply,all 我的发布/我的报名/我的约会
@property (nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
