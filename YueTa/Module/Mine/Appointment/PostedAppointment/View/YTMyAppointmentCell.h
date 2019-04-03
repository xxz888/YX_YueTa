//
//  YTPostedAppointmentCell.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTMyDateModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^IgnoreButtonClickBlock)(YTMyDateModel *model);
typedef void(^AgreeButtonClickBlock)(YTMyDateModel *model);

@interface YTMyAppointmentCell : UITableViewCell

@property (nonatomic, strong) YTMyDateModel *model;

@property (nonatomic, copy) IgnoreButtonClickBlock ignoreButtonClickBlock;
@property (nonatomic, copy) AgreeButtonClickBlock agreeButtonClickBlock;

- (void)configureCellByModel:(YTMyDateModel *)model
                        type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
