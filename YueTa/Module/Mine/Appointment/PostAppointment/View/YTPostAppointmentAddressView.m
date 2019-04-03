//
//  YTPostAppointmentAddressView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTPostAppointmentAddressView.h"

@interface YTPostAppointmentAddressView ()

@end

@implementation YTPostAppointmentAddressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftTitleLabel];
        [self addSubview:self.selectButton];
        [self addSubview:self.rightImageView];
        
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(kRealValue(15));
            make.width.equalTo(@kRealValue(90));
        }];
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.left.equalTo(self.leftTitleLabel.mas_right);
            make.right.equalTo(self.rightImageView.mas_left).offset(-kRealValue(15));
        }];
        
        [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-kRealValue(15));
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kRealValue(16), kRealValue(16)));
        }];
    }
    return self;
}

- (void)refreshViewByAddress:(NSString *)address {
    [self.selectButton setTitle:address forState:UIControlStateNormal];
}

- (void)selectButtonClicked {
    if (self.selectAddressBlock) {
        self.selectAddressBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [UILabel labelWithName:@"约会地点" Font:kSystemFont16 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _leftTitleLabel;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithTitle:@"请选择(非必填)" taget:self action:@selector(selectButtonClicked) font:kSystemFont16 titleColor:kGrayTextColor];
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


@end
