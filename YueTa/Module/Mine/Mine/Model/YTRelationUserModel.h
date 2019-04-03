//
//  YTRelationUserModel.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTRelationUserModel : BaseModel

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, assign) NSInteger VIP;
@property (nonatomic, assign) NSInteger auth_status;
@property (nonatomic, assign) NSInteger auth_job;
@property (nonatomic, assign) NSInteger mutual_fans;//1 互粉  0 未关注

@end

NS_ASSUME_NONNULL_END
