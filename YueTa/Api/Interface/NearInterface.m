//
//  NearInterface.m
//  YueTa
//
//  Created by Awin on 2019/1/29.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "NearInterface.h"
#import "YDDRequestManager.h"

@implementation NearInterface

+ (void)getNearListWithPage:(NSInteger)page andBlock:(void (^)(ResponseMessage *, NSArray *))block {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kNearList];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(page) forKey:@"page"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        
        NSArray *modelArr = [NSArray array];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            modelArr = [NearListModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        
        block(rspStatusAndMessage, modelArr);
    }];
}

+ (void)getNearUserInfoWithID:(NSInteger)ID andBlock:(void (^)(ResponseMessage *, NearUserInfo *))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kNearUserInfo];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(ID) forKey:@"id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        
        NearUserInfo *model = [NearUserInfo new];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            model = [NearUserInfo mj_objectWithKeyValues:responseDataDic];
        }
        
        block(rspStatusAndMessage, model);
    }];
}

+ (void)getOneUserdateByPage:(NSInteger)page latitude:(double)latitude longtitude:(double)longtitude ID:(NSInteger)ID andBlock:(void (^)(ResponseMessage *, NSArray<YTMyDateModel *> *))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kOneUserDate];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(page) forKey:@"page"];
    [bodyDic setObject:@(latitude) forKey:@"ordinate"];
    [bodyDic setObject:@(longtitude) forKey:@"abscissa"];
    [bodyDic setObject:@(ID) forKey:@"id"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *dateList;
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            dateList = [YTMyDateModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        block(rspStatusAndMessage, dateList);
    }];
}

+ (void)filtrateNearListWithMax_weight:(NSInteger)max_weight min_weight:(NSInteger)min_weight max_age:(NSInteger)max_age min_age:(NSInteger)min_age max_height:(NSInteger)max_height min_height:(NSInteger)min_height isVip:(BOOL)isVip auth_status:(BOOL)auth_status sort:(BOOL)sort work:(NSString *)work education:(NSInteger)education show:(NSString *)show page:(NSInteger)page andBlock:(void (^)(ResponseMessage *, NSArray *))block {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kNearFilt];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(max_weight) forKey:@"min_weight"];
    [bodyDic setObject:@(min_weight) forKey:@"min_weight"];
    [bodyDic setObject:@(max_age) forKey:@"max_age"];
    [bodyDic setObject:@(min_age) forKey:@"min_age"];
    [bodyDic setObject:@(max_height) forKey:@"max_height"];
    [bodyDic setObject:@(min_height) forKey:@"min_height"];
    [bodyDic setObject:@(isVip) forKey:@"VIP"];
    [bodyDic setObject:@(auth_status) forKey:@"auth_status"];
    [bodyDic setObject:@(sort) forKey:@"sort"];
    [bodyDic setObject:work forKey:@"job"];
    [bodyDic setObject:@(education) forKey:@"education"];
    [bodyDic setObject:@(page) forKey:@"page"];
    [bodyDic setObject:show forKey:@"program"];
    
    NSString *genderStr = @"0";
    if ([UserInfoManager sharedInstance].gender == 0) {
        genderStr = @"1";
    }
    [bodyDic setObject:genderStr forKey:@"gender"];
    [bodyDic setObject:[UserInfoManager sharedInstance].abscissa forKey:@"abscissa"];
    [bodyDic setObject:[UserInfoManager sharedInstance].ordinate forKey:@"ordinate"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        
        NSArray *modelArr = [NSArray array];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            modelArr = [NearListModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        
        block(rspStatusAndMessage, modelArr);
    }];
    
}



@end
