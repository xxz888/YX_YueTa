//
//  YDDRequestHelper.m
//  ManZhiYan3
//
//  Created by 姚兜兜 on 2018/5/4.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "YDDRequestHelper.h"
#import "AFNetworkActivityIndicatorManager.h"

static NSMutableArray *_allSessionTask; //请求task数组
static AFHTTPSessionManager *_sessionManager; 

@interface YDDRequestHelper ()

@end

@implementation YDDRequestHelper

#pragma mark - **************** 请求
+ (NSURLSessionTask *)executeRequestWithType:(YDDRequestType)type
                                     headers:(NSMutableDictionary *)headerDic
                                  requestUrl:(NSString *)requestUrl
                                requestCount:(int)requestCount
                                 requestBody:(NSMutableDictionary *)bodyDic
                                    andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block {
    NSLog(@"===================== 请求的接口地址：%@   =====================",requestUrl);
    NSLog(@"===================== 请求的header参数：%@   =====================",headerDic);
    NSLog(@"===================== 请求的body参数：%@   =====================",bodyDic);
    
    NSURLSessionTask *sessionTask;
    //设置请求头
    [self setHeadParams:headerDic withAFHTTPSessionManager:_sessionManager];
    
    if (type == YDDRequestTypePost) {

        //POST
        sessionTask = [_sessionManager POST:requestUrl parameters:bodyDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功后task从当前列表移除
            [[self allSessionTask] removeObject:task];
            //打印返回数据
            [self printResponseObject:responseObject error:nil];
            //回调 message  data
            block ? block([self handleResponseMessage:responseObject], [self handelResponseData:responseObject]) : nil;

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败后task从当前列表移除
            [[self allSessionTask] removeObject:task];
            //打印错误
            [self printResponseObject:nil error:error];
            //错误回调
            block ? block([self handleResponseMessage:nil],nil) : nil;
        }];
    } else if (type == YDDRequestTypeGet) {

        //GET
        sessionTask = [_sessionManager GET:requestUrl parameters:bodyDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //成功后task从当前列表移除
            [[self allSessionTask] removeObject:task];
            //打印返回数据
            [self printResponseObject:responseObject error:nil];
            //回调 message  data
            block ? block([self handleResponseMessage:responseObject], [self handelResponseData:responseObject]) : nil;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //失败后task从当前列表移除
            [[self allSessionTask] removeObject:task];
            //打印错误
            [self printResponseObject:nil error:error];
            //错误回调
            block ? block([self handleResponseMessage:nil],nil) : nil;
        }];
    }
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    NSLog(@"sessionTaskHash:=============%ld",(unsigned long)sessionTask.hash);
    return sessionTask;
}

#pragma mark - **************** 上传单张图片
+ (NSURLSessionTask *)uploadImageWithPath:(NSString *)path
                                    image:(UIImage *)image
                                   params:(NSDictionary *)bodyDic
                                 andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block {
    
    NSArray *array = [NSArray arrayWithObject:image];
    
    return [self uploadImageWithPath:path photos:array params:bodyDic andBlock:block];
}

#pragma mark - **************** 上传图片
+ (NSURLSessionTask *)uploadImageWithPath:(NSString *)path
                                   photos:(NSArray *)photos
                                   params:(NSDictionary *)bodyDic
                                 andBlock:(void (^)(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic))block {
    NSLog(@"===================== 请求的接口地址：%@   ================================",path);
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:path parameters:bodyDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < photos.count; i ++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            formatter.dateFormat=@"yyyyMMddHHmmss";
            NSString *str=[formatter stringFromDate:[NSDate date]];
            NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
            UIImage *image = photos[i];
            NSData *imageData = [NSData compressImageDataWithImage:image];
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%d",i+1] fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress is %lld,总字节 is %lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功后task从当前列表移除
        [[self allSessionTask] removeObject:task];
        //打印返回数据
        [self printResponseObject:responseObject error:nil];
        //回调 message  data
        block ? block(nil, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败后task从当前列表移除
        [[self allSessionTask] removeObject:task];
        //打印错误
        [self printResponseObject:nil error:error];
        //错误回调
        block ? block(nil,nil) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}

#pragma mark - **************** 设置请求头
//设置请求头
+ (void)setHeadParams:(NSDictionary *)params withAFHTTPSessionManager:(AFHTTPSessionManager *)manager {
    //设置header
    if (manager && params && [params count]) {
        for(NSString *key in [params allKeys]) {
            NSString *value = [params objectForKey:key];
            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    if ([UserInfoManager sharedInstance].token.length) {
        NSString *Authorization = [NSString stringWithFormat:@"JWT %@",[UserInfoManager sharedInstance].token];
        [manager.requestSerializer setValue:Authorization forHTTPHeaderField:@"Authorization"];
        NSLog(@"Authorization:%@",Authorization);
    } else {
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
}

#pragma mark - **************** 返回数据处理
/** 错误校验 */
+ (ResponseMessage *)handleResponseMessage:(id)responseObject {
    ResponseMessage *responseMessage = [[ResponseMessage alloc] init];
    if (responseObject) {
        NSDictionary *jsonObjectDic = (NSDictionary *)responseObject;
        if ([jsonObjectDic isKindOfClass:[NSDictionary class]]) {
            if ([jsonObjectDic.allKeys containsObject:@"message"]) {
                NSString *message = [jsonObjectDic objectForKey:@"message"];
                responseMessage.code = kResponseFailureCode;
                responseMessage.message = message;
                [kAppWindow showAutoHideHudWithText:responseMessage.message];
            } else if ([jsonObjectDic.allKeys containsObject:@"message:"]) {
                NSString *message = [jsonObjectDic objectForKey:@"message:"];
                responseMessage.code = kResponseSuccessCode;
                responseMessage.message = message;
            } else {
                responseMessage.code = kResponseSuccessCode;
                responseMessage.message = @"";
            }
        } else {
            responseMessage.code = kResponseSuccessCode;
            responseMessage.message = @"";
        }
    } else {
        responseMessage.code = kResponseFailureCode;
        responseMessage.message = @"网络连接错误，请稍后再试";
    }
    return responseMessage;
}

/** 数据处理 */
+ (NSDictionary *)handelResponseData:(id)responseObject {
    NSDictionary *jsonObjectDic = (NSDictionary *)responseObject;
    return jsonObjectDic;
}

/** 打印返回内容 */
+ (void)printResponseObject:(id)responseObject error:(NSError *)error {
    if (error) {
        NSLog(@"************************** 请求失败 **************************");
        NSLog(@"%@",error.description);
        return;
    }
    NSLog(@"************************** 请求获取到数据 **************************");
    NSDictionary *jsonObjectDic = (NSDictionary *)responseObject;
    NSString *desc = [jsonObjectDic description];
    if (desc) {
        desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    }
    NSLog(@"%@",desc);
}

#pragma mark - **************** 取消请求
/** 取消所有请求 */
+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

/** 取消某一个URL的请求 */
+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - **************** 开始监听网络
+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - **************** 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeoutInterval;
    AFJSONResponseSerializer *response = [[AFJSONResponseSerializer alloc] init];
    response.removesKeysWithNullValues = YES;
    _sessionManager.responseSerializer = response;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
}

#pragma mark - 重置AFHTTPSessionManager相关属性
/// 设置请求头
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

@end
