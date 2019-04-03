//
//  YTBasicInfoTitleCell.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTBasicInfoTitleCell : UITableViewCell

@property (nonatomic, strong) YTSettingItem *item;

- (void)configureCellBySettingItem:(YTSettingItem *)item;

@end

NS_ASSUME_NONNULL_END
