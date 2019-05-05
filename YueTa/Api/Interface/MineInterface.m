//
//  YTMineInterface.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "MineInterface.h"
#import "YDDRequestManager.h"

@implementation MineInterface

+ (void)getFansLikeNumberAndBlock:(void (^)(ResponseMessage * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kGetNearbyLike];
    
    [YDDRequestManager executeGET:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSNumber *fans_number;
        NSNumber *like_number;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            fans_number = responseDataDic[@"fans_number"];
            like_number = responseDataDic[@"like_number"];
        }
        block(rspStatusAndMessage, fans_number.stringValue, like_number.stringValue);
    }];
}

+ (void)getMydateByPage:(NSInteger)page
               latitude:(double)latitude
             longtitude:(double)longtitude
              date_type:(NSString *)date_type
               andBlock:(nonnull void (^)(ResponseMessage * _Nonnull, NSArray<YTMyDateModel *> * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kGetMydate];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(page) forKey:@"page"];
    [bodyDic setObject:@(latitude) forKey:@"ordinate"];
    [bodyDic setObject:@(longtitude) forKey:@"abscissa"];
    [bodyDic setObject:date_type forKey:@"date_type"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *dateList;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            dateList = [YTMyDateModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        block(rspStatusAndMessage, dateList);
    }];
}

+ (void)getRelationListByType:(NSString *)type andBlock:(void (^)(ResponseMessage * _Nonnull, NSArray<YTRelationUserModel *> * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kGetRelation];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:type forKey:@"type"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *userList;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            userList = [YTRelationUserModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        block(rspStatusAndMessage, userList);
    }];
}

+ (void)getAuthenStatusByType:(NSInteger)type
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, YTAuthenStatusModel *authenStatusModel))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kGetAuthenStatus];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(type) forKey:@"type"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        YTAuthenStatusModel *authenStatusModel;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            authenStatusModel = [YTAuthenStatusModel mj_objectWithKeyValues:responseDataDic];
        }
        block(rspStatusAndMessage, authenStatusModel);
    }];
}

+ (void)submitAuthenByPhoto_1:(NSString *)photo_1
                      photo_2:(NSString *)photo_2
                      photo_3:(NSString *)photo_3
                         type:(NSInteger)type
                     andBlock:(void (^)(ResponseMessage * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kSubmitAuthen];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(type) forKey:@"type"];
    [bodyDic setObject:photo_1 forKey:@"photo_1"];
    [bodyDic setObject:photo_2 forKey:@"photo_2"];
    if (!photo_3) {
        photo_3 = @"none";
    }
    [bodyDic setObject:photo_3 forKey:@"photo_3"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)getPersonalDataAndBlock:(void (^)(ResponseMessage * _Nonnull, NSDictionary * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kPersonalData];
    
    [YDDRequestManager executeGET:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:responseDataDic];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            [dict setValue:[UserInfoManager sharedInstance].token forKey:@"token"];
        }
        block(rspStatusAndMessage, [dict copy]);
    }];
}

+ (void)getMyProblemListAndBlock:(void (^)(ResponseMessage * _Nonnull, NSArray<YTMyProblemModel *> * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kMyProblem];
    
    [YDDRequestManager executeGET:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *problemList;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            problemList = [YTMyProblemModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        block(rspStatusAndMessage, problemList);
    }];
}

+ (void)submitProblem:(NSString *)problem pic1:(NSString *)pic1 pic2:(NSString *)pic2 pic3:(NSString *)pic3 andBlock:(void (^)(ResponseMessage * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kMyProblem];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:problem forKey:@"problem"];
    if (pic1.length) {
        [bodyDic setObject:pic1 forKey:@"pic1"];
    }
    if (pic2.length) {
        [bodyDic setObject:pic2 forKey:@"pic2"];
    }
    if (pic3.length) {
        [bodyDic setObject:pic3 forKey:@"pic3"];
    }
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)getCommonProblemListAndBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray<YTMyProblemModel *> *problemList))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kCommonProblem];
    
    [YDDRequestManager executeGET:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *problemList;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            problemList = [YTMyProblemModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        block(rspStatusAndMessage, problemList);
    }];
}

