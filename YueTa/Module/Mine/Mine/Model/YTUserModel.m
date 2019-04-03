//
//  YTUserModel.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTUserModel.h"

@implementation YTUserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"userId": @"id"
             };
}

@end
