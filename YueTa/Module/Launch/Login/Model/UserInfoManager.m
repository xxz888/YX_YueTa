//
//  UserInfoManager.m
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/28.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "UserInfoManager.h"

#define kUserInfo @"userInfo"

static UserInfoManager * _instance;

@implementation UserInfoManager

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self getUserInfo];
    }
    return self;
}

//获取用户信息
- (void)getUserInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userInfor = [userDefaults objectForKey:kUserInfo];
    
    self.ID = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"id"]].integerValue;
    self.mobile = [userInfor objectForKey:@"mobile"];
    self.token = [userInfor objectForKey:@"token"];
    self.is_superuser = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"is_superuser"]].boolValue;
    self.username = [userInfor objectForKey:@"username"];
    self.is_staff = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"is_staff"]].boolValue;
    self.is_active = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"is_active"]].boolValue;
    self.photo = [userInfor objectForKey:@"photo"];
    self.gender = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"gender"]].integerValue;
    self.age = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"age"]].integerValue;
    self.job = [userInfor objectForKey:@"job"];
    self.height = [userInfor objectForKey:@"height"];
    self.weight = [userInfor objectForKey:@"weight"];
    self.program = [userInfor objectForKey:@"program"];
    self.wechat = [userInfor objectForKey:@"wechat"];
    self.username = [userInfor objectForKey:@"username"];
    self.education = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"education"]].integerValue;
    self.province = [userInfor objectForKey:@"province"];
    self.city = [userInfor objectForKey:@"city"];
    self.introduction = [userInfor objectForKey:@"introduction"];
    self.on_line = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"on_line"]].boolValue;
    self.VIP = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"VIP"]].boolValue;
    
    self.abscissa = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"abscissa"]];
    self.ordinate = [NSString stringWithFormat:@"%@",[userInfor objectForKey:@"ordinate"]];
}

//存储登录用户信息
- (void)saveUserInfo:(NSDictionary *)dictionary {
    
    NSUserDefaults *loginData = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mutableDict = [dictionary mutableCopy];
    
    NSArray *keysArray = [mutableDict allKeys];
    for (NSInteger i = 0; i < mutableDict.count; i++) {
        //根据键值处理字典中的每一项
        NSString *key = keysArray[i];
        NSString *value = mutableDict[key];
        if ([value isKindOfClass:[NSNull class]] ||  [value isEqual:[NSNull null]]) {
            [mutableDict removeObjectForKey:key];
        }
    }

    [loginData setObject:mutableDict forKey:kUserInfo];
    [loginData synchronize];
    
    [self getUserInfo];
}

//修改某一项登录用户信息
- (void)modifyUserInfo:(NSString *)key value:(id)value {
    
    NSMutableDictionary *properties = [self properties_aps];
    
    [properties setObject:value forKey:key];
    
    [self saveUserInfo:properties];
}

//删除登录用户信息
- (void)removeUserInfo {
    
    NSUserDefaults *loginData = [NSUserDefaults standardUserDefaults];
    [loginData removeObjectForKey:kUserInfo];
    [loginData synchronize];
    
    [self getUserInfo];
}

#pragma mark - private
//找出本类所有的属性和值
- (NSMutableDictionary *)properties_aps {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID": @"id",
             };
}

@end
