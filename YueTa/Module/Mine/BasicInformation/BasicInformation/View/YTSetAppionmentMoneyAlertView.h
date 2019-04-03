//
//  YTSetAppionmentMoneyAlertView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/12.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MoneySetBlock)(NSString *money);

@interface YTSetAppionmentMoneyAlertView : UIView

+ (void)showAlertViewMoenySetBlock:(MoneySetBlock)block;

@end

NS_ASSUME_NONNULL_END
