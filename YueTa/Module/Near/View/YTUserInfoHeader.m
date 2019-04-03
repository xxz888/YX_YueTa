//
//  YTUserInfoHeader.m
//  YueTa
//
//  Created by Awin on 2019/1/30.
//  Copyright © 2019年 姚兜兜. All rights reserved.
//

#import "YTUserInfoHeader.h"
#import "NearUserInfo.h"

@interface YTUserInfoHeader ()

@property (nonatomic, strong) UIImageView *header;
@property (nonatomic, strong) UIImageView *VIPImg;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *workRound;//职位认证

@property (nonatomic, strong) UIImageView *genderImg;
@property (nonatomic, strong) UILabel *ageLab;
@property (nonatomic, strong) UILabel *workLab;
@property (nonatomic, strong) UILabel *educationLab;

@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *distanceLab;
@property (nonatomic, strong) UILabel *timeLab;

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIView *line;

@end

@implementation YTUserInfoHeader

- (instancetype)init {
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kRealValue(90));
        self.backgroundColor = kWhiteBackgroundColor;
        
        [self createUI];
    }
    return self;
}

- (void)likeButtonClick:(UIButton *)button {
    if (self.block) {
        self.block(button);
    }
}

- (void)createUI {
    
    [self addSubview:self.header];
    [self addSubview:self.VIPImg];
    
    [self addSubview:self.nameLab];
    [self addSubview:self.workRound];
    
    [self addSubview:self.genderImg];
    [self addSubview:self.ageLab];
    [self addSubview:self.workLab];
    [self addSubview:self.educationLab];
    
    [self addSubview:self.locationImg];
    [self addSubview:self.distanceLab];
    [self addSubview:self.timeLab];
    
    [self addSubview:self.likeBtn];
    [self addSubview:self.line];
    
    self.header.frame = CGRectMake(kRealValue(10), kRealValue(20), kRealValue(60), kRealValue(60));
    
    self.VIPImg.frame = CGRectMake(0, kRealValue(15), kRealValue(20), kRealValue(20));
    self.VIPImg.centerX = self.header.centerX;
    
    self.nameLab.frame = CGRectMake(self.header.right+kRealValue(10), self.header.y, kScreenWidth-kRealValue(110), kRealValue(18));
    
    self.workRound.frame = CGRectMake(self.nameLab.right, 0, kRealValue(15), kRealValue(15));
    self.workRound.centerY = self.nameLab.centerY;
    self.workRound.layer.cornerRadius = self.workRound.height/2;
    
    self.genderImg.frame = CGRectMake(self.nameLab.x, self.nameLab.bottom+kRealValue(5), kRealValue(15), kRealValue(15));
    
    self.ageLab.frame = CGRectMake(self.genderImg.right+kRealValue(5), 0, kRealValue(40), kRealValue(18));
    self.ageLab.centerY = self.genderImg.centerY;
    
    self.workLab.frame = CGRectMake(self.ageLab.right, 0, kRealValue(40), kRealValue(18));
    self.workLab.centerY = self.genderImg.centerY;
    
    self.educationLab.frame = CGRectMake(self.workLab.right, 0, kRealValue(40), kRealValue(18));
    self.educationLab.centerY = self.genderImg.centerY;
    
    self.locationImg.frame = CGRectMake(self.nameLab.x, self.genderImg.bottom+kRealValue(5), kRealValue(15), kRealValue(15));
    
    self.distanceLab.frame = CGRectMake(self.locationImg.right, 0, kRealValue(60), kRealValue(18));
    self.distanceLab.centerY = self.locationImg.centerY;
    
    self.timeLab.frame = CGRectMake(self.distanceLab.right, 0, kRealValue(100), kRealValue(18));
    self.timeLab.centerY = self.locationImg.centerY;
    
    self.likeBtn.frame = CGRectMake(kScreenWidth-kRealValue(60), 0, kRealValue(30), kRealValue(30));
    self.likeBtn.centerY = self.height/2;
    
    self.line.frame = CGRectMake(kRealValue(10), self.height-0.5, kScreenWidth-kRealValue(20), 0.5);
    
}

