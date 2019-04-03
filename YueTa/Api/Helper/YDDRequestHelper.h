//
//  YDDRequestHelper.h
//  ManZhiYan3
//
//  Created by 姚兜兜 on 2018/5/4.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseMessage.h"

typedef NS_ENUM(NSUInteger, YDDRequestType) {
    YDDRequestTypeGet,
    YDDRequestTypePost,
};

@interface YDDRequestHelper : NSObject


/**
 * @brief 基础请求
 *
 * @param type         请求类型
 * @param headerDic    请求头
 * @param requestUrl   请求url
 * @param requestCount 请求次数
 * @param bodyDic      请求param
 * @param block        请求返回的数据
 *
 * @return NSURLSessionTask 该次请求的task 可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)executeRequestWithType:(YDDRequestType)type
                                     headers:(NSMutableDictionary *)headerDic
                                  requestUrl:(NSString *)requestUrl
                                requestCount:(int)requestCount
                                 requestBody:(NSMutableDictionary *)bodyDic
                                    andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;

/**
 *  @brief 上传图片(单张)
 *
 *  @param path     请求路径
 *  @param image    图片
 *  @param bodyDic  非文件参数 (字典) {rentInfoId : }
 */
+ (NSURLSessionTask *)uploadImageWithPath:(NSString *)path
                                    image:(UIImage *)image
                                   params:(NSDictionary *)bodyDic
                                 andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;

/**
 *  @brief 上传图片(多张)
 *
 *  @param path    请求路径
 *  @param photos  图片数组
 *  @param bodyDic 非文件参数 (字典)  {rentInfoId : }
 */
+ (NSURLSessionTask *)uploadImageWithPath:(NSString *)path
                                   photos:(NSArray *)photos
                                   params:(NSDictionary *)bodyDic
                                 andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;

/// 有网YES, 无网:NO
+ (BOOL)isNetwork;
/// 手机网络:YES, 反之:NO
+ (BOOL)isWWANNetwork;
/// WiFi网络:YES, 反之:NO
+ (BOOL)isWiFiNetwork;

///  取消所有请求操作
+ (void)cancelAllRequest;
///  取消某一个url的请求
+ (void)cancelRequestWithURL:(NSString *)URL;
/// 设置请求头
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


@end
