//
//  YTNearListCell.h
//  YueTa
//
//  Created by 姚兜兜 on 2019/1/23.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef void(^YTNearListCellBlock)(NSInteger row);

NS_ASSUME_NONNULL_BEGIN

@interface YTNearListCell : BaseTableViewCell

@property (nonatomic, copy) YTNearListCellBlock block;

@end

NS_ASSUME_NONNULL_END
