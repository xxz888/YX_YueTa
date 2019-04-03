//
//  YTPostAppointmentTimeView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPostAppointmentTimeView.h"

@interface YTPostAppointmentTimeView ()

@end

@implementation YTPostAppointmentTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftTitleLabel];
        [self addSubview:self.selectButton];
        [self addSubview:self.rightImageView];
        [self addSubview:self.timeButton];
        [self addSubview:self.sepLine];
        
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.sepLine).offset(-kRealValue(8));
            make.left.equalTo(self).offset(kRealValue(15));
            make.width.equalTo(@kRealValue(90));
        }];
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.sepLine.mas_bottom);
            make.top.equalTo(self);
            make.left.equalTo(self.leftTitleLabel.mas_right);
            make.right.equalTo(self).offset(-kRealValue(15));
        }];
        
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-kRealValue(15));
            make.centerY.equalTo(self.selectButton);
            make.size.mas_equalTo(CGSizeMake(kRealValue(16), kRealValue(16)));
        }];
        
        [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@kRealValue(90));
            make.right.equalTo(self).offset(-kRealValue(15));
            make.height.equalTo(@1);
        }];
        
        [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sepLine.mas_bottom);
            make.bottom.equalTo(self);
            make.left.equalTo(self.leftTitleLabel.mas_right);
            make.right.equalTo(self).offset(-kRealValue(15));
        }];
    }
    return self;
}

- (void)refreshViewByTime:(NSString *)time {
    [self.timeButton setTitle:time forState:UIControlStateNormal];
    [self.timeButton setTitleColor:kBlackTextColor forState:UIControlStateNormal];
}

- (void)refreshViewByDate:(NSString *)date {
    [self.selectButton setTitle:date forState:UIControlStateNormal];
    [self.selectButton setTitleColor:kBlackTextColor forState:UIControlStateNormal];
}

- (void)selectButtonClicked {
    if (self.dateClickedBlock) {
        self.dateClickedBlock();
    }
}

- (void)timeButtonClicked {
    if (self.timeClickedBlock) {
        self.timeClickedBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [UILabel labelWithName:@"约会时间" Font:kSystemFont16 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _leftTitleLabel;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithTitle:@"选择日期(非必填)" taget:self action:@selector(selectButtonClicked) font:kSystemFont16 titleColor:kGrayTextColor];
        _selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _selectButton;
}

- (UIButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithTitle:@"选择时间(非必填)" taget:self action:@selector(timeButtonClicked) font:kSystemFont16 titleColor:kGrayTextColor];
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _timeButton;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    }
    return _rightImageView;
}

- (UIView *)sepLine {
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = kSepLineGrayBackgroundColor;
    }
    return _sepLine;
}


@end
