//
//  YTAppiontmentPersonCell.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/17.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTAppiontmentPersonCell.h"

@interface YTAppiontmentPersonCell ()

@property (nonatomic, strong) UIImageView *avartarImageView;
@property (nonatomic, strong) UIImageView *vipImageView;
@property (nonatomic, strong) UILabel *authLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *acceptButton;

@end

@implementation YTAppiontmentPersonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.avartarImageView];
        [self.contentView addSubview:self.vipImageView];
        [self.contentView addSubview:self.authLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.acceptButton];
        
        [self.avartarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kRealValue(15));
            make.centerY.equalTo(self.contentView);
            make.width.and.height.equalTo(@kRealValue(50));
        }];
        
        [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.avartarImageView.mas_top).offset(kRealValue(5));
            make.centerX.equalTo(self.avartarImageView);
            make.size.mas_equalTo(CGSizeMake(kRealValue(15), kRealValue(15)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_centerY).offset(-kRealValue(5));
            make.left.equalTo(self.avartarImageView.mas_right).offset(kRealValue(15));
            make.right.equalTo(self.acceptButton.mas_left).offset(-kRealValue(15));
        }];
        
        [self.authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_centerY).offset(kRealValue(5));
            make.left.equalTo(self.avartarImageView.mas_right).offset(kRealValue(15));
            make.width.and.height.equalTo(@kRealValue(20));
        }];
        
        [self.acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-kRealValue(15));
            make.size.mas_equalTo(CGSizeMake(kRealValue(80), kRealValue(30)));
        }];
    }
    return self;
}

- (void)acceptButtonClicked:(UIButton *)button {
    if (self.appiontmentButtonClickBlock) {
        self.appiontmentButtonClickBlock(self.applyModel);
    }
}

- (UIImageView *)avartarImageView {
    if (!_avartarImageView) {
        _avartarImageView = [[UIImageView alloc] init];
        _avartarImageView.layer.cornerRadius = kRealValue(25);
        _avartarImageView.layer.masksToBounds = YES;
        _avartarImageView.image = [UIImage imageNamed:@"ic_head_pink"];
    }
    return _avartarImageView;
}

- (UIImageView *)vipImageView {
    if (!_vipImageView) {
        _vipImageView = [[UIImageView alloc] init];
        _vipImageView.image = [UIImage imageNamed:@"ic_vip"];
    }
    return _vipImageView;
}

- (UILabel *)authLabel {
    if (!_authLabel) {
        _authLabel = [UILabel labelWithName:@"证" Font:kSystemFont12 textColor:kWhiteTextColor textAlignment:NSTextAlignmentCenter];
        _authLabel.backgroundColor = kYellowBackgroundColor;
        _authLabel.layer.cornerRadius = kRealValue(10);
        _authLabel.clipsToBounds = YES;
    }
    return _authLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithName:@"木木" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

- (UIButton *)acceptButton {
    if (!_acceptButton) {
        _acceptButton = [UIButton buttonWithTitle:@"与T相约" taget:self action:@selector(acceptButtonClicked:) font:kSystemFont14 titleColor:kWhiteTextColor];
        _acceptButton.layer.cornerRadius = 8;
        _acceptButton.backgroundColor = kPurpleTextColor;
    }
    return _acceptButton;
}

- (void)setApplyModel:(YTApplyModel *)applyModel {
    _applyModel = applyModel;
    
    if (applyModel.photo.length) {
        [_avartarImageView sd_setImageWithURL:[NSURL URLWithString:applyModel.photo]];
    } else {
        _avartarImageView.image = [UIImage imageNamed:@"ic_head_pink"];
    }
    
    _vipImageView.hidden = !applyModel.VIP;
    
    _authLabel.hidden = !applyModel.auth_job || applyModel.auth_status;
    
    _nameLabel.text = applyModel.username;
    
    if (applyModel.status == 2) {
        [_acceptButton setTitle:@"邀约成功" forState:UIControlStateNormal];
        _acceptButton.backgroundColor = kPurpleTextColor;
    } else {
        [_acceptButton setTitle:@"与T相约" forState:UIControlStateNormal];
        _acceptButton.backgroundColor = kPurpleTextColor;
    }
}


@end
