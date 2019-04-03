//
//  MZYRequestManager.h
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/2.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResponseMessage;

@interface YDDRequestManager : NSObject

/**
 * @brief POST请求
 *
 * @param requestUrl   请求url
 * @param bodyDic      请求param
 * @param block        请求返回的数据
 *
 * @return NSURLSessionTask 该次请求的task 可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)executePOST:(NSString *)requestUrl
                      requestBody:(NSMutableDictionary *)bodyDic
                         andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;

/**
 * @brief GET请求
 *
 * @param requestUrl   请求url
 * @param bodyDic      请求param
 * @param block        请求返回的数据
 *
 * @return NSURLSessionTask 该次请求的task 可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)executeGET:(NSString *)requestUrl
                     requestBody:(NSMutableDictionary *)bodyDic
                        andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;


/**
 * @brief 带有token的POST请求  暂时无用
 *
 * @param requestUrl   请求url
 * @param bodyDic      请求param
 * @param block        请求返回的数据
 *
 * @return NSURLSessionTask 该次请求的task 可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)executeTokenPOST:(NSString *)requestUrl
                           requestBody:(NSMutableDictionary *)bodyDic
                              andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;

/**
 * @brief 带有token的GET请求  暂时无用
 *
 * @param requestUrl   请求url
 * @param bodyDic      请求param
 * @param block        请求返回的数据
 *
 * @return NSURLSessionTask 该次请求的task 可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)executeTokenGET:(NSString *)requestUrl
                          requestBody:(NSMutableDictionary *)bodyDic
                             andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block;

/**
 * @brief 上传单张图片
 * @param image   UIImage对象
 */
+ (void)uploadImageWithImage:(UIImage *)image
                    andBlock:(void (^)(NSArray *responseData))block;

/**
 * @brief 上传多张图片
 * @param array   存放UIImage对象的数组
 */
+ (void)uploadImagesWithArray:(NSArray<UIImage *> *)array
                     andBlock:(void (^)(NSArray *responseData))block;

@end
