//
//  YTAppiontmentSearchViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/7.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LocationClickedBlock)(AMapPOI *poi);

@interface YTAppiontmentSearchViewController : BaseViewController

/// 当前位置
@property (nonatomic, copy) NSString *currentCity;

@property (nonatomic, copy) LocationClickedBlock locationClickedBlock;

@end

NS_ASSUME_NONNULL_END
