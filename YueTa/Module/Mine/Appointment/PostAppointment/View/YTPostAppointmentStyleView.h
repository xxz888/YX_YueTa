//
//  YTPostAppointmentStyleView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^StyleClickedBlock)(void);
typedef void(^RewardTypeClickBlock)(NSInteger index);

@interface YTPostAppointmentStyleView : UIView

@property (nonatomic, copy) StyleClickedBlock styleClickedBlock;
@property (nonatomic, copy) RewardTypeClickBlock rewardTypeClickBlock;

- (void)refreshViewByMoney:(NSString *)money;

@end

NS_ASSUME_NONNULL_END
