//
//  YTCurrentAddressView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/4.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LocationClickedBlock)(void);
typedef void(^AddressSelectedBlock)(void);

@interface YTCurrentAddressView : UIView

@property (nonatomic, copy) LocationClickedBlock locationClickedBlock;
@property (nonatomic, copy) AddressSelectedBlock addressSelectedBlock;

- (void)refreshByAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
