//
//  YTMyFansCell.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTRelationUserModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RelationRightButtonClickBlock)(YTRelationUserModel *model);

@interface YTMyFansCell : UITableViewCell

@property (nonatomic, strong) YTRelationUserModel *model;

@property (nonatomic, copy) RelationRightButtonClickBlock relationRightButtonClickBlock;

- (void)configureCellByModel:(YTRelationUserModel *)model
                        type:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
