//
//  YTPostAppointmentAddressView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectAddressBlock)(void);

@interface YTPostAppointmentAddressView : UIView

@property (nonatomic, copy) SelectAddressBlock selectAddressBlock;

- (void)refreshViewByAddress:(NSString *)address;

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

NS_ASSUME_NONNULL_END
