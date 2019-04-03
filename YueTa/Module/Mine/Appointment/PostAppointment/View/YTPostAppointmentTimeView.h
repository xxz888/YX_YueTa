//
//  YTPostAppointmentTimeView.h
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TimeClickedBlock)(void);
typedef void(^DateClickedBlock)(void);

@interface YTPostAppointmentTimeView : UIView

@property (nonatomic, copy) TimeClickedBlock timeClickedBlock;
@property (nonatomic, copy) DateClickedBlock dateClickedBlock;

- (void)refreshViewByTime:(NSString *)time;
- (void)refreshViewByDate:(NSString *)date;

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) UIView *sepLine;

@end

NS_ASSUME_NONNULL_END
