//
//  SquareInterface.m
//  YueTa
//
//  Created by Awin on 2019/1/29.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "SquareInterface.h"
#import "YDDRequestManager.h"

@implementation SquareInterface

+ (void)getSquareListWithPage:(NSInteger)page andBlock:(void (^)(ResponseMessage *, NSArray *))block {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kSquareList];
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [bodyDic setObject:@(page) forKey:@"page"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        
        NSArray *modelArr = [NSArray array];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            modelArr = [YTMyDateModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        
        block(rspStatusAndMessage, modelArr);
    }];
}


+ (void)filtrateSquareListWithMax_weight:(NSInteger)max_weight min_weight:(NSInteger)min_weight max_age:(NSInteger)max_age min_age:(NSInteger)min_age max_height:(NSInteger)max_height min_height:(NSInteger)min_height isVip:(BOOL)isVip auth_status:(BOOL)auth_status sort:(BOOL)sort work:(NSString *)work education:(NSInteger)education show:(NSString *)show page:(NSInteger)page gender:(NSInteger)gender max_reward:(NSInteger)max_reward min_reward:(NSInteger)min_reward andBlock:(void (^)(ResponseMessage *, NSArray *))block {
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@",kBaseURLString,kSquareFiltrate];
    
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
    [bodyDic setObject:@(max_reward) forKey:@"max_reward"];
    [bodyDic setObject:@(min_reward) forKey:@"min_reward"];
    [bodyDic setObject:@(gender) forKey:@"gender"];
    
    [YDDRequestManager executePOST:requestURL requestBody:bodyDic andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        
        NSArray *modelArr = [NSArray array];
        if (rspStatusAndMessage.code == kResponseSuccessCode) {
            modelArr = [YTMyDateModel mj_objectArrayWithKeyValuesArray:responseDataDic];
        }
        
        block(rspStatusAndMessage, modelArr);
    }];
    
}



@end
