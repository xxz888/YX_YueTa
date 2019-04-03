//
//  UserInfoManager.h
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/28.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoManager : BaseModel

@property (nonatomic, assign) NSInteger ID; 
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, assign) BOOL is_superuser;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) BOOL is_staff;
@property (nonatomic, assign) BOOL is_active;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, assign) NSInteger gender;//0男 1女
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *program;
@property (nonatomic, strong) NSString *wechat;
@property (nonatomic, assign) NSInteger education;//0初中1高中2专科3本科4研究生5硕士6博士7博士后
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *introduction;//个人介绍标签
@property (nonatomic, assign) BOOL on_line;
@property (nonatomic, assign) BOOL VIP;

@property (nonatomic, strong) NSString *abscissa;
@property (nonatomic, strong) NSString *ordinate;

+ (instancetype)sharedInstance;

/**
 获取用户信息
 */
- (void)getUserInfo;

/**
 存储登录用户信息
 */
- (void)saveUserInfo:(NSDictionary *)dictionary;

/**
 修改某一项登录用户信息
 */
- (void)modifyUserInfo:(NSString *)key value:(id)value;

/**
 删除登录用户信息
 */
- (void)removeUserInfo;


@end
