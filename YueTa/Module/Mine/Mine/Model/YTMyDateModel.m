//
//  YTMyDateModel.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyDateModel.h"

@implementation YTMyDateModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"dateId": @"id",
             @"userId": @"user_id"
             };
}

- (NSArray *)picList {
    if (!_picList) {
        NSMutableArray *picArray = [NSMutableArray array];
        
        if ([self.show1 containsString:@"jpg"]) {
            [picArray addObject:self.show1];
        }
        if ([self.show2 containsString:@"jpg"]) {
            [picArray addObject:self.show2];
        }
        if ([self.show3 containsString:@"jpg"]) {
            [picArray addObject:self.show3];
        }
        if ([self.show4 containsString:@"jpg"]) {
            [picArray addObject:self.show4];
        }
        _picList = [picArray copy];
    }
    return _picList;
}

@end
