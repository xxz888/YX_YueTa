//
//  AllInfoModel.m
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/15.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "AllInfoModel.h"

@implementation AllInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"famaleJobsArr": @"女性职业",
             @"maleJobsArr": @"男性职业",
             @"moneyArr": @"金额",
             @"engagementArr": @"约会节目",
             @"personalaArr": @"个人标签",
             };
}

@end
