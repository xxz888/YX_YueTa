//
//  ResponseMessage.m
//  ManZhiYan
//
//  Created by 姚兜兜 on 2018/3/2.
//  Copyright © 2018年 姚兜兜. All rights reserved.
//

#import "ResponseMessage.h"

@implementation ResponseMessage

- (instancetype)initWithErrorCode:(NSInteger)errorCode message:(NSString *)message {
    if (self = [super init]) {
        _code = errorCode;
        _message = message;
    }
    return self;
}

@end
