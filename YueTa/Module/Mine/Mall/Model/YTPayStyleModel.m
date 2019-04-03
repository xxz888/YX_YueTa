//
//  YTPayStyleModel.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPayStyleModel.h"

@implementation YTPayStyleModel

- (instancetype)initWithLeftImageName:(NSString *)leftImageName titleName:(NSString *)titleName isSelected:(BOOL)isSelected {
    if (self = [super init]) {
        _leftImageName = leftImageName;
        _titleName = titleName;
        _isSelected = isSelected;
    }
    return self;
}

@end
