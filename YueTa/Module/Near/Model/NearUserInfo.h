//
//  NearUserInfo.h
//  YueTa
//
//  Created by Awin on 2019/1/30.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

@interface NearUserInfo : BaseModel

@property (nonatomic, assign) BOOL VIP;
@property (nonatomic, strong) NSString *abscissa;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL auth_job;//职业认证
@property (nonatomic, assign) BOOL auth_status;//身份认证
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, assign) NSInteger education;
@property (nonatomic, assign) NSInteger finally_on_line;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, assign) BOOL on_line;
@property (nonatomic, strong) NSString *ordinate;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *program;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *emotion;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, assign) NSInteger like;
@property (nonatomic, assign) NSInteger mobile;
@property (nonatomic, strong) NSArray *pic_list;
@property (nonatomic, strong) NSString *wechat;


@end
