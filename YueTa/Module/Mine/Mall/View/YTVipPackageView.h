//
//  YTVipPackageView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTVipPackageView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^VipPackageViewClickBlock)(YTVipPackageView *view);

@interface YTVipPackageView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) VipPackageViewClickBlock vipPackageViewClickBlock;

@end

NS_ASSUME_NONNULL_END
