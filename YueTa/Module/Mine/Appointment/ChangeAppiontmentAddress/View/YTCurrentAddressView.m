//
//  YTCurrentAddressView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/4.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTCurrentAddressView.h"

@interface YTCurrentAddressView ()

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UILabel *currentAddresLabel;
@property (nonatomic, strong) UIButton *locationButton;

@end

@implementation YTCurrentAddressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftTitleLabel];
        [self addSubview:self.currentAddresLabel];
        [self addSubview:self.locationButton];

        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kRealValue(10));
            make.centerY.equalTo(self);
            make.width.equalTo(@kRealValue(80));
        }];
        
        [self.currentAddresLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftTitleLabel.mas_right).offset(kRealValue(5));
            make.centerY.equalTo(self);
            make.right.equalTo(self.locationButton.mas_left);
        }];
        
        [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.and.right.equalTo(self);
            make.width.equalTo(@kRealValue(50));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressViewTapped)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)locationButtonClicked {
    if (self.locationClickedBlock) {
        self.locationClickedBlock();
    }
}

- (void)addressViewTapped {
    if (self.addressSelectedBlock) {
        self.addressSelectedBlock();
    }
}

- (void)refreshByAddress:(NSString *)address {
    self.currentAddresLabel.text = address;
}

#pragma mark - **************** Setter Getter
- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [UILabel labelWithName:@"当前城市" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _leftTitleLabel;
}

- (UILabel *)currentAddresLabel {
    if (!_currentAddresLabel) {
        _currentAddresLabel = [UILabel labelWithName:nil Font:kSystemFont15 textColor:kPurpleTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _currentAddresLabel;
}

- (UIButton *)locationButton {
    if (!_locationButton) {
        _locationButton = [UIButton buttonWithImage:@"ic_location_round" taget:self action:@selector(locationButtonClicked)];
    }
    return _locationButton;
}

@end
