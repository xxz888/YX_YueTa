//
//  YDDRequestManager.m
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/2.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "YDDRequestManager.h"
#import "YDDRequestHelper.h"

@implementation YDDRequestManager

+ (NSURLSessionTask *)executeGET:(NSString *)requestUrl requestBody:(NSMutableDictionary *)bodyDic andBlock:(void (^)(ResponseMessage *, NSDictionary *))block {
    return [YDDRequestHelper executeRequestWithType:YDDRequestTypeGet
                                            headers:nil
                                         requestUrl:requestUrl
                                       requestCount:1
                                        requestBody:bodyDic
                                           andBlock:block];
}

+ (NSURLSessionTask *)executePOST:(NSString *)requestUrl requestBody:(NSMutableDictionary *)bodyDic andBlock:(void (^)(ResponseMessage *, NSDictionary *))block {
    return [YDDRequestHelper executeRequestWithType:YDDRequestTypePost
                                            headers:nil
                                         requestUrl:requestUrl
                                       requestCount:1
                                        requestBody:bodyDic
                                           andBlock:block];
}

+ (NSURLSessionTask *)executeTokenPOST:(NSString *)requestUrl requestBody:(NSMutableDictionary *)bodyDic andBlock:(void (^)(ResponseMessage *, NSDictionary *))block {
    NSString *token = [UserInfoManager sharedInstance].token;
    if (bodyDic) {
        if (token) {
            [bodyDic setObject:token forKey:@"token"];
        }
    } else {
        if (token) {
            bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
            [bodyDic setObject:token forKey:@"token"];
        }
    }
    
    return [YDDRequestHelper executeRequestWithType:YDDRequestTypePost
                                            headers:nil
                                         requestUrl:requestUrl
                                       requestCount:1
                                        requestBody:bodyDic
                                           andBlock:block];
}

+ (NSURLSessionTask *)executeTokenGET:(NSString *)requestUrl requestBody:(NSMutableDictionary *)bodyDic andBlock:(void (^)(ResponseMessage *, NSDictionary *))block {
    NSString *token = [UserInfoManager sharedInstance].token;
    if (bodyDic) {
        if (token) {
            [bodyDic setObject:token forKey:@"token"];
        }
    } else {
        if (token) {
            bodyDic = [NSMutableDictionary dictionaryWithCapacity:0];
            [bodyDic setObject:token forKey:@"token"];
        }
    }
    
    return [YDDRequestHelper executeRequestWithType:YDDRequestTypeGet
                                            headers:nil
                                         requestUrl:requestUrl
                                       requestCount:1
                                        requestBody:bodyDic
                                           andBlock:block];
}

+ (void)uploadImageWithImage:(UIImage *)image andBlock:(void (^)(NSArray *))block {
    NSDictionary *dict = @{
                           @"PlatForm":@"MZY",
                           @"Path":@"/Upload/MZY"
                           };
    [YDDRequestHelper uploadImageWithPath:@"自己填写" image:image params:dict andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *imageStrArr = [responseDataDic mutableCopy];
        return block(imageStrArr);
    }];
}

+ (void)uploadImagesWithArray:(NSArray *)array andBlock:(void (^)(NSArray *))block {
    NSDictionary *dict = @{
                           @"PlatForm":@"MZY",
                           @"Path":@"/Upload/MZY"
                           };
    [YDDRequestHelper uploadImageWithPath:@"自己填写" photos:array params:dict andBlock:^(ResponseMessage *rspStatusAndMessage, NSDictionary *responseDataDic) {
        NSArray *imageStrArr = [responseDataDic mutableCopy];
        return block(imageStrArr);
    }];
}


@end
