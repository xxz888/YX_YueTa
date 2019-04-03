//
//  YTApplyModel.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/28.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTApplyModel : BaseModel

@property (nonatomic, assign) NSInteger date_id;
@property (nonatomic, assign) NSInteger apply_id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, assign) NSInteger status;//(1,'等待确认'),(2,'邀约成功'),(3,'邀约失败'),(4,'信息失效')
@property (nonatomic, assign) NSInteger VIP;
@property (nonatomic, assign) NSInteger auth_status;
@property (nonatomic, assign) NSInteger auth_job;

@end

NS_ASSUME_NONNULL_END
