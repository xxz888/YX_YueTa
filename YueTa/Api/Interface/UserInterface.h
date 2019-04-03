//
//  UserInterface.h
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseMessage.h"
#import "AllInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInterface : NSObject

/**
 * @brief 登录
 * @param mobile 【手机号码，类型：字符串】
 * @param password 【密码，类型：字符串】
 */
+ (void)loginWithMobileMobile:(NSString *)mobile
                     password:(NSString *)password
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;


/**
 * @brief 发送短信验证码
 * @param mobile 【手机号码，类型：字符串】
 */
+ (void)sendVerificationCodeWithMobile:(NSString *)mobile
                              andBlock:(void (^)(ResponseMessage *rspStatusAndMessage))block;



/**
 * @brief 注册
 * @param mobile 【手机号码，类型：字符串】
 * @param sms_code 【验证码，类型：字符串】
 * @param password 【密码，类型：字符串】
 */
+ (void)registerWithMobile:(NSString *)mobile
                  sms_code:(NSString *)sms_code
                  password:(NSString *)password
                  andBlock:(void (^)(ResponseMessage *rspStatusAndMessage))block;


/**
 * @brief 注册之后，完善资料页面，获取填写资料的标签
 */
+ (void)getRegisterTagLabelAndBlock:(void (^)(ResponseMessage *rspStatusAndMessage, AllInfoModel *model))block;

/**
 * @brief 注册之后，完善资料
 * @param mobile 【手机号码，类型：字符串】
 * @param password 【密码，类型：字符串】
 * @param username 【昵称，类型：字符串】
 * @param gender 【性别， 0=男，1=女】
 * @param age 【年龄，类型：int】
 * @param job 【职业，类型：字符串】
 * @param height 【身高，类型：字符串】
 * @param weight 【体重，类型：字符串】
 * @param education 【学历，类型：字符串】
 * @param province 【省，类型：字符串】
 * @param city 【城市，类型：字符串】
 * @param wechat 【微信，类型：字符串】
 * @param introduction 【个人介绍，类型：字符串】
 */
+ (void)completeUserInfoWithMobile:(NSString *)mobile
                          password:(NSString *)password
                          username:(NSString *)username
                            gender:(NSInteger)gender
                               age:(NSInteger)age
                               job:(NSString *)job
                            height:(NSString *)height
                            weight:(NSString *)weight
                         education:(NSInteger)education
                          province:(NSString *)province
                              city:(NSString *)city
                            wechat:(NSString *)wechat
                      introduction:(NSString *)introduction
                          andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;

/**
 * @brief 初始化环信
 */
+ (void)initHuanXinAndBlock:(void (^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 环信ID
 * @param aim_id 用户ID
 */
+ (void)getHuanXinInfoByAimId:(NSInteger)aim_id
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSString *ID, NSString *password))block;

@end

NS_ASSUME_NONNULL_END
