//
//  YTPayPackageView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/21.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YTYueDouPackageView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^YueDouPackageViewClickBlock)(YTYueDouPackageView *view);

@interface YTYueDouPackageView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) YueDouPackageViewClickBlock yueDouPackageViewClickBlock;

@end

NS_ASSUME_NONNULL_END
