//
//  YTMyFansCell.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyFansCell.h"

@interface YTMyFansCell ()

@property (nonatomic, strong) UIImageView *avartarImageView;
@property (nonatomic, strong) UIImageView *vipImageView;
@property (nonatomic, strong) UILabel *authLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *focusButton;

@end

@implementation YTMyFansCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.avartarImageView];
        [self.contentView addSubview:self.vipImageView];
        [self.contentView addSubview:self.authLabel];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.focusButton];

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
            make.right.equalTo(self.focusButton.mas_left).offset(-kRealValue(15));
        }];
        
        [self.authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_centerY).offset(kRealValue(5));
            make.left.equalTo(self.avartarImageView.mas_right).offset(kRealValue(15));
            make.width.and.height.equalTo(@kRealValue(20));
        }];

        
        [self.focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-kRealValue(15));
            make.size.mas_equalTo(CGSizeMake(kRealValue(70), kRealValue(30)));
        }];
    }
    return self;
}

- (void)focusButtonClicked:(UIButton *)button {
    if (self.relationRightButtonClickBlock) {
        self.relationRightButtonClickBlock(self.model);
    }
}

- (UIImageView *)avartarImageView {
    if (!_avartarImageView) {
        _avartarImageView = [[UIImageView alloc] init];
        _avartarImageView.layer.cornerRadius = kRealValue(25);
        _avartarImageView.layer.masksToBounds = YES;
        _avartarImageView.backgroundColor = kGrayBackgroundColor;
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

- (UIButton *)focusButton {
    if (!_focusButton) {
        _focusButton = [UIButton buttonWithTitle:@"关注" taget:self action:@selector(focusButtonClicked:) font:kSystemFont15 titleColor:kWhiteTextColor];
        _focusButton.layer.cornerRadius = 8;
        _focusButton.backgroundColor = kPurpleTextColor;
    }
    return _focusButton;
}

- (void)configureCellByModel:(YTRelationUserModel *)model type:(NSInteger)type {
    _model = model;
    
    [_avartarImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    
    _vipImageView.hidden = !model.VIP;
    
    _authLabel.hidden = !model.auth_status || !model.auth_job;
    
    _nameLabel.text = model.username;
    
    if (type == 0) {
        if (model.mutual_fans) {
            [_focusButton setTitle:@"已关注" forState:UIControlStateNormal];
        } else {
            [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
        }
    } else if (type == 1) {
        //like
        [_focusButton setTitle:@"已关注" forState:UIControlStateNormal];
    } else if (type == 2) {
        //black
        [_focusButton setTitle:@"取消屏蔽" forState:UIControlStateNormal];
    }
}

@end
