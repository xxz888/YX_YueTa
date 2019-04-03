//
//  SquareInterface.h
//  YueTa
//
//  Created by Awin on 2019/1/29.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseMessage.h"
#import "YTMyDateModel.h"

@interface SquareInterface : NSObject

/**
 * @brief 获取广场的列表
 * @param page 【手机号码，类型：int】
 */
+ (void)getSquareListWithPage:(NSInteger)page
                     andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray *array))block;

/**
 筛选广场列表
 */
+ (void)filtrateSquareListWithMax_weight:(NSInteger)max_weight
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
                                  gender:(NSInteger)gender
                              max_reward:(NSInteger)max_reward
                              min_reward:(NSInteger)min_reward
                                andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSArray *array))block;

@end
