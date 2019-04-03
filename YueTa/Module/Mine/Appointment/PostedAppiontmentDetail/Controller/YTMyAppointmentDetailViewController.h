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

//约会模型 必传
@property (nonatomic, strong) YTMyDateModel *myDateModel;

/*
 1=自己的约会详情,有邀请人列表,底部无按钮
 2=报名,无邀请人列表,底部按钮报名
 3=约Ta,无邀请人列表,底部按钮约Ta
 */
@property (nonatomic, assign) NSInteger type;

@end

NS_ASSUME_NONNULL_END
