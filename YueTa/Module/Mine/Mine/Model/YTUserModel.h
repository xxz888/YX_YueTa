//
//  YTUserModel.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTUserModel : BaseModel

@property (nonatomic, assign) NSInteger VIP;
@property (nonatomic, copy) NSString *abscissa;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, assign) NSInteger auth_job;
@property (nonatomic, assign) NSInteger auth_status;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *date_joined;
@property (nonatomic, assign) NSInteger education;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) NSInteger emotion;
@property (nonatomic, assign) NSInteger finally_on_line;
@property (nonatomic, copy) NSString *first_name;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, assign) NSInteger is_active;
@property (nonatomic, assign) NSInteger is_staff;
@property (nonatomic, assign) NSInteger is_superuser;
@property (nonatomic, assign) NSInteger job;
@property (nonatomic, copy) NSString *last_name;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) NSInteger on_line;
@property (nonatomic, copy) NSString *ordinate;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *program;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *wechat;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, assign) NSInteger auth_photo;

/*
 VIP = 0;
 abscissa = "0.000000";
 age = 22;
 "auth_job" = 0;
 "auth_status" = 0;
 city = "\U4e0a\U6d77\U5e02";
 "date_joined" = "2018-12-20T15:28:12.931705+08:00";
 education = 3;
 email = "";
 emotion = null;
 "finally_on_line" = 0;
 "first_name" = "";
 gender = 0;
 groups =     (
 );
 height = 180;
 id = 2;
 introduction = "\U578b\U7537 90\U540e";
 "is_active" = 1;
 "is_staff" = 0;
 "is_superuser" = 0;
 job = "\U91d1\U878d";
 "last_name" = "";
 mobile = 15222222222;
 "on_line" = 0;
 ordinate = "0.000000";
 password = 222222;
 photo = "http://pil9qvgp1.bkt.clouddn.com/14_image_1545291901737.jpg?e=1545295497&token=rpLW8CzqDzdgK27Mdp6fdrFjjdJRR-jBmfC1m8P0:CsmxDNn5TczyvLDddnuoWdChIpc=";
 program = null;
 province = "\U4e0a\U6d77";
 token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJ1c2VybmFtZSI6Ilx1OTY0Nlx1NWMwZlx1NTFlNCIsImV4cCI6MTU0ODc0NDMwOSwiZW1haWwiOiIifQ.vFr_6HDP8kOUBwJxEt6iUIskGFPo0fVajKu-I6f5WU0";
 "user_permissions" =     (
 );
 username = "\U9646\U5c0f\U51e4";
 wechat = null;
 weight = "60.00";
 */

@end

NS_ASSUME_NONNULL_END