+ (void)getAboutusDetailAndBlock:(void (^)(ResponseMessage * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kAboutus];
    
    [YDDRequestManager executeGET:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSString *describe;
        NSString *pic;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            describe = responseDataDic[@"describe"];
            pic = responseDataDic[@"pic"];
        }
        block(rspStatusAndMessage, describe, pic);
    }];
}

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
                            andBlock:(void (^)(ResponseMessage * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kModifyUserInfo];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (username) {
        [bodyDic setObject:username forKey:@"username"];
    }
    [bodyDic setObject:@(gender) forKey:@"gender"];
    [bodyDic setObject:@(age) forKey:@"age"];
    [bodyDic setObject:@(job) forKey:@"job"];
    [bodyDic setObject:height forKey:@"height"];
    if ([weight containsString:@"kg"]) {
        [weight stringByReplacingOccurrencesOfString:@"kg" withString:@""];
    }
    [bodyDic setObject:weight forKey:@"weight"];
    [bodyDic setObject:@(emotion) forKey:@"emotion"];
    if (program) {
        [bodyDic setObject:program forKey:@"program"];
    }
    if (wechat.length) {
        [bodyDic setObject:wechat forKey:@"wechat"];
    }
    [bodyDic setObject:@(education) forKey:@"education"];
    [bodyDic setObject:introduction forKey:@"introduction"];
    [bodyDic setObject:province forKey:@"province"];
    [bodyDic setObject:city forKey:@"city"];
    [bodyDic setObject:@(auth_photo) forKey:@"auth_photo"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)getQiniuUploadTokenByFileName:(NSString *)fileName
                             andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, NSString *uploadToken, NSString *url))block {
    //图片名格式用户id_image_时间戳
    NSString *uploadURL = [NSString stringWithFormat:kGetQiniuToken,fileName];
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,uploadURL];
    
    [YDDRequestManager executeGET:requestURL requestBody:nil andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSString *token;
        NSString *url;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            token = responseDataDic[@"token"];
            url = responseDataDic[@"url"];
        }
        block(rspStatusAndMessage, token, url);
    }];
}

+ (void)getUserPhotoListByUserId:(NSInteger)userId andBlock:(void (^)(ResponseMessage * _Nonnull, NSArray * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kUserPhotos];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(userId) forKey:@"id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *picList;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            picList = (NSArray *)responseDataDic;
        }
        block(rspStatusAndMessage, picList);
    }];
}

+ (void)uploadPhotoByUrl:(NSString *)photo_url andBlock:(void (^)(ResponseMessage * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kPhotosUpload];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:photo_url forKey:@"photo_url"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)likeUser:(NSInteger)userId andBlock:(void (^)(ResponseMessage * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kLikeUser];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(userId) forKey:@"id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)disLikeUser:(NSInteger)userId andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kDisLikeUser];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(userId) forKey:@"id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)blackUser:(NSInteger)userId andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kBlackUser];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(userId) forKey:@"id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)disBlackUser:(NSInteger)userId andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kDisBlackUser];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(userId) forKey:@"id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)ignoreDate:(NSInteger)date_id
          andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kOver_look];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(date_id) forKey:@"date_id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}


+ (void)agreeDate:(NSInteger)date_id
         apply_id:(NSInteger)apply_id
         andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kAck_apply];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(date_id) forKey:@"date_id"];
    [bodyDic setObject:@(apply_id) forKey:@"apply_id"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

+ (void)getApplyList:(NSInteger)date_id andBlock:(void (^)(ResponseMessage * _Nonnull, NSArray<YTApplyModel *> * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kApply_list];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(date_id) forKey:@"date_id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *applyList;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            applyList = [YTApplyModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        block(rspStatusAndMessage, applyList);
    }];
}

