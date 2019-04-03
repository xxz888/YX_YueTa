//
//  UserInterface.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "UserInterface.h"
#import "YDDRequestManager.h"

@implementation UserInterface

+ (void)loginWithMobileMobile:(NSString *)mobile password:(NSString *)password andBlock:(void (^)(ResponseMessage * _Nonnull, NSDictionary * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kUserLogin];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:mobile forKey:@"mobile"];
    [bodyDic setObject:password forKey:@"password"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage, responseDataDic);
    }];
}

+ (void)sendVerificationCodeWithMobile:(NSString *)mobile andBlock:(void (^)(ResponseMessage *))block {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kSendCode];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:mobile forKey:@"mobile"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)registerWithMobile:(NSString *)mobile sms_code:(NSString *)sms_code password:(NSString *)password andBlock:(void (^)(ResponseMessage * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kUserRegister];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:mobile forKey:@"mobile"];
    [bodyDic setObject:sms_code forKey:@"sms_code"];
    [bodyDic setObject:password forKey:@"password"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            
        }
        block(rspStatusAndMessage);
    }];
}

+ (void)completeUserInfoWithMobile:(NSString *)mobile username:(NSString *)username gender:(NSInteger)gender age:(NSInteger)age andBlock:(void (^)(ResponseMessage * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kUpdateUserInfo];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:mobile forKey:@"mobile"];
    [bodyDic setObject:username forKey:@"username"];
    [bodyDic setObject:@(gender) forKey:@"gender"];
    [bodyDic setObject:@(age) forKey:@"age"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            
        }
        block(rspStatusAndMessage);
    }];
}

+ (void)getRegisterTagLabelAndBlock:(void (^)(ResponseMessage * _Nonnull, AllInfoModel * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kTagData];
    
    [YDDRequestManager executePOST:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        AllInfoModel *model = [AllInfoModel new];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            model = [AllInfoModel mj_objectWithKeyValues:responseDataDic];
        }
        block(rspStatusAndMessage, model);
    }];
}

+ (void)completeUserInfoWithMobile:(NSString *)mobile password:(NSString *)password username:(NSString *)username gender:(NSInteger)gender age:(NSInteger)age job:(NSString *)job height:(NSString *)height weight:(NSString *)weight education:(NSInteger)education province:(NSString *)province city:(NSString *)city wechat:(NSString *)wechat introduction:(NSString *)introduction andBlock:(void (^)(ResponseMessage * _Nonnull, NSDictionary * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kUpdateUserInfo];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:mobile forKey:@"mobile"];
    [bodyDic setObject:password forKey:@"password"];
    [bodyDic setObject:username forKey:@"username"];
    [bodyDic setObject:@(gender) forKey:@"gender"];
    [bodyDic setObject:@(age) forKey:@"age"];
    [bodyDic setObject:job forKey:@"job"];
    [bodyDic setObject:height forKey:@"height"];
    [bodyDic setObject:weight forKey:@"weight"];
    [bodyDic setObject:@(education) forKey:@"education"];
    [bodyDic setObject:province forKey:@"province"];
    [bodyDic setObject:city forKey:@"city"];
    [bodyDic setObject:@"0" forKey:@"photo"];//注册这里不需要头像了，在我的页面可以上传
    if (wechat.length) {
        [bodyDic setObject:wechat forKey:@"wechat"];
    }
    [bodyDic setObject:introduction forKey:@"introduction"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage,responseDataDic);
    }];
}

+ (void)initHuanXinAndBlock:(void (^)(ResponseMessage * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kInitHX];
    
    [YDDRequestManager executeGET:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)getHuanXinInfoByAimId:(NSInteger)aim_id
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSString *ID, NSString *password))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@%ld/",kBaseURLString,kInitHXID,(long)aim_id];
    
//    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
//    [bodyDic setObject:@(aim_id) forKey:@"aim_id"];
    
    [YDDRequestManager executeGET:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSString *ID;
        NSString *password;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            /*
             {
             "Aim_ID" = jiuju2;
             ID = jiuju2;
             password = 222222;
             }
             */
            ID = responseDataDic[@"ID"];
            password = responseDataDic[@"password"];
        }
        block(rspStatusAndMessage,ID,password);
    }];

}

@end
