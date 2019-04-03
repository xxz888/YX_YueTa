//
//  YTMineInterface.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseMessage.h"
#import "YTMyDateModel.h"
#import "YTRelationUserModel.h"
#import "YTAuthenStatusModel.h"
#import "YTMyProblemModel.h"
#import "YTApplyModel.h"
#import "YTAuthStateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineInterface : NSObject

/**
 * @brief 获取粉丝关注数量
 */
+ (void)getFansLikeNumberAndBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSString *fansNumber, NSString *likeNumber))block;

/**
 * @brief 我的发布/我的报名/我的约会
 * @param latitude    纬度
 * @param longtitude  经度
 * @param page        页码
 * @param date_type   约会类型 own,apply,all
 */
+ (void)getMydateByPage:(NSInteger)page
               latitude:(double)latitude
             longtitude:(double)longtitude
              date_type:(NSString *)date_type
               andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray<YTMyDateModel *> *dateList))block;

/**
 * @brief fans or like or black列表
 * @param type fans/like/black
 */
+ (void)getRelationListByType:(NSString *)type
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray<YTRelationUserModel *> *userList))block;

/**
 * @brief 身份认证
 * @param type 身份（1）or职业（2）
 */
+ (void)getAuthenStatusByType:(NSInteger)type
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, YTAuthenStatusModel *authenStatusModel))block;

/**
 * @brief 提交身份认证
 * @param photo_1 正面
 * @param photo_2 反面
 * @param photo_3 手持(工作认证无照片则传none)
 * @param type 身份（1）or职业（2）
 */
+ (void)submitAuthenByPhoto_1:(NSString *)photo_1
                      photo_2:(NSString *)photo_2
                      photo_3:(NSString *)photo_3
                         type:(NSInteger)type
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 我的资料
 */
+ (void)getPersonalDataAndBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *userDataDic))block;

/**
 * @brief 我的提问列表
 */
+ (void)getMyProblemListAndBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray<YTMyProblemModel *> *problemList))block;

/**
 * @brief 提交提问
 * @param problem 问题详情
 * @param pic1    资料1
 * @param pic2    资料2
 * @param pic3    资料3
 */
+ (void)submitProblem:(NSString *)problem
                 pic1:(NSString *)pic1
                 pic2:(NSString *)pic2
                 pic3:(NSString *)pic3
             andBlock:(void (^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 常见问列表
 */
+ (void)getCommonProblemListAndBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray<YTMyProblemModel *> *problemList))block;

/**
 * @brief 关于我们
 */
+ (void)getAboutusDetailAndBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSString *describe, NSString *pic))block;

/**
 * @brief 完善资料
 */
+ (void)modifyUserInfoWithUsername:(NSString *)username
                            gender:(NSInteger)gender
                               age:(NSInteger)age
                             photo:(NSString *)photo
                               job:(NSInteger)job
                            height:(NSString *)height
                            weight:(NSString *)weight
                           emotion:(NSInteger)emotion
                           program:(NSString *)program
                            wechat:(NSString *)wechat
                         education:(NSInteger)education
                      introduction:(NSString *)introduction
                          province:(NSString *)province
                              city:(NSString *)city
                        auth_photo:(NSInteger)auth_photo
                          andBlock:(void (^)(ResponseMessage * rspStatusAndMessage))block;

/**
 * @brief 获取七牛云token，url
 * @param fileName  用户id_image_时间戳.jpg  用户id_video_时间戳.mp4
 */
+ (void)getQiniuUploadTokenByFileName:(NSString *)fileName
                             andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, NSString *uploadToken, NSString *url))block;

/**
 * @brief 相册
 */
+ (void)getUserPhotoListByUserId:(NSInteger)userId
                        andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, NSArray *picList))block;

/**
 * @brief 相册上传
 * @param photo_url 图片地址
 */
+ (void)uploadPhotoByUrl:(NSString *)photo_url
                andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 关注用户
 */
+ (void)likeUser:(NSInteger)userId
         andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 取消关注用户
 */
+ (void)disLikeUser:(NSInteger)userId
           andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 拉黑用户
 */
+ (void)blackUser:(NSInteger)userId
         andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 取消拉黑用户
 */
+ (void)disBlackUser:(NSInteger)userId
            andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 忽略
 * @param date_id 约会id
 */
+ (void)ignoreDate:(NSInteger)date_id
          andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block;

/**
 * @brief 确认邀约
 * @param date_id  约会id
 * @param apply_id apply id
 */
+ (void)agreeDate:(NSInteger)date_id
          apply_id:(NSInteger)apply_id
          andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block;


/**
 * @brief 报名列表
 * @param date_id  约会id
 */
+ (void)getApplyList:(NSInteger)date_id
          andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, NSArray<YTApplyModel *> *applyList))block;

/**
 * @brief 报名
 * @param date_id  约会id
 */
+ (void)applyDate:(NSInteger)date_id
         andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDic))block;

/**
 * @brief 约她
 * @param object_id   指定用户id，公开则传0
 * @param area        所在区域
 * @param use_coin    0‘不使用约币’1‘确认使用约币’
 * @param date_time   约会时期
 * @param duration    约会时间
 * @param reward_type 打赏方式：0打赏，1求打赏
 * @param reward      打赏金额
 * @param program     约会内容
 * @param site        约会地点
 * @param show1       图片or视频
 * @param show2       图片or视频
 * @param show3       图片or视频
 * @param show4       图片or视频
 */
+ (void)postYuaTaByObject_id:(NSInteger)object_id
                        area:(NSString *)area
                    use_coin:(NSInteger)use_coin
                   date_time:(NSString *)date_time
                    duration:(NSString *)duration
                 reward_type:(NSInteger)reward_type
                      reward:(NSInteger)reward
                     program:(NSString *)program
                        site:(NSString *)site
                       show1:(NSString *)show1
                       show2:(NSString *)show2
                       show3:(NSString *)show3
                       show4:(NSString *)show4
               site_abscissa:(double)site_abscissa
               site_ordinate:(double)site_ordinate
                    andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDic))block;

/**
 * @brief 获取认证状态
 * @param type 1身份认证 2职业认证
 */
+ (void)getAuthStateByType:(NSInteger)type
                  andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, YTAuthStateModel *authStateModel))block;

/**
 * @brief 提交身份认证
 * @param type 1身份认证 2职业认证
 * @param photo_1 身份证正面
 * @param photo_2 身份证反面
 * @param photo_3 身份证手持/(工作认证无照片则传none)
 */
+ (void)submitAuthByType:(NSInteger)type
                 photo_1:(NSString *)photo_1
                 photo_2:(NSString *)photo_2
                 photo_3:(NSString *)photo_3
                andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, YTAuthStateModel *authStateModel))block;

/**
 * @brief 举报
 * @param aim_id 目标id
 * @param reason 举报理由
 * @param pic1   图片1
 * @param pic2   图片2
 * @param pic3   图片3
 * @param pic4   图片4
 * @param pic5   图片5
 * @param describe  补充说明
 */
+ (void)reportUser:(NSInteger)aim_id
            reason:(NSString *)reason
              pic1:(NSString *)pic1
              pic2:(NSString *)pic2
              pic3:(NSString *)pic3
              pic4:(NSString *)pic4
              pic5:(NSString *)pic5
              describe:(NSString *)describe
          andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block;


@end

NS_ASSUME_NONNULL_END