+ (void)applyDate:(NSInteger)date_id andBlock:(void (^)(ResponseMessage * _Nonnull, NSDictionary * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kUserApply];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(date_id) forKey:@"date_id"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage,responseDataDic);
    }];
}

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
                    andBlock:(void (^)(ResponseMessage * _Nonnull, NSDictionary * _Nonnull))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kPublishYueTa];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (object_id > 0) {
        [bodyDic setObject:@(1) forKey:@"type"];
    } else {
        [bodyDic setObject:@(0) forKey:@"type"];
    }
    [bodyDic setObject:@(object_id) forKey:@"object_id"];
    [bodyDic setObject:area.length ? area : @""  forKey:@"area"];
    [bodyDic setObject:@(use_coin) forKey:@"use_coin"];
    [bodyDic setObject:date_time.length ? date_time : @"0"  forKey:@"date_time"];
    [bodyDic setObject:duration.length ? duration : @""  forKey:@"duration"];
    [bodyDic setObject:@(reward_type) forKey:@"reward_type"];
    [bodyDic setObject:@(reward) forKey:@"reward"];
    [bodyDic setObject:program forKey:@"program"];
    [bodyDic setObject:site.length ? site : @"" forKey:@"site"];
    [bodyDic setObject:show1.length ? show1 : @"0" forKey:@"show1"];
    [bodyDic setObject:show2.length ? show2 : @"0" forKey:@"show2"];
    [bodyDic setObject:show3.length ? show3 : @"0" forKey:@"show3"];
    [bodyDic setObject:show4.length ? show4 : @"0" forKey:@"show4"];
    [bodyDic setObject:@(site_abscissa) forKey:@"site_abscissa"];
    [bodyDic setObject:@(site_ordinate) forKey:@"site_ordinate"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage,responseDataDic);
    }];
}

+ (void)getAuthStateByType:(NSInteger)type andBlock:(void (^)(ResponseMessage * _Nonnull, YTAuthStateModel *))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kAuthen_status];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(type) forKey:@"type"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        YTAuthStateModel *model;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            model = [YTAuthStateModel mj_objectWithKeyValues:responseDataDic];
        }
        block(rspStatusAndMessage,model);
    }];
}

+ (void)submitAuthByType:(NSInteger)type
                 photo_1:(NSString *)photo_1
                 photo_2:(NSString *)photo_2
                 photo_3:(NSString *)photo_3
                andBlock:(void(^)(ResponseMessage *rspStatusAndMessage, YTAuthStateModel *authStateModel))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kSubmit_authen];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(type) forKey:@"type"];
    [bodyDic setObject:photo_1 forKey:@"photo_1"];
    [bodyDic setObject:photo_2 forKey:@"photo_2"];
    if (!photo_3.length) {
        photo_3 = @"none";
    }
    [bodyDic setObject:photo_3 forKey:@"photo_3"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        YTAuthStateModel *model;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            model = [YTAuthStateModel mj_objectWithKeyValues:responseDataDic];
        }
        block(rspStatusAndMessage,model);
    }];
}

+ (void)reportUser:(NSInteger)aim_id
            reason:(NSString *)reason
              pic1:(NSString *)pic1
              pic2:(NSString *)pic2
              pic3:(NSString *)pic3
              pic4:(NSString *)pic4
              pic5:(NSString *)pic5
          describe:(NSString *)describe
          andBlock:(void(^)(ResponseMessage *rspStatusAndMessage))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kInformUser];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(aim_id) forKey:@"aim_id"];
    [bodyDic setObject:pic1 forKey:@"pic1"];
    [bodyDic setObject:pic2 forKey:@"pic2"];
    [bodyDic setObject:pic3 forKey:@"pic3"];
    [bodyDic setObject:pic4 forKey:@"pic4"];
    [bodyDic setObject:pic5 forKey:@"pic5"];
    [bodyDic setObject:describe forKey:@"describe"];
    [bodyDic setObject:reason forKey:@"reason"];

    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        block(rspStatusAndMessage);
    }];
}

@end
