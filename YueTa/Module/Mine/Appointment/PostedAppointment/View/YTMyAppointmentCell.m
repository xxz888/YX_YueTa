//
//  YTPostedAppointmentCell.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/14.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMyAppointmentCell.h"

@interface YTMyAppointmentCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *avartarImageView;
@property (nonatomic, strong) UIImageView *vipImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *authLabel;
@property (nonatomic, strong) UIImageView *sexImageView;
@property (nonatomic, strong) UILabel *postTimeLabel;
@property (nonatomic, strong) UIImageView *picimageView;

@property (nonatomic, strong) UIView *appiontmentBorderView;
@property (nonatomic, strong) UILabel *appiontmentTimeLabel;
@property (nonatomic, strong) UILabel *appiontmentLocationLabel;
@property (nonatomic, strong) UILabel *appiontmentContentLabel;
@property (nonatomic, strong) UILabel *appiontmentMoneyTitleLabel;
@property (nonatomic, strong) UILabel *appiontmentMoneyLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UIView *appiontmentBottomSepLine;
@property (nonatomic, strong) UIButton *checkDetailButton;
@property (nonatomic, strong) UIButton *ignoreButton;
@property (nonatomic, strong) UIButton *agreeButton;

@end

@implementation YTMyAppointmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.avartarImageView];
        [self.containerView addSubview:self.vipImageView];
        [self.containerView addSubview:self.nameLabel];
        [self.containerView addSubview:self.sexImageView];
        [self.containerView addSubview:self.postTimeLabel];
        [self.containerView addSubview:self.appiontmentBorderView];
        [self.containerView addSubview:self.picimageView];

        [self.appiontmentBorderView addSubview:self.appiontmentTimeLabel];
        [self.appiontmentBorderView addSubview:self.appiontmentLocationLabel];
        [self.appiontmentBorderView addSubview:self.appiontmentContentLabel];
        [self.appiontmentBorderView addSubview:self.appiontmentMoneyTitleLabel];
        [self.appiontmentBorderView addSubview:self.appiontmentMoneyLabel];
        [self.appiontmentBorderView addSubview:self.stateLabel];
        [self.containerView addSubview:self.appiontmentBottomSepLine];
        [self.containerView addSubview:self.checkDetailButton];
        [self.containerView addSubview:self.ignoreButton];
        [self.containerView addSubview:self.agreeButton];

        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(kRealValue(15));
            make.right.equalTo(self.contentView).offset(-kRealValue(15));
            make.height.equalTo(@kRealValue(240));
        }];
        
        [self.avartarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(kRealValue(15));
            make.top.equalTo(self.containerView).offset(kRealValue(15));
            make.width.and.height.equalTo(@kRealValue(50));
        }];
        
        [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.avartarImageView.mas_top).offset(kRealValue(5));
            make.centerX.equalTo(self.avartarImageView);
            make.size.mas_equalTo(CGSizeMake(kRealValue(15), kRealValue(15)));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avartarImageView).offset(kRealValue(5));
            make.left.equalTo(self.avartarImageView.mas_right).offset(kRealValue(15));
            make.width.lessThanOrEqualTo(@kRealValue(150));
        }];
        
        [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.left.equalTo(self.nameLabel.mas_right).offset(kRealValue(10));
            make.width.and.height.equalTo(@kRealValue(16));
        }];
        
        [self.authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.left.equalTo(self.sexImageView.mas_right).offset(kRealValue(10));
            make.width.and.height.equalTo(@kRealValue(20));
        }];
        
        [self.postTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.avartarImageView.mas_bottom).offset(-kRealValue(5));
            make.left.equalTo(self.avartarImageView.mas_right).offset(kRealValue(15));
            make.right.equalTo(self.containerView.mas_right).offset(-kRealValue(15));
        }];
        
        [self.picimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.containerView).offset(-kRealValue(15));
            make.top.equalTo(self.containerView).offset(kRealValue(15));
            make.width.and.height.equalTo(@kRealValue(50));
        }];
        
        [self.appiontmentBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avartarImageView.mas_bottom).offset(kRealValue(15));
            make.left.equalTo(self.containerView).offset(kRealValue(15));
            make.right.equalTo(self.containerView).offset(-kRealValue(15));
            make.height.equalTo(@kRealValue(105));
        }];

        [self.appiontmentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentBorderView).offset(kRealValue(15));
            make.left.equalTo(self.appiontmentBorderView).offset(kRealValue(15));
            make.right.equalTo(self.appiontmentLocationLabel.mas_left).offset(-kRealValue(15));
            make.height.equalTo(@kRealValue(17));
        }];
        
        [self.appiontmentLocationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentBorderView).offset(kRealValue(15));
            make.width.equalTo(@kRealValue(70));
            make.right.equalTo(self.appiontmentBorderView).offset(-kRealValue(15));
            make.height.equalTo(@kRealValue(17));
        }];

        [self.appiontmentContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentTimeLabel.mas_bottom).offset(kRealValue(10));
            make.left.and.right.and.height.equalTo(self.appiontmentTimeLabel);
        }];

        [self.appiontmentMoneyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentContentLabel.mas_bottom).offset(kRealValue(10));
            make.left.equalTo(self.appiontmentTimeLabel);
            make.width.equalTo(@kRealValue(50));
        }];
        
        [self.appiontmentMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentContentLabel.mas_bottom).offset(kRealValue(10));
            make.right.equalTo(self.stateLabel.mas_left).offset(-kRealValue(10));
            make.left.equalTo(self.appiontmentMoneyTitleLabel.mas_right);
        }];
        
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.appiontmentMoneyTitleLabel);
            make.right.equalTo(self.appiontmentBorderView).offset(-kRealValue(10));
            make.height.equalTo(@kRealValue(25));
            make.width.equalTo(@kRealValue(70));
        }];

        [self.appiontmentBottomSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentBorderView.mas_bottom).offset(kRealValue(10));
            make.left.and.right.equalTo(self.containerView);
            make.height.equalTo(@1);
        }];

        [self.checkDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentBottomSepLine.mas_bottom);
            make.left.and.right.and.bottom.equalTo(self.containerView);
        }];
        
        [self.ignoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentBottomSepLine.mas_bottom).offset(kRealValue(10));
            make.right.equalTo(self.containerView.mas_centerX).offset(-kRealValue(8));
            make.size.mas_equalTo(CGSizeMake(kRealValue(80), kRealValue(25)));
        }];
        
        [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.appiontmentBottomSepLine.mas_bottom).offset(kRealValue(10));
            make.left.equalTo(self.containerView.mas_centerX).offset(kRealValue(8));
            make.size.mas_equalTo(CGSizeMake(kRealValue(80), kRealValue(25)));
        }];
    }
    return self;
}

