//
//  YTChangeAppionmentAddressViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/4.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectAddressBlock)(NSString *proviceName, NSString *cityName);

@interface YTChangeAppionmentAddressViewController : BaseViewController

@property (nonatomic, copy) SelectAddressBlock selectAddressBlock;

@end

NS_ASSUME_NONNULL_END
