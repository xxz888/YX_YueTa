//
//  YTAppiontmentPersonCell.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/17.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTApplyModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AppiontmentButtonClickBlock)(YTApplyModel *model);

@interface YTAppiontmentPersonCell : UITableViewCell

@property (nonatomic, strong) YTApplyModel *applyModel;

@property (nonatomic, copy) AppiontmentButtonClickBlock appiontmentButtonClickBlock;

@end

NS_ASSUME_NONNULL_END