#pragma mark - **************** Event Response
- (void)checkDetailButtonClicked {
    
}


- (void)agreeButtonClicked {
    if (self.agreeButtonClickBlock) {
        self.agreeButtonClickBlock(self.model);
    }
}

- (void)ignoreButtonClicked {
    if (self.ignoreButtonClickBlock) {
        self.ignoreButtonClickBlock(self.model);
    }
}

#pragma mark - **************** Setter Getter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 8;
        _containerView.layer.shadowOffset = CGSizeMake(0, 1);
        _containerView.layer.shadowColor = kGrayBorderColor.CGColor;
        _containerView.layer.shadowOpacity = 0.7f;
    }
    return _containerView;
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithName:@"木木" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

- (UIImageView *)sexImageView {
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc] init];
        _sexImageView.image = [UIImage imageNamed:@"ic_female"];
    }
    return _sexImageView;
}

- (UILabel *)postTimeLabel {
    if (!_postTimeLabel) {
        _postTimeLabel = [UILabel labelWithName:@"刚刚" Font:kSystemFont13 textColor:kYellowTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _postTimeLabel;
}

- (UIImageView *)picimageView {
    if (!_picimageView) {
        _picimageView = [[UIImageView alloc] init];
        _picimageView.layer.cornerRadius = 5;
        _picimageView.layer.masksToBounds = YES;
        _picimageView.backgroundColor = kGrayBackgroundColor;
    }
    return _picimageView;
}

- (UIView *)appiontmentBorderView {
    if (!_appiontmentBorderView) {
        _appiontmentBorderView = [[UIView alloc] init];
        _appiontmentBorderView.backgroundColor = [UIColor whiteColor];
        _appiontmentBorderView.layer.borderColor = kGrayBorderColor.CGColor;
        _appiontmentBorderView.layer.borderWidth = 1;
        _appiontmentBorderView.layer.cornerRadius = 8;
    }
    return _appiontmentBorderView;
}

- (UILabel *)appiontmentTimeLabel {
    if (!_appiontmentTimeLabel) {
        _appiontmentTimeLabel = [UILabel labelWithName:@"约会时间：" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _appiontmentTimeLabel;
}

- (UILabel *)appiontmentLocationLabel {
    if (!_appiontmentLocationLabel) {
        _appiontmentLocationLabel = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _appiontmentLocationLabel;
}

- (UILabel *)appiontmentContentLabel {
    if (!_appiontmentContentLabel) {
        _appiontmentContentLabel = [UILabel labelWithName:@"蹦迪" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _appiontmentContentLabel;
}

- (UILabel *)appiontmentMoneyTitleLabel {
    if (!_appiontmentMoneyTitleLabel) {
        _appiontmentMoneyTitleLabel = [UILabel labelWithName:@"赏金:" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _appiontmentMoneyTitleLabel;
}

- (UILabel *)appiontmentMoneyLabel {
    if (!_appiontmentMoneyLabel) {
        _appiontmentMoneyLabel = [UILabel labelWithName:@"" Font:kSystemFont15 textColor:kRedBackgroundColor textAlignment:NSTextAlignmentLeft];
    }
    return _appiontmentMoneyLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel labelWithName:@"信息失效" Font:kSystemFont14 textColor:kWhiteTextColor textAlignment:NSTextAlignmentCenter];
        _stateLabel.backgroundColor = kGrayBackgroundColor;
        _stateLabel.layer.cornerRadius = kRealValue(10);
        _stateLabel.layer.masksToBounds = YES;
    }
    return _stateLabel;
}

- (UIView *)appiontmentBottomSepLine {
    if (!_appiontmentBottomSepLine) {
        _appiontmentBottomSepLine = [[UIView alloc] init];
        _appiontmentBottomSepLine.backgroundColor = kSepLineGrayBackgroundColor;
    }
    return _appiontmentBottomSepLine;
}

- (UIButton *)checkDetailButton {
    if (!_checkDetailButton) {
        _checkDetailButton = [UIButton buttonWithTitle:@"查看详情" taget:self action:@selector(checkDetailButtonClicked) font:kSystemFont16 titleColor:kPurpleTextColor];
        _checkDetailButton.enabled = NO;
    }
    return _checkDetailButton;
}

- (UIButton *)ignoreButton {
    if (!_ignoreButton) {
        _ignoreButton = [UIButton buttonWithTitle:@"忽略" taget:self action:@selector(ignoreButtonClicked) font:kSystemFont13 titleColor:kPurpleTextColor];
        _ignoreButton.layer.cornerRadius = kRealValue(8);
        _ignoreButton.layer.borderWidth = 1;
        _ignoreButton.layer.borderColor = kPurpleTextColor.CGColor;
        _ignoreButton.hidden = YES;
    }
    return _ignoreButton;
}

- (UIButton *)agreeButton {
    if (!_agreeButton) {
        _agreeButton = [UIButton buttonWithTitle:@"同意约会" taget:self action:@selector(agreeButtonClicked) font:kSystemFont13 titleColor:kWhiteTextColor];
        _agreeButton.layer.cornerRadius = kRealValue(8);
        _agreeButton.backgroundColor = kPurpleTextColor;
        _agreeButton.hidden = YES;
    }
    return _agreeButton;
}

- (void)configureCellByModel:(YTMyDateModel *)model type:(NSString *)type {
    _model = model;
    
    _vipImageView.hidden = !model.VIP;
    
    [_avartarImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    
    _nameLabel.text = model.name;
    
    if (model.gender == 0) {
        _sexImageView.image = [UIImage imageNamed:@"ic_male"];
    } else {
        _sexImageView.image = [UIImage imageNamed:@"ic_female"];
    }
    
    _authLabel.hidden = !model.auth_job || !model.auth_status;
    
    //    if ([model.show1 containsString:@"jpg"]) {
    //        _picimageView.hidden = NO;
    //        [_picimageView sd_setImageWithURL:[NSURL URLWithString:model.show1]];
    //    } else {
    _picimageView.hidden = YES;
    //    }
    
    _postTimeLabel.text = [NSString stringWithFormat:@"发布于：%@",[NSDate dateWithTimestamp:model.publish_time format:@"yyyy-MM-dd HH:mm:ss"]];
    
    
    _appiontmentTimeLabel.text = [model.date_time isEqualToString:@"0"] ? @"约会时间：" : [NSString stringWithFormat:@"约会时间：%@ %@",[NSDate dateWithTimestamp:model.date_time format:@"yyyy-MM-dd"],model.duration];
    
    _appiontmentLocationLabel.text = model.area;
    
    _appiontmentContentLabel.text = model.program_str;
    
    _appiontmentMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.reward];
    
    //own,apply,all
    //    if ([type isEqualToString:@"own"]) {
    //        //我发布的
    //
    //    } else if ([type isEqualToString:@"apply"]) {
    //        //我的报名
    //
    //    } else if ([type isEqualToString:@"all"]) {
    //我的约会
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:model.date_time.doubleValue];
    NSTimeInterval time2 =[date1 timeIntervalSinceNow];
    if (time2 < 0) {
        _stateLabel.hidden = NO;
        self.agreeButton.hidden = YES;
        self.ignoreButton.hidden = YES;
        self.checkDetailButton.hidden = NO;
        _stateLabel.text = @"信息失效";
        _stateLabel.backgroundColor = kGrayBackgroundColor;
    } else {
        _stateLabel.hidden = YES;
        
        if (model.agree_number == 1) {
            _stateLabel.text = @"邀约成功";
            _stateLabel.backgroundColor = kPurpleTextColor;
            _stateLabel.hidden = NO;
        }
        
        if (model.object_id != 0
            && model.userId != [UserInfoManager sharedInstance].ID
            && model.agree_number != 1) {
            //同意 忽略
            self.agreeButton.hidden = NO;
            self.ignoreButton.hidden = NO;
            self.checkDetailButton.hidden = YES;
        } else {
            //查看详情
            self.agreeButton.hidden = YES;
            self.ignoreButton.hidden = YES;
            self.checkDetailButton.hidden = NO;
        }
    }
}

@end
