//
//  YTPostAppointmentStyleView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPostAppointmentStyleView.h"

@interface YTPostAppointmentStyleView ()

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIButton *rewardButton;
@property (nonatomic, strong) UIButton *seekingRewardButton;
@property (nonatomic, strong) UIView *sepLine;

@end

@implementation YTPostAppointmentStyleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftTitleLabel];
        [self addSubview:self.selectButton];
        [self addSubview:self.rightImageView];
        [self addSubview:self.rewardButton];
        [self addSubview:self.seekingRewardButton];
        [self addSubview:self.sepLine];

        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.sepLine).offset(-kRealValue(8));
            make.left.equalTo(self).offset(kRealValue(15));
            make.width.equalTo(@kRealValue(90));
        }];
        
        [self.rewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.sepLine).offset(-kRealValue(8));
            make.left.equalTo(self.leftTitleLabel.mas_right);
            make.size.mas_equalTo(CGSizeMake(kRealValue(80), kRealValue(30)));
        }];
        
        [self.seekingRewardButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.sepLine).offset(-kRealValue(8));
            make.left.equalTo(self.rewardButton.mas_right).offset(kRealValue(20));
            make.size.mas_equalTo(CGSizeMake(kRealValue(80), kRealValue(30)));
        }];
        
        [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@kRealValue(90));
            make.right.equalTo(self).offset(-kRealValue(15));
            make.height.equalTo(@1);
        }];
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sepLine.mas_bottom);
            make.bottom.equalTo(self);
            make.left.equalTo(self.leftTitleLabel.mas_right);
            make.right.equalTo(self).offset(-kRealValue(15));
        }];
        
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-kRealValue(15));
            make.centerY.equalTo(self.selectButton);
            make.size.mas_equalTo(CGSizeMake(kRealValue(16), kRealValue(16)));
        }];
        
        [self rewardButtonClicked];
    }
    return self;
}

- (void)refreshViewByMoney:(NSString *)money {
    [self.selectButton setTitle:money forState:UIControlStateNormal];
    [self.selectButton setTitleColor:kBlackTextColor forState:UIControlStateNormal];
}

- (void)selectButtonClicked {
    if (self.styleClickedBlock) {
        self.styleClickedBlock();
    }
}

- (void)rewardButtonClicked {
    _seekingRewardButton.layer.borderWidth = 1;
    _seekingRewardButton.backgroundColor = [UIColor whiteColor];
    _seekingRewardButton.selected = NO;
    
    _rewardButton.layer.borderWidth = 0;
    _rewardButton.backgroundColor = kPurpleTextColor;
    _rewardButton.selected = YES;
    
    if (self.rewardTypeClickBlock) {
        self.rewardTypeClickBlock(0);
    }
}

- (void)seekingRewardButtonClicked {
    _rewardButton.layer.borderWidth = 1;
    _rewardButton.backgroundColor = [UIColor whiteColor];
    _rewardButton.selected = NO;
    
    _seekingRewardButton.layer.borderWidth = 0;
    _seekingRewardButton.backgroundColor = kPurpleTextColor;
    _seekingRewardButton.selected = YES;
    
    if (self.rewardTypeClickBlock) {
        self.rewardTypeClickBlock(1);
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [UILabel labelWithName:@"约会方式" Font:kSystemFont16 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _leftTitleLabel;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithTitle:@"选择打赏金额" taget:self action:@selector(selectButtonClicked) font:kSystemFont16 titleColor:kGrayTextColor];
        _selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _selectButton;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"ic_arrow_right"];
    }
    return _rightImageView;
}

- (UIButton *)rewardButton {
    if (!_rewardButton) {
        _rewardButton = [UIButton buttonWithTitle:@"打赏" taget:self action:@selector(rewardButtonClicked) font:kSystemFont16 titleColor:kBlackTextColor];
        [_rewardButton setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
        _rewardButton.layer.cornerRadius = 15;
        _rewardButton.layer.borderWidth = 1;
        _rewardButton.layer.borderColor = kSepLineGrayBackgroundColor.CGColor;
    }
    return _rewardButton;
}

- (UIButton *)seekingRewardButton {
    if (!_seekingRewardButton) {
        _seekingRewardButton = [UIButton buttonWithTitle:@"求打赏" taget:self action:@selector(seekingRewardButtonClicked) font:kSystemFont16 titleColor:kBlackTextColor];
        [_seekingRewardButton setTitleColor:kWhiteTextColor forState:UIControlStateSelected];
        _seekingRewardButton.layer.cornerRadius = 15;
        _seekingRewardButton.layer.borderWidth = 1;
        _seekingRewardButton.layer.borderColor = kSepLineGrayBackgroundColor.CGColor;

    }
    return _seekingRewardButton;
}

- (UIView *)sepLine {
    if (!_sepLine) {
        _sepLine = [[UIView alloc] init];
        _sepLine.backgroundColor = kSepLineGrayBackgroundColor;
    }
    return _sepLine;
}

@end
