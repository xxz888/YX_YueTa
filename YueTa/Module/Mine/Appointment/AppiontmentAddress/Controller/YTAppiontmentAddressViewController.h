//
//  YTAppiontmentAddressViewController.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/3.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddressComfirmBlock)(NSString *area, NSString *site, CLLocationCoordinate2D coordinate);

@interface YTAppiontmentAddressViewController : BaseViewController

@property (nonatomic, copy) AddressComfirmBlock addressComfirmBlock;

@end

NS_ASSUME_NONNULL_END
