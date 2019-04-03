//
//  NearInterface.h
//  YueTa
//
//  Created by Awin on 2019/1/29.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseMessage.h"
#import "NearListModel.h"
#import "NearUserInfo.h"
#import "YTMyDateModel.h"

@interface NearInterface : NSObject

/**
 * @brief 获取附近人的列表
 * @param page 【手机号码，类型：int】
 */
+ (void)getNearListWithPage:(NSInteger)page
                   andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray *array))block;

/**
 * @brief 获取附近 某一个用户的详情
 */
+ (void)getNearUserInfoWithID:(NSInteger)ID
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NearUserInfo *model))block;


/**
 * @brief ta的约会
 * @param latitude    纬度
 * @param longtitude  经度
 * @param page        页码
 * @param ID   用户ID
 */
+ (void)getOneUserdateByPage:(NSInteger)page
                    latitude:(double)latitude
                  longtitude:(double)longtitude
                          ID:(NSInteger )ID
                    andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray<YTMyDateModel *> *dateList))block;


/**
 筛选附近列表
 */
+ (void)filtrateNearListWithMax_weight:(NSInteger)max_weight
                            min_weight:(NSInteger)min_weight
                               max_age:(NSInteger)max_age
                               min_age:(NSInteger)min_age
                            max_height:(NSInteger)max_height
                            min_height:(NSInteger)min_height
                                 isVip:(BOOL)isVip
                           auth_status:(BOOL)auth_status
                                  sort:(BOOL)sort
                                  work:(NSString *)work
                             education:(NSInteger)education
                                  show:(NSString *)show
                                  page:(NSInteger)page
                              andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray *array))block;


@end
