//
//  YTMineInfoView.m
//  YueTa
//
//  Created by 孙俊 on 2019/1/2.
//  Copyright © 2019 姚兜兜. All rights reserved.
//

#import "YTMineInfoView.h"

@interface YTMineInfoView ()

@property (nonatomic, strong) UIImageView *infoBackgroundImageView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIImageView *vipImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *authLabel;
@property (nonatomic, strong) UILabel *focusLabel;
@property (nonatomic, strong) UILabel *focusNumLabel;
@property (nonatomic, strong) UIButton *myFocusButton;
@property (nonatomic, strong) UILabel *fansLabel;
@property (nonatomic, strong) UILabel *fansNumLabel;
@property (nonatomic, strong) UIButton *myFansButton;
@property (nonatomic, strong) YTImgAlignmentButton *postButton;
@property (nonatomic, strong) YTImgAlignmentButton *myPostButton;
@property (nonatomic, strong) YTImgAlignmentButton *myRegistrationButton;
@property (nonatomic, strong) YTImgAlignmentButton *myDateButton;

@end

@implementation YTMineInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.infoBackgroundImageView];
    [self addSubview:self.shareButton];
    [self addSubview:self.avatarImageView];
    [self addSubview:self.vipImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.authLabel];
    [self addSubview:self.focusLabel];
    [self addSubview:self.focusNumLabel];
    [self addSubview:self.myFocusButton];
    [self addSubview:self.fansLabel];
    [self addSubview:self.fansNumLabel];
    [self addSubview:self.myFansButton];
    [self addSubview:self.postButton];
    [self addSubview:self.myPostButton];
    [self addSubview:self.myRegistrationButton];
    [self addSubview:self.myDateButton];
    
    [self.infoBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.equalTo(@kRealValue(285));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kStatusBarHeight));
        make.right.equalTo(self).offset(-kRealValue(10));
        make.width.and.height.equalTo(@44);
    }];
    
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.and.height.equalTo(@kRealValue(15));
        make.bottom.equalTo(self.avatarImageView.mas_top).offset(kRealValue(8));
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.infoBackgroundImageView).offset(-kRealValue(50));
        make.centerX.equalTo(self);
        make.width.and.height.equalTo(@kRealValue(100));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(kRealValue(10));
        make.centerX.equalTo(self);
        make.height.equalTo(@kRealValue(20));
    }];
    
    [self.authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(kRealValue(15));
        make.width.and.height.equalTo(@kRealValue(20));
    }];
    
    [self.focusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.focusNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.focusLabel);
        make.top.equalTo(self.focusLabel.mas_bottom).offset(kRealValue(10));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.myFocusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.focusLabel);
        make.bottom.equalTo(self.focusNumLabel);
    }];
    
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.mas_centerX);
        make.top.equalTo(self.focusLabel);
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.fansNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.fansLabel);
        make.top.equalTo(self.fansLabel.mas_bottom).offset(kRealValue(10));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.myFansButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.fansLabel);
        make.bottom.equalTo(self.fansNumLabel);
    }];
    
    [self.postButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.focusNumLabel.mas_bottom).offset(kRealValue(30));
        make.left.equalTo(self);
        make.width.equalTo(@(kScreenWidth/4));
        make.height.equalTo(@kRealValue(60));
    }];
    
    [self.myPostButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.equalTo(self.postButton);
        make.left.equalTo(self.postButton.mas_right);
    }];
    
    [self.myRegistrationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.equalTo(self.postButton);
        make.left.equalTo(self.myPostButton.mas_right);
    }];
    
    [self.myDateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.and.height.equalTo(self.postButton);
        make.left.equalTo(self.myRegistrationButton.mas_right);
    }];
}

- (void)buttonClicked:(UIButton *)button {
    if (self.infoClickedBlock) {
        self.infoClickedBlock(button.tag);
    }
}

- (void)shareClicked {
    if (self.shareClickedBlock) {
        self.shareClickedBlock();
    }
}

- (void)avartarTapped {
    if (self.avartarClickedBlock) {
        self.avartarClickedBlock();
    }
}

- (void)myFansButtonClicked {
    if (self.myfansClickedBlock) {
        self.myfansClickedBlock();
    }
}

- (void)myFocusButtonClicked {
    if (self.myfocusClickedBlock) {
        self.myfocusClickedBlock();
    }
}

#pragma mark - **************** Setter Getter
- (UIImageView *)infoBackgroundImageView {
    if (!_infoBackgroundImageView) {
        _infoBackgroundImageView = [[UIImageView alloc] init];
        _infoBackgroundImageView.image = [UIImage imageNamed:@"ic_mine_bg1"];
    }
    return _infoBackgroundImageView;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithImage:@"ic_share" taget:self action:@selector(shareClicked)];
    }
    return _shareButton;
}

- (UIImageView *)vipImageView {
    if (!_vipImageView) {
        _vipImageView = [[UIImageView alloc] init];
        _vipImageView.image = [UIImage imageNamed:@"ic_vip"];
    }
    return _vipImageView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = kRealValue(50);
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.image = [UIImage imageNamed:@"ic_default_head"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avartarTapped)];
        [_avatarImageView addGestureRecognizer:tap];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithName:@"" Font:kSystemFont18 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
    }
    return _nameLabel;
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

