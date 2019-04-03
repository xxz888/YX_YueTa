//
//  YTMyDateModel.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTMyDateModel : BaseModel

@property (nonatomic, copy) NSString *area;
@property (nonatomic, assign) NSInteger dateId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger gender;//0 男 1女
@property (nonatomic, assign) NSInteger VIP;
@property (nonatomic, assign) NSInteger agree_number;//约会是否成功 user_id如果等于自己的id，就是自己发出的约会，agree_number=0的时候就是对方还没同意。user_id如果不等于自己的id，就是对方发给自己的，agree_number=0的时候就是自己还没同意 10:已忽略
@property (nonatomic, assign) NSInteger auth_status;//身份认证
@property (nonatomic, assign) NSInteger auth_job;//工作认证
@property (nonatomic, copy) NSString *program;//约会节目
@property (nonatomic, copy) NSString *program_str;
@property (nonatomic, copy) NSString *publish_time;//发布时间
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *date_time;//约会时间
@property (nonatomic, copy) NSString *site;//约会地点
@property (nonatomic, copy) NSString *details;//约会内容
@property (nonatomic, assign) NSInteger reward_type;//打赏方式：0报名，1约她
@property (nonatomic, copy) NSString *reward;//打赏金额
@property (nonatomic, copy) NSString *show1;//视频or视频
@property (nonatomic, copy) NSString *show2;//视频or视频
@property (nonatomic, copy) NSString *show3;//视频or视频
@property (nonatomic, copy) NSString *show4;//视频or视频
@property (nonatomic, assign) NSInteger distance;//距离
@property (nonatomic, assign) NSInteger object_id;//无目标的约会按钮就只有“约ta”和“报名”

@property (nonatomic, strong) NSArray *picList;

@end

NS_ASSUME_NONNULL_END
