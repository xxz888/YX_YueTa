//
//  YTSettingItem.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTSettingItem.h"

@implementation YTSettingItem

- (instancetype)init {
    if (self = [super init]) {
        _cellType = YTSettingItemTypeDefault;
        _cellHeight = kRealValue(60);
        _cellID = @"SystemCellID";
    }
    return self;
}

- (void)setCellType:(YTSettingItemType)cellType {
    _cellType = cellType;
    
    _cellID = [NSString stringWithFormat:@"SystemCellID%ld",(long)cellType];
}

@end