- (UILabel *)focusLabel {
    if (!_focusLabel) {
        _focusLabel = [UILabel labelWithName:@"关注" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
    }
    return _focusLabel;
}

- (UILabel *)focusNumLabel {
    if (!_focusNumLabel) {
        _focusNumLabel = [UILabel labelWithName:@"0" Font:kSystemFont15 textColor:kPurpleTextColor textAlignment:NSTextAlignmentCenter];
    }
    return _focusNumLabel;
}

- (UIButton *)myFocusButton {
    if (!_myFocusButton) {
        _myFocusButton = [[UIButton alloc] init];
        [_myFocusButton addTarget:self action:@selector(myFocusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myFocusButton;
}

- (UILabel *)fansLabel {
    if (!_fansLabel) {
        _fansLabel = [UILabel labelWithName:@"粉丝" Font:kSystemFont15 textColor:kBlackTextColor textAlignment:NSTextAlignmentCenter];
    }
    return _fansLabel;
}

- (UILabel *)fansNumLabel {
    if (!_fansNumLabel) {
        _fansNumLabel = [UILabel labelWithName:@"0" Font:kSystemFont15 textColor:kPurpleTextColor textAlignment:NSTextAlignmentCenter];
    }
    return _fansNumLabel;
}

- (UIButton *)myFansButton {
    if (!_myFansButton) {
        _myFansButton = [[UIButton alloc] init];
        [_myFansButton addTarget:self action:@selector(myFansButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myFansButton;
}

- (YTImgAlignmentButton *)postButton {
    if (!_postButton) {
        _postButton = [[YTImgAlignmentButton alloc] init];
        [_postButton setTitle:@"发布约会" forState:UIControlStateNormal];
        [_postButton setImage:[UIImage imageNamed:@"ic_release"] forState:UIControlStateNormal];
        _postButton.imageViewAlignment = ImageViewAlignmentTop;
        _postButton.intervalImgToTitle = kRealValue(6);
        _postButton.titleLabel.font = kSystemFont15;
        [_postButton setTitleColor:kGrayTextColor forState:UIControlStateNormal];
        _postButton.tag = YTMineInfoTypePost;
        [_postButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postButton;
}

- (YTImgAlignmentButton *)myPostButton {
    if (!_myPostButton) {
        _myPostButton = [[YTImgAlignmentButton alloc] init];
        [_myPostButton setTitle:@"我发布的" forState:UIControlStateNormal];
        [_myPostButton setImage:[UIImage imageNamed:@"ic_my_re"] forState:UIControlStateNormal];
        _myPostButton.imageViewAlignment = ImageViewAlignmentTop;
        _myPostButton.intervalImgToTitle = kRealValue(6);
        _myPostButton.titleLabel.font = kSystemFont15;
        [_myPostButton setTitleColor:kGrayTextColor forState:UIControlStateNormal];
        _myPostButton.tag = YTMineInfoTypeMyPost;
        [_myPostButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myPostButton;
}

- (YTImgAlignmentButton *)myRegistrationButton {
    if (!_myRegistrationButton) {
        _myRegistrationButton = [[YTImgAlignmentButton alloc] init];
        [_myRegistrationButton setTitle:@"我报名的" forState:UIControlStateNormal];
        [_myRegistrationButton setImage:[UIImage imageNamed:@"ic_book"] forState:UIControlStateNormal];
        _myRegistrationButton.imageViewAlignment = ImageViewAlignmentTop;
        _myRegistrationButton.intervalImgToTitle = kRealValue(6);
        _myRegistrationButton.titleLabel.font = kSystemFont15;
        [_myRegistrationButton setTitleColor:kGrayTextColor forState:UIControlStateNormal];
        _myRegistrationButton.tag = YTMineInfoTypeMyRegistration;
        [_myRegistrationButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myRegistrationButton;
}

- (YTImgAlignmentButton *)myDateButton {
    if (!_myDateButton) {
        _myDateButton = [[YTImgAlignmentButton alloc] init];
        [_myDateButton setTitle:@"我的约会" forState:UIControlStateNormal];
        [_myDateButton setImage:[UIImage imageNamed:@"ic_smile"] forState:UIControlStateNormal];
        _myDateButton.imageViewAlignment = ImageViewAlignmentTop;
        _myDateButton.intervalImgToTitle = kRealValue(6);
        _myDateButton.titleLabel.font = kSystemFont15;
        [_myDateButton setTitleColor:kGrayTextColor forState:UIControlStateNormal];
        _myDateButton.tag = YTMineInfoTypeMyDate;
        [_myDateButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myDateButton;
}

- (void)setUserModel:(YTUserModel *)userModel {
    _userModel = userModel;
    
    self.vipImageView.hidden = !userModel.VIP;
    
    if (userModel.photo) {
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userModel.photo]];
    } else {
        _avatarImageView.image = [UIImage imageNamed:@"ic_default_head"];
    }
    
    _nameLabel.text = userModel.username;
 
    _authLabel.hidden = !userModel.auth_status;
}

- (void)setFansNumber:(NSString *)fansNumber {
    _fansNumber = fansNumber;
    
    _fansNumLabel.text = fansNumber;
}

- (void)setLikedNumber:(NSString *)likedNumber {
    _likedNumber = likedNumber;
    
    _focusNumLabel.text = likedNumber;
}

@end