- (void)loadDataWithModel:(id)model {
    NearUserInfo *myModel = (NearUserInfo *)model;
    
    if (myModel.photo.length) {
        [self.header sd_setImageWithURL:[NSURL URLWithString:myModel.photo] placeholderImage:KimageName(@"ic_head_pink")];
    }
    
    if (myModel.gender == 0) {
        self.genderImg.image = KimageName(@"ic_male");
    } else {
        self.genderImg.image = KimageName(@"ic_female");
    }
    
    self.nameLab.text = myModel.username;
    
    [self.nameLab sizeToFit];
    self.workRound.x = self.nameLab.right + kRealValue(10);
    
    if (myModel.VIP) {
        self.VIPImg.hidden = NO;
    } else {
        self.VIPImg.hidden = YES;
    }
    
    if (myModel.auth_job) {
        self.workRound.hidden = NO;
    } else {
        self.workRound.hidden = YES;
    }
    
    self.ageLab.text = [NSString stringWithFormat:@"%ld",myModel.age];
    
    self.workLab.text = myModel.job;
    
    self.educationLab.text = myModel.city;
    
    NSInteger distance = myModel.distance.integerValue / 1000;
    self.distanceLab.text = [NSString stringWithFormat:@"%ldkm",distance];
    
    NSInteger hour = myModel.finally_on_line / 3600;
    if (hour < 1) {
        self.timeLab.text = @"刚刚在线";
    } else {
        self.timeLab.text = [NSString stringWithFormat:@"%ld小时前在线",hour];
    }
    
    if (myModel.like == 1) {
        [self.likeBtn setBackgroundImage:KimageName(@"ic_follow") forState:UIControlStateNormal];
    } else {
        [self.likeBtn setBackgroundImage:KimageName(@"ic_un_follow") forState:UIControlStateNormal];
    }
}

#pragma mark - lazy init
- (UIImageView *)header {
    if (!_header) {
        _header = [[UIImageView alloc] init];
        _header.layer.masksToBounds = YES;
        _header.contentMode = UIViewContentModeScaleAspectFill;
        _header.clipsToBounds = YES;
        _header.image = KimageName(@"ic_head_pink");
    }
    return _header;
}

- (UIImageView *)VIPImg {
    if (!_VIPImg) {
        _VIPImg = [[UIImageView alloc] init];
        _VIPImg.image = KimageName(@"ic_vip");
    }
    return _VIPImg;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel labelWithName:@"" Font:kSystemFont14 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _nameLab;
}

- (UILabel *)workRound {
    if (!_workRound) {
        _workRound = [UILabel labelWithName:@"职" Font:kSystemFont10 textColor:kWhiteTextColor textAlignment:NSTextAlignmentCenter];
        _workRound.backgroundColor = RGB(254, 200, 47);
        _workRound.layer.masksToBounds = YES;
    }
    return _workRound;
}

- (UIImageView *)genderImg {
    if (!_genderImg) {
        _genderImg = [[UIImageView alloc] init];
        _genderImg.image = KimageName(@"ic_male"); // ic_female
    }
    return _genderImg;
}

- (UILabel *)ageLab {
    if (!_ageLab) {
        _ageLab = [UILabel labelWithName:@"" Font:kSystemFont13 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _ageLab;
}

- (UILabel *)workLab {
    if (!_workLab) {
        _workLab = [UILabel labelWithName:@"" Font:kSystemFont13 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _workLab;
}

- (UILabel *)educationLab {
    if (!_educationLab) {
        _educationLab = [UILabel labelWithName:@"" Font:kSystemFont13 textColor:kBlackTextColor textAlignment:NSTextAlignmentLeft];
    }
    return _educationLab;
}

- (UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] init];
        _locationImg.image = KimageName(@"ic_location");
    }
    return _locationImg;
}

- (UILabel *)distanceLab {
    if (!_distanceLab) {
        _distanceLab = [UILabel labelWithName:@"距离" Font:kSystemFont12 textColor:kDarkGrayTextColor textAlignment:NSTextAlignmentCenter];
    }
    return _distanceLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel labelWithName:@"时间" Font:kSystemFont12 textColor:RGB(225, 163, 135) textAlignment:NSTextAlignmentLeft];
    }
    return _timeLab;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithBackgroundImage:@"ic_un_follow" taget:self action:@selector(likeButtonClick:)];
    }
    return _likeBtn;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = kGrayBorderColor;
    }
    return _line;
}

@end
